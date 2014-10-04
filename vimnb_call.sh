#!/bin/bash

# Inspired by the pipe2eval plugin for vim

INPUT_FILE="$1"
INPUT_FILE_BASE=$(basename "${INPUT_FILE}")

if [ -z "$VIMNB_TMP_FILE_PATH" ]; then
	VIMNB_TMP_FILE_PATH=/dev/shm/
fi
PREFIX=repl
TMP_FILE="${VIMNB_TMP_FILE_PATH}${PREFIX}_${INPUT_FILE_BASE}"

tee $TMP_FILE.new

tail -1 $TMP_FILE.new | grep -q '^\s*\(return\|import\|from\|print\|pprint\)'

if [ $? -eq 0 ]; then
	cat $TMP_FILE.new > $TMP_FILE.in
else
	cat $TMP_FILE.new | sed -e '/^$/d' |\
		sed '$ s/^[^ \t].*$/____ =&\
\pprint.pprint(____)\
\____/' > $TMP_FILE.in
fi
sleep 0.1
cat $TMP_FILE.out | sed -e 's/^\(.*\)$/# \1/'
#sleep 0.1 && echo -n "" > $TMP_FILE.out &
cat /dev/null > $TMP_FILE.out
#rm $TMP_FILE.out
