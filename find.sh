#!/usr/bin/env bash
set -u

# ========================================
# Functions

# --------------------------------
fUsage() {
    cat <<EOF
find.sh - find words in biblio.txt
Usage
    find.sh [-i word]
    find.sh word word ...
Options
    -i word - find "Id: word"
    word... - find "Title: word|word|word"
EOF
    exit 1
} # fUsage

# ========================================
# Main

# -------------------
# Get Args Section
if [ $# -eq 0 ]; then
    fUsage
fi

export gpId="";
export gpList=""
while getopts :i:th tArg; do
    case $tArg in
        # Script arguments
        i) gpId="$OPTARG" ;;
        # Common arguments
        h)
            fUsage
            exit 1
            ;;
        # Problem arguments
        :) echo "Value required for option: -$OPTARG"
           exit 1
        ;;
        \?) echo "Unknown option: $OPTARG"
            exit 1
        ;;
    esac
done
((--OPTIND))
shift $OPTIND
if [ $# -ne 0 ]; then
    gpList="$*"
fi
while [ $# -ne 0 ]; do
    shift
done

# --------------------
# Functional section

if [[ -n "$gpId" ]]; then
    grep -A9 -i "^Id: $gpId" biblio.txt
fi

if [[ -n "$gpList" ]]; then
    tList=$(echo $gpList | tr ' ' '|')
    grep -B4 -A6 -Ei "$tList" biblio.txt
fi
