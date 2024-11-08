#!/bin/awk -f

# First.awk

# Function to extract the GitHub repo name from the URL
function extract_repo(url,    arr) {
    # Match the GitHub repository name pattern (username/repo)
    match(url, /https:\/\/github\.com\/([^\/]+\/[^\/]+)/, arr)
    if (arr[1] != "") {
        return arr[1]  # Return the matched GitHub repository name
    }
    return ""  # Return an empty string if the URL doesn't match
}

# Check each line in the README.md
{
    # Match lines with GitHub repo URLs (check for 'github.com')
    if ($0 ~ /https:\/\/github\.com\//) {
        # Extract the GitHub URL part from the line
        match($0, /https:\/\/github\.com\/[^ ]+/)  # Match the URL
        repo_url = substr($0, RSTART, RLENGTH)  # Extract the matched URL part
        repo_name = extract_repo(repo_url)  # Extract the repository name

        # If a valid repo name is found, print badges
        if (repo_name != "") {
            # Print the original line
            print $0

            # Add shields.io badges for last commit and license
            print ""
            print "  ![Last Commit](https://img.shields.io/github/last-commit/" repo_name
            print "![License](https://img.shields.io/github/license/" repo_name
            print "![Issues](https://img.shields.io/github/issues/" repo_name
            print "![Stars](https://img.shields.io/github/stars/" repo_name
            print "![Forks](https://img.shields.io/github/forks/" repo_name
            print ""
        } else {
            # If no valid repo found, just print the original line
            print $0
        }
    } else {
        # Print non-matching lines as is
        print $0
    }
}

