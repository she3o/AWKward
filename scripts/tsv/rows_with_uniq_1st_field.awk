#!/usr/bin/awk -f
{
    key = $1
    len = length($0)
    if (!(key in min_len) || len < min_len[key]) {
        min_len[key] = len
        min_line[key] = $0
    }
}

END {
    for (key in min_line) {
        print min_line[key]
    }
}
