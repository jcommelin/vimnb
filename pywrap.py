#!/usr/bin/python3
import sys, time, traceback, pprint

sys.stdout.close()

while True:
    line = sys.stdin.readline()
    if line:
        i = open(line[:-1] + ".in", "r")
        sys.stdout = open(line[:-1] + ".out", "w")
        try:
            for l in i:
                exec(l)
        except:
            traceback.print_exc(file=sys.stdout)
        i.close()
        sys.stdout.close()
    else:
        time.sleep(0.1)

# vim: tabstop=8 expandtab shiftwidth=4 softtabstop=4
