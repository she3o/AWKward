#!/usr/bin/awk -f

# Second.md

{
    line = $0
    output = ""
    while (match(line, /!\[([^\]]+)\]\(([^\)]+)\)/, arr)) {
        alt = arr[1]
        url = arr[2]
        start = RSTART
        len = RLENGTH
        # Check if the URL already has query parameters
        if (url ~ /\?/) {
            url = url "&style=flat-square"
        } else {
            url = url "?style=flat-square"
        }
        # Reconstruct the modified image link
        imagelink = "![" alt "](" url ")"
        # Build the output line
        output = output substr(line, 1, start - 1) imagelink
        # Prepare the remaining line for further processing
        line = substr(line, start + len)
    }
    # Append any remaining text after the last match
    output = output line
    print output
}

