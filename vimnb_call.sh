#!/bin/bash

# Inspired by the pipe2eval plugin for vim

# Parse the filename
INPUT_FILE="$1"
INPUT_FILE_BASE=$(basename "${INPUT_FILE}")

# Users may specify their prefered directory for temporary files
if [ -z "$VIMNB_TMP_FILE_PATH" ]; then
	VIMNB_TMP_FILE_PATH=/dev/shm/
fi

# Prefix for temporary files
PREFIX=vimnb

# Basename for the temporary files
TMP_FILE="${VIMNB_TMP_FILE_PATH}${PREFIX}_${INPUT_FILE_BASE}"

# Save the python code from stdin in a file, and pass it to the output
tee $TMP_FILE.in

# Print a separator
echo "#> -------------------------------------------------------"

# Pass the filename to the ipc pipe
echo "$TMP_FILE" > $TMP_FILE.ipc

# Wait till the REPL is done with computing, and writes the output
while [[ (! -r $TMP_FILE.out) && (! -r $TMP_FILE.err) ]]
do
	sleep 0.1
done

# Print output and errors
if [ -r $TMP_FILE.out ]; then
	cat $TMP_FILE.out | sed -e 's/^\(.*\)$/#> \1/'
fi
if [ -r $TMP_FILE.err ]; then
	cat $TMP_FILE.err | sed -e 's/^\(.*\)$/#> !\1/'
fi

# Clean up
rm $TMP_FILE.in
rm -f $TMP_FILE.out
rm -f $TMP_FILE.err
