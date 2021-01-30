#! /bin/bash
# uninmize.sh
# shell script to run art11
# E. M. F. 2021
#
if [[ $# -ne 1 ]]; then
    echo 'usage: unm filename.25'
    exit 1
fi

if [[ -f "$1" ]]; then
    echo "Reading "$1"..."
    name=${1%.25}
    art1 < $1 | asa > $name".txt"
    echo "Art11 output created."
    python3 ibm1403fort.py $name".txt"
else
    echo "$1 does not exist."
fi

