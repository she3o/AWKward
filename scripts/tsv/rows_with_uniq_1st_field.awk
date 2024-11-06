#!/usr/bin/awk -f
{
    if (!seen[$1]++) {
        print $0
    }
}
