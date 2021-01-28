#! /bin/bash
# uninmize.sh
# shell script to run art11
# E. M. F. 2021
#
if [[ $# -ne 1 ]]; then
    echo 'usage: uninmize filename.25'
    exit 1
fi

if [[ -f "$1" ]]; then
    echo "Reading "$1"..."
    name=${1%.25}
    cp $1 fort.25
    art11 > $name".tmp"
    asa $name".tmp" > $name".txt"
    echo "Art11 output generated."
    python3 ibm1403fort.py $name".txt"
    mv $name".tmp" $name".txt"
else
    echo "$1 does not exist."
fi

