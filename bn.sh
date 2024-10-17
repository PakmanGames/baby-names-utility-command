#!/bin/bash
# bn utility that returns the ranking for a given baby name in a given year based on gender
# Andy Pak, McMaster University, 2024

get_ranking_for_gender() {
    local name="$1"
    local file="$2"
    local gender="$3"

    # lucy 44/942 in 1880
    # cat ./us_baby_names/yob1880.txt | grep -P ",F," | wc -l
    # cat ./us_baby_names/yob1880.txt | grep -P -i "^Lucy," | grep -P ",F,"
    local total_names=$(cat "$file" | grep -P -i ",$gender," | wc -l)
    local entry=$(cat "$file" | grep -P -i "^$name," | grep -P -i ",$gender,")
    echo "total $gender names is $total_names" # testing
    echo "the entry is $entry" # testing
}

rank() {
    local name="$1"
    local year="$2"
    local gender="$3"
    
    local file="./us_baby_names/yob$year.txt"
    if ! [[ -f $file ]]
    then
        echo "No data for $year" >&2
        exit 4
    fi
    
    if [[ "$gender" =~ [bB] ]]
    then
        get_ranking_for_gender "$name" "$file" "F"
        get_ranking_for_gender "$name" "$file" "M"
    else
        get_ranking_for_gender "$name" "$file" "$gender"
    fi
}

usage() {
    echo "Usage: bn <year> <assigned gender: f|F|m|M|b|B>" >&2
    echo "Try 'bn --help' for more information." >&2
}

help() {
    echo "Usage: bn <year> <assigned gender: f|F|m|M|b|B>"
    echo ""
    echo "Arguments: "
    echo "  year        A 4-digit year from 1800 to 2024"
    echo "  gender      A single character, f, F, m, M, b, or B"
    echo ""
    echo "Flags: "
    echo "  --help      A linux style help"
    exit 0
}

if [[ "$#" -eq 0 ]]
then
    echo "No arguments given" >&2
    usage
    exit 1
elif [[ "$1" != "--help" && "$#" -ne 2 ]]
then
    echo "Wrong number of arguments" >&2
    usage
    exit 1
fi

if [[ "$1" == "--help" ]]
then
    help
fi

year="$1"
gender="$2"

if ! [[ "$year" =~ ^[0-9]{4}$ && "$year" -gt 1799 && "$year" -lt 2025 ]]
then
    echo "Error: Year must be 4-digit between 1800 to 2024" >&2
    usage
    exit 2
fi

if ! [[ "$gender" =~ ^[fFmMbB]$ ]]
then
    echo "Badly formatted assigned gender: $gender"
    echo "Error: Gender can be f, m, F, M, b, or B" >&2
    usage
    exit 2
fi

# main part of program
while read name
do
    if ! [[ $name =~ ^[a-zA-Z]+$ ]]
    then
        echo "Badly formatted name: $name" >&2
        exit 3
    fi
    rank "$name" "$year" "$gender"
done