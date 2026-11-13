# File tagging via the user.xdg.tags extended attribute (comma-separated list).
# Same attribute KDE Dolphin/Baloo uses, so tags are visible there too.
#
#   addtag TAG [...] FILE           add tags   (or: addtag TAG [...] -- FILE [...])
#   removetag TAG [...] FILE        remove exact tags (same "--" form for many files)
#   showtag FILE [...]              list tags, one per line
#   cleantag FILE [...]             dedupe/trim/sort a file's tags
#   findtag TAG [...] [DIR]         files under DIR (default .) having ALL tags, case-insensitive
#   lstags [DIR]                    every tag in use under DIR, with counts

_TAG_ATTR=user.xdg.tags

# Print a file's tags, one per line (trimmed, no empties).
_tags_read() {
    # --only-values prints no trailing newline; add one so appended tags don't merge.
    { getfattr --only-values -n "$_TAG_ATTR" -- "$1" 2>/dev/null; echo; } |
        tr ',' '\n' | sed 's/^[[:space:]]*//; s/[[:space:]]*$//; /^$/d'
}

# Write tags from stdin (one per line) to a file; removes the attribute if none remain.
_tags_write() {
    local file=$1 value
    value=$(sed 's/^[[:space:]]*//; s/[[:space:]]*$//; /^$/d' | sort -u | paste -sd, -)
    if [[ -n $value ]]; then
        setfattr -n "$_TAG_ATTR" -v "$value" -- "$file"
    else
        setfattr -x "$_TAG_ATTR" -- "$file" 2>/dev/null
        return 0
    fi
}

# Split "TAG... FILE" or "TAG... -- FILE..." into _tag_list and _tag_files.
_tags_split_args() {
    _tag_list=() _tag_files=()
    local i joined
    for ((i = 1; i <= $#; i++)); do
        if [[ ${!i} == -- ]]; then
            _tag_list=("${@:1:i-1}")
            _tag_files=("${@:i+1}")
            break
        fi
    done
    if ((${#_tag_files[@]} == 0)); then
        _tag_list=("${@:1:$#-1}")
        _tag_files=("${!#}")
    fi
    # Allow "a,b" as a single argument.
    joined=$(IFS=,; echo "${_tag_list[*]}")
    IFS=, read -ra _tag_list <<<"$joined"
}

addtag() {
    if (($# < 2)); then echo "Usage: addtag TAG [...] FILE  |  addtag TAG [...] -- FILE [...]" >&2; return 1; fi
    _tags_split_args "$@"
    local f rc=0
    for f in "${_tag_files[@]}"; do
        [[ -e $f ]] || { echo "addtag: not found: $f" >&2; rc=1; continue; }
        { _tags_read "$f"; printf '%s\n' "${_tag_list[@]}"; } | _tags_write "$f" || rc=1
    done
    return $rc
}

removetag() {
    if (($# < 2)); then echo "Usage: removetag TAG [...] FILE  |  removetag TAG [...] -- FILE [...]" >&2; return 1; fi
    _tags_split_args "$@"
    local f rc=0
    for f in "${_tag_files[@]}"; do
        [[ -e $f ]] || { echo "removetag: not found: $f" >&2; rc=1; continue; }
        _tags_read "$f" | grep -vxF -f <(printf '%s\n' "${_tag_list[@]}") | _tags_write "$f" || rc=1
    done
    return $rc
}

showtag() {
    if (($# < 1)); then echo "Usage: showtag FILE [...]" >&2; return 1; fi
    local f tags
    for f in "$@"; do
        [[ -e $f ]] || { echo "showtag: not found: $f" >&2; continue; }
        tags=$(_tags_read "$f")
        (($# > 1)) && echo "$f:"
        if [[ -z $tags ]]; then
            echo "  (no tags)"
        elif (($# > 1)); then
            sed 's/^/  /' <<<"$tags"
        else
            echo "$tags"
        fi
    done
}

cleantag() {
    if (($# < 1)); then echo "Usage: cleantag FILE [...]" >&2; return 1; fi
    local f
    for f in "$@"; do
        [[ -e $f ]] || { echo "cleantag: not found: $f" >&2; continue; }
        getfattr -n "$_TAG_ATTR" -- "$f" &>/dev/null || continue
        _tags_read "$f" | _tags_write "$f"
    done
}

# Print "path<TAB>tag,tag" for every tagged file under a directory,
# using one recursive getfattr call instead of a process per file.
_tags_dump() {
    getfattr -R --absolute-names -m "^${_TAG_ATTR//./\\.}\$" -d -- "$1" 2>/dev/null |
        awk -v attr="$_TAG_ATTR" '
            /^# file: / { file = substr($0, 9); next }
            index($0, attr "=") == 1 {
                v = substr($0, length(attr) + 2); gsub(/^"|"$/, "", v)
                print file "\t" v
            }'
}

findtag() {
    if (($# < 1)); then echo "Usage: findtag TAG [...] [DIR]" >&2; return 1; fi
    local dir=. tags=("$@")
    if (($# > 1)) && [[ -d ${!#} ]]; then
        dir=${!#}
        tags=("${@:1:$#-1}")
    fi
    _tags_dump "$dir" | awk -F'\t' -v want="$(printf '%s,' "${tags[@]}")" '
        BEGIN { n = split(tolower(want), w, ",") }
        {
            split(tolower($2), have, ",")
            delete h
            for (i in have) { t = have[i]; gsub(/^[ \t]+|[ \t]+$/, "", t); h[t] = 1 }
            for (i = 1; i <= n; i++) if (w[i] != "" && !(w[i] in h)) next
            print $1
        }'
}

lstags() {
    _tags_dump "${1:-.}" | cut -f2 | tr ',' '\n' |
        sed 's/^[[:space:]]*//; s/[[:space:]]*$//; /^$/d' | sort | uniq -c | sort -rn
}
