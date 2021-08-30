#!/usr/bin/env python3

import datetime
import re
import statistics
import subprocess
import sys

compilation_flags = ["-O3", "-mno-sse"]
include_files = "/usr/include/assert.h,/usr/include/fcntl.h,/usr/include/inttypes.h," \
                "/home/martin/llvm-project/build/lib/clang/14.0.0/include/stddef.h,/usr/include/stdio.h," \
                "/usr/include/stdlib.h,/usr/include/string.h,/usr/include/x86_64-linux-gnu/sys/mman.h," \
                "/usr/include/x86_64-linux-gnu/sys/stat.h,/usr/include/x86_64-linux-gnu/sys/time.h," \
                "/usr/include/time.h,/usr/include/unistd.h,/usr/include/getopt.h,./getopt.h"


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

input_file = sys.argv[1]
iterations = int(sys.argv[2])
additional_args = sys.argv[3:]

filename_without_ext = re.sub(r"(.c)$", "", input_file)
raised_bitcode = filename_without_ext + "-dis.ll"
raised_recompiled = filename_without_ext + "-dis"

# compiling benchmark
print("Compiling...", file=sys.stderr)
run_command(["clang", *compilation_flags, input_file, "-o", filename_without_ext])

# raising benchmark
run_command(["llvm-mctoll", "--compilation-db-path=.", "--include-files=" + include_files, "-d", filename_without_ext, "-o", raised_bitcode])
print("Raising...", file=sys.stderr)

# re-compiling benchmark
run_command(["clang", *compilation_flags, raised_bitcode, "-o", raised_recompiled])
print("Re-compiling...", file=sys.stderr)

orig_times = []
recompiled_times = []

for i in range(iterations):
    print(".", end="", file=sys.stderr, flush=True)
    begin = datetime.datetime.now()
    run_command([filename_without_ext, *additional_args])
    end = datetime.datetime.now()
    diff = end - begin
    orig_times.append(diff.total_seconds() * 10**6)

    print(".", end="", file=sys.stderr, flush=True)
    begin = datetime.datetime.now()
    run_command([raised_recompiled, *additional_args])
    end = datetime.datetime.now()
    diff = end - begin
    recompiled_times.append(diff.total_seconds() * 10 ** 6)

print("", file=sys.stderr, flush=True)

print("benchmark,iterations,min (orig),min (raised),max (orig),max (raised),mean (orig),mean (raised),overhead (mean),"
      "median (orig),median (raised),overhead (median),stddev (orig),stddev (raised)")
print(filename_without_ext, *additional_args, sep=" ", end=",")
print(iterations, end=",")
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
