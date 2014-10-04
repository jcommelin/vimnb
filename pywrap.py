#!/usr/bin/python
import sys, time, traceback, pprint
while True:
    line = sys.stdin.readline()
    if line:
        try:
            exec(line)
        except:
            traceback.print_exc(file=sys.stdout)
        sys.stdout.flush()
    else:
        time.sleep(0.1)
