#!/bin/bash
# bn utility that returns the ranking for a given baby name in a given year based on gender
# Andy Pak, McMaster University, 2024

rank() {
    # TODO given name, year, and gender, return rank
    echo "TODO"
}

usage() {
    echo "Usage: bn <year> <assigned gender: f|F|m|M|b|B>" >&2
    echo "Try 'bn --help' for more information." >&2
}

help() {
    echo "Usage: bn <year> <assigned gender: f|F|m|M|b|B>"
    echo ""
    echo "Arguments: "
    echo "  year        A 4-digit year from 1880 to 2024"
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

if ! [[ "$year" =~ ^[0-9]{4}$ && "$year" -gt 1879 && "$year" -lt 2025 ]]
then
    echo "Error: Year must be 4-digit between 1880 to 2024" >&2
    usage
    exit 2
fi

if ! [[ "$gender" =~ ^[fFmMbB]$ ]]
then
    echo "Error: Gender can be f, m, F, M, b, or B" >&2
    usage
    exit 2
fi

