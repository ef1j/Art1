#! /bin/bash
# runart1.sh
# shell script to run art1 and
# create pdf output with enscript and ps2pdf
#
# E. M. Furst 2022
#
# enscript uses a custom paper width. Add the
# following line to ~/.enscriptrc:
# Media: Art1 1044 792 30 40 1014 752

# default values
#FONT="Courier"
FONT="IBMPlexMono-Thin"

# process command line flags here
# use colon if argument expected
usage() { echo "$0 usage: [-f font] cardfile.25" && grep " .)\ #" $0; exit 0; }
[ $# -eq 0 ] && usage

while getopts f: flag
do
    case "${flag}" in
        f) case "${OPTARG}" in
	      1) FONT="IBMPlexMono-Thin";;
	      2) FONT="IBMPlexMono-ExtraLight";;
	      3) FONT="IBMPlexMono-Light";;
	      4) FONT="IBMPlexMono-Regular";;
	      c) FONT="Courier";;
	   esac
	;;
    esac
done
shift $((OPTIND -1))

if [[ -f "$1" ]]; then
#    echo "Reading "$1"..."
    name=${1%.25}
    art1 < $1 | asa > $name".txt"
#    echo "Art1 output created."
    enscript -c -q -B -M Art1 -f $FONT"12/11" -o - $name".txt" | ps2pdf - $name".pdf"
else
    echo "$1 does not exist."
fi
