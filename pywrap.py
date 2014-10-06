#!/usr/bin/python3
import io, sys, time, traceback
from code import InteractiveConsole

class Console(InteractiveConsole):
    def __init__(*args):
        InteractiveConsole.__init__(*args)

    errlog = io.StringIO("")
    def write(data):
        self.errlog.write(data)


sys.stdout.close()
sys.stderr.close()

console = Console()

while True:
    line = sys.stdin.readline()
    if line:
        i = open(line[:-1] + ".in", "r")
        sys.stdout = open(line[:-1] + ".out", "w")
        sys.stderr = open(line[:-1] + ".err", "w")
        try:
            r = True
            for l in i:
                r = console.push(l)
            if r:
                sys.stderr.write("Error: The input is incomplete; more input is required.\n")
            console.resetbuffer()
            sys.stderr.write(console.errlog.read())
        except:
            sys.stderr.write("I am very sorry. Something went wrong in the Python REPL of VimNB.\n")
            traceback.print_exc(file=sys.stderr)
        i.close()
        sys.stdout.close()
        sys.stderr.close()
    else:
        time.sleep(0.1)

# vim: tabstop=8 expandtab shiftwidth=4 softtabstop=4
