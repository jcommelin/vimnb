#!/bin/bash

# Inspired by the pipe2eval plugin for vim

INPUT_FILE="$1"
INPUT_FILE_BASE=$(basename "${INPUT_FILE}")

if [ -z "$VIMNB_TMP_FILE_PATH" ]; then
	VIMNB_TMP_FILE_PATH=/dev/shm/
fi
PREFIX=repl
TMP_FILE="${VIMNB_TMP_FILE_PATH}${PREFIX}_${INPUT_FILE_BASE}"

tee $TMP_FILE.in
echo "#> -------------------------------------------------------"

echo "$TMP_FILE" > $TMP_FILE.ipc
while [[ (! -r $TMP_FILE.out) && (! -r $TMP_FILE.err) ]]
do
	sleep 0.1
done

if [ -r $TMP_FILE.out ]; then
	cat $TMP_FILE.out | sed -e 's/^\(.*\)$/#> \1/'
	cat $TMP_FILE.out >> $TMP_FILE.log
fi
if [ -r $TMP_FILE.err ]; then
	cat $TMP_FILE.err | sed -e 's/^\(.*\)$/#> !\1/'
	cat $TMP_FILE.err >> $TMP_FILE.log
fi

rm $TMP_FILE.in
rm -f $TMP_FILE.out
rm -f $TMP_FILE.err
