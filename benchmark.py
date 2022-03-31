#!/usr/bin/env python3

import datetime
import re
import statistics
import subprocess
import sys


def run_command(args):
    result = subprocess.run(args, capture_output=True)
    if result.returncode != 0:
        print("Error running ", args, file=sys.stderr)
        print("stdout: ", result.stdout, file=sys.stderr)
        print("stderr: ", result.stderr, file=sys.stderr)
        exit(1)


if len(sys.argv) <= 2:
    print("Usage: {} file iterations [arguments]".format(sys.argv[0]), file=sys.stderr)
    sys.exit(1)

native_binary = sys.argv[1]
iterations = int(sys.argv[2])
additional_args = sys.argv[3:]

basename = re.sub(r"(.out)$", "", native_binary)
binary_unopt = basename + "-unopt.rt"
binary_opt = basename + "-opt.rt"
binary_popt = basename + "-popt.rt"
binary_ppopt = basename + "-ppopt.rt"

times_native = []
times_unopt = []
times_opt = []
times_popt = []
times_ppopt = []

for (binary, array) in [(native_binary, times_native), (binary_unopt, times_unopt), (binary_opt, times_opt), (binary_popt, times_popt),
                        (binary_ppopt, times_ppopt)]:
    for i in range(iterations):
        print(".", end="", file=sys.stderr, flush=True)
        begin = datetime.datetime.now()
        run_command([binary, *additional_args])
        end = datetime.datetime.now()
        diff = end - begin
        array.append(diff.total_seconds() * 10 ** 6)

print("", file=sys.stderr, flush=True)

print(basename, *additional_args, sep=" ", end=",")
print(iterations, end=",")
print(statistics.mean(times_native), end=",")
print(statistics.stdev(times_native), end=",")
print(statistics.mean(times_unopt), end=",")
print(statistics.stdev(times_unopt), end=",")
print(statistics.mean(times_opt), end=",")
print(statistics.stdev(times_opt), end=",")
print(statistics.mean(times_popt), end=",")
print(statistics.stdev(times_popt), end=",")
print(statistics.mean(times_ppopt), end=",")
print(statistics.stdev(times_ppopt), end="\n")
