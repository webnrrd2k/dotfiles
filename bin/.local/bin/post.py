#!/usr/bin/env -S uv run --script
#
# /// script
# ///
#!/usr/bin/env python3
import sys
import argparse

def main():

    # Set up command line argument parsing
    parser = argparse.ArgumentParser(description="Add a prefix or suffix to multiple lines of text.")

    parser.add_argument("--nospace", help="Don't automatically add spaces between pre or post", default=None)
    parser.add_argument("--pre", help="String to add BEFORE each line")
    parser.add_argument("--post", help="String to add AFTER each line")
    parser.add_argument("--preincr", help="Add incremented number BEFORE each line")
    parser.add_argument("--postincr", help="Add incremented number AFTER each line")
    # This is the first positional argument, used if none of the parser.add_argument args exist (e.g. echo "POW!" | pre.py BLAH => BLAH POW!)
    parser.add_argument(
        "first_arg",
        nargs="?",
        help="used when no command line arguments are given"
    )

    args = parser.parse_args()

    # Inform the user how to exit if they are typing manually
    if sys.stdin.isatty():
        print("Enter text (Press Ctrl+D or Ctrl+Z to finish):", file=sys.stderr)

    # Process input line by line
    i = 1
    for line in sys.stdin:
        # Strip the trailing newline to control placement of --post
        clean_line = line.rstrip('\n\r')
        clean_line = line.strip()
        postfix = ""

        if args.first_arg:
            if not args.nospace:
                postfix = " " + args.first_arg
            else:
                postfix = args.first_arg


        elif args.post:
            if args.nospace:
                postfix= args.post
            else:
                postfix = " " + args.post

        if args.postincr:
            postfix = postfix + "_" + str(i)

        # Construct and print the new line
        if len(clean_line) > 0:
                i += 1
                print(f"{clean_line}{postfix}")

if __name__ == "__main__":
    main()
