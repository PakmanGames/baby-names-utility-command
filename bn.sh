#!/bin/bash

rank() {
    # TODO given name, year, and gender, return rank
    echo "TODO"
}

usage() {
    echo "Usage: bn <year> <assigned gender: f|F|m|M|b|B>" >&2
    echo "Try 'bn --help' for more information." >&2
}

help() {
    # TODO output help to stdout
    echo "TODO"
}

if [[ "$#" -eq 0 ]]
then
    echo "Wrong number of arguments" >&2
    usage
    exit 1
fi