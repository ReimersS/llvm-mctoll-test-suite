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
raised_binary = basename + ".rt"

orig_times = []
recompiled_times = []

# running warm-up
print("Warming up...", file=sys.stderr)
run_command([native_binary, *additional_args])
run_command([raised_binary, *additional_args])

for i in range(iterations):
    print(".", end="", file=sys.stderr, flush=True)
    begin = datetime.datetime.now()
    run_command([native_binary, *additional_args])
    end = datetime.datetime.now()
    diff = end - begin
    orig_times.append(diff.total_seconds() * 10**6)

    print(".", end="", file=sys.stderr, flush=True)
    begin = datetime.datetime.now()
    run_command([raised_binary, *additional_args])
    end = datetime.datetime.now()
    diff = end - begin
    recompiled_times.append(diff.total_seconds() * 10 ** 6)

print("", file=sys.stderr, flush=True)

print(basename, *additional_args, sep=" ", end=",")
print(iterations, end=",")
print(sys.argv[2], end=",")
print(min(orig_times), end=",")
print(min(recompiled_times), end=",")
print(max(orig_times), end=",")
print(max(recompiled_times), end=",")
print(statistics.mean(orig_times), end=",")
print(statistics.mean(recompiled_times), end=",")
print(statistics.mean(recompiled_times) / statistics.mean(orig_times), end=",")
print(statistics.median(orig_times), end=",")
print(statistics.median(recompiled_times), end=",")
print(statistics.median(recompiled_times) / statistics.median(orig_times), end=",")
print(statistics.stdev(orig_times), end=",")
print(statistics.stdev(recompiled_times), end="\n")
