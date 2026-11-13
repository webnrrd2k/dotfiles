#!/usr/bin/env python3

# import sys
#
# def main():
#     # Define the prefix
#     prefix = "<string> "
#
#     # Check if input is coming from a terminal (interactive)
#     # to provide a helpful hint to the user.
#     if sys.stdin.isatty():
#         print("Enter your text (Press Ctrl+D or Ctrl+Z to finish):")
#
#     # Read line by" line from standard input
#     for line in sys.stdin:
#         # Print the prefix + the original line
#         # line already contains a newline character
#         sys.stdout.write(prefix + line)
#
# if __name__ == "__main__":
#     main()
import sys
import argparse

def main():
    # Set up command line argument parsing
    parser = argparse.ArgumentParser(description="Add a prefix or suffix to multiple lines of text.")
    parser.add_argument("--pre", help="String to add BEFORE each line")
    parser.add_argument("--post", help="String to add AFTER each line")

    args = parser.parse_args()

    # Inform the user how to exit if they are typing manually
    if sys.stdin.isatty():
        print("Enter text (Press Ctrl+D or Ctrl+Z to finish):", file=sys.stderr)

    # Process input line by line
    for line in sys.stdin:
        # Strip the trailing newline to control placement of --post
        clean_line = line.rstrip('\n\r')

        prefix = args.pre + " " if args.pre else ""
        suffix = " " + args.post if args.post else ""

        # Construct and print the new line
        if len(clean_line) > 0:
                print(f"{prefix}{clean_line}{suffix}")

if __name__ == "__main__":
    main()
