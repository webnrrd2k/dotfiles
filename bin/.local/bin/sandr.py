#!/usr/bin/env -S uv run --script
#
# /// script
# ///
#!/usr/bin/env python3




#####!/usr/bin/env python3

import sys
import argparse

def main():
    parser = argparse.ArgumentParser(description="Search/Replace and add Prefixes/Suffixes to text lines.")

    # Prefix/Suffix arguments
    parser.add_argument("--pre", help="String to add BEFORE each line", default="")
    parser.add_argument("--post", help="String to add AFTER each line", default="")

    # Search and Replace arguments
    parser.add_argument("--find", help="The string you want to find", default=None)
    parser.add_argument("--replace", help="The string to replace it with", default=None)

    # File input argument (optional, defaults to stdin)
    parser.add_argument(
        "infile",
        nargs="?",
        type=argparse.FileType('r'),
        default=sys.stdin,
        help="Input file (defaults to stdin if omitted)"
    )

    args = parser.parse_args()

    try:
        # User hint for manual typing
        if args.infile.isatty():
            print("Enter text (Press Ctrl+D or Ctrl+Z to finish):", file=sys.stderr)

        #for line in sys.stdin:
        for line in args.infile:

            # 1. Remove the newline for processing
            content = line.rstrip('\n\r')
            content = content.strip()
            if content == "":
                continue

            # 2. Perform Search and Replace if --find and --replace is provided
            if (args.find is not None) and (args.replace is not None):
                content = content.replace(args.find, args.replace)

            prefix = args.pre + " " if args.pre else ""
            suffix = " " + args.post if args.post else ""


            # 3. Apply prefix/suffix and print
            print(f"{prefix}{content}{suffix}")

    except KeyboardInterrupt:
        sys.exit(0)
    finally:
        if args.infile is not sys.stdin:
            args.infile.close()

if __name__ == "__main__":
    main()
