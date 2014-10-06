#!/usr/bin/python3
import io, sys, time, traceback
from code import InteractiveConsole

# Subclass the InteractiveConsole class
# The main reason to do this, is so that we can define our own write()
# function. This function is used by several other functions in the
# InteractiveConsole class to print error messages, tracebacks, etc.
class Console(InteractiveConsole):
    def __init__(*args):
        InteractiveConsole.__init__(*args)

    # Create an error log, and configure the write() function to use it
    errlog = io.StringIO("")
    def write(data):
        self.errlog.write(data)


# Close conventional output streams
sys.stdout.close()
sys.stderr.close()

# Create a console instance
console = Console()

while True:
    line = sys.stdin.readline()
    if line:
        # Read a filename from the ipc pipe
        i = open(line[:-1] + ".in", "r")
        # Open output streams on temporary files
        sys.stdout = open(line[:-1] + ".out", "w")
        sys.stderr = open(line[:-1] + ".err", "w")
        try:
            # Keep track of whether the code forms a complete statement
            # or whether more input is required
            r = True
            # Run code through the REPL
            for l in i:
                # Returns True if more input is required
                r = console.push(l)
            if r:
                sys.stderr.write("Error: The input is incomplete; more input is required.\n")
            # Clean up, we don't want the next run to deal with remains of this run
            console.resetbuffer()
            # Write any syntax errors, or tracebacks to the error file
            sys.stderr.write(console.errlog.read())
        except:
            # If for some reason something went wrong, apologise, and print debug info
            sys.stderr.write("I am very sorry. Something went wrong in the Python REPL of VimNB.\n")
            traceback.print_exc(file=sys.stderr)
        # Clean up
        i.close()
        sys.stdout.close()
        sys.stderr.close()
    else:
        # Wait for new filenames on the ipc pipe
        time.sleep(0.1)

# vim: tabstop=8 expandtab shiftwidth=4 softtabstop=4
