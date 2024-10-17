#!/bin/bash
# bn utility that returns the ranking for a given baby name in a given year based on gender
# Andy Pak, McMaster University, 2024
# Additional sources used to learn about cut command for determining the name ranking: https://www.geeksforgeeks.org/cut-command-linux-examples/

####################
# Gets the ranking of a name and outputs to stdout a formatted output
# Globals: none
# Arguments: $1 = name, $2 = file relative path name, $3 = gender
# Outputs: echos a formatted string to stdout, if name not found, error to stderr and exit code 3
# Returns: N.A.
####################
get_ranking_for_gender() {
    local name="$1"
    local file="$2"
    local gender="$3"

    # Get total number of F or M gender names
    local total_names=$(cat "$file" | grep -P -i ",$gender," | wc -l)
    # Find the entry for the name and specified gender
    local entry=$(cat "$file" | grep -P -i "^$name," | grep -P -i ",$gender,")

    # Check name is found among F or M gender names
    if [[ -n "$entry" ]]; then
        local rank=$(cat "$file" | grep -P -i ",$gender," | grep -P -ni "^$name," | cut -d':' -f1)

        echo "$year: $name ranked $rank out of $total_names $gender names."
    else
        echo "$year: $name not found among $gender names." >&2
        exit 3
    fi
}

####################
# Formats the relative file path and calls get_ranking_for_gender based on the passed gender
# Globals: none
# Arguments: $1 = name, $2 = year, $3 = gender
# Outputs: If file doesn't exist, error message to stderr and exit code 4
# Returns: N.A.
####################
rank() {
    local name="$1"
    local year="$2"
    local gender="$3"
    
    local file="./us_baby_names/yob$year.txt"
    
    # Checks if the file path exists (If there's data for the given year)
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

####################
# Outputs the propper usage of the bn utility command
# Globals: none
# Arguments: none
# Outputs: echos multiple strings to stdout for the propper way to use bn
# Returns: N.A.
####################
usage() {
    echo "Usage: bn <year> <assigned gender: f|F|m|M|b|B>" >&2
    echo "Try 'bn --help' for more information." >&2
}

####################
# Outputs help information to stdout
# Globals: none
# Arguments: none
# Outputs: echos multiple strings to stdout for how to use bn, exit code 0
# Returns: N.A.
####################
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

# Checks if correct number of arguments passed
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

# Checks if inputs are in correct format
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

# Loops for each name passed it ranks it
while read name
do
    # Checks if name isn't correct format
    if ! [[ $name =~ ^[a-zA-Z]+$ ]]
    then
        echo "Badly formatted name: $name" >&2
        exit 3
    fi
    rank "$name" "$year" "$gender"
done