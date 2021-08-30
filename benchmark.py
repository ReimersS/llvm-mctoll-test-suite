#!/usr/bin/env python3

import datetime
import re
import statistics
import subprocess
import sys

compilation_flags = ["-O3", "-mno-sse"]
iterations = 10
include_files = "/usr/include/assert.h,/usr/include/fcntl.h,/usr/include/inttypes.h," \
                "/home/martin/llvm-project/build/lib/clang/14.0.0/include/stddef.h,/usr/include/stdio.h," \
                "/usr/include/stdlib.h,/usr/include/string.h,/usr/include/x86_64-linux-gnu/sys/mman.h," \
                "/usr/include/x86_64-linux-gnu/sys/stat.h,/usr/include/x86_64-linux-gnu/sys/time.h," \
                "/usr/include/time.h,/usr/include/unistd.h "


def run_command(args):
    result = subprocess.run(args)
    if result.returncode != 0:
        print("Error running ", args)
        print("stdout: ", result.stdout)
        print("stderr: ", result.stderr)
        exit(1)


if len(sys.argv) <= 1:
    print("Usage: {} file [arguments]".format(sys.argv[0]))
    sys.exit(1)

input_file = sys.argv[1]
additional_args = sys.argv[2:]

filename_without_ext = re.sub(r"(.c)$", "", input_file)
raised_bitcode = filename_without_ext + "-dis.ll"
raised_recompiled = filename_without_ext + "-dis"

# compiling benchmark
run_command(["clang", *compilation_flags, input_file, "-o", filename_without_ext])

# raising benchmark
run_command(["llvm-mctoll", "--include-files=" + include_files, "-d", filename_without_ext, "-o", raised_bitcode])

# re-compiling benchmark
run_command(["clang", *compilation_flags, raised_bitcode, "-o", raised_recompiled])

orig_times = []
recompiled_times = []

for i in range(iterations):
    begin = datetime.datetime.now()
    run_command([filename_without_ext, *additional_args])
    end = datetime.datetime.now()
    diff = end - begin
    orig_times.append(diff.microseconds)

    begin = datetime.datetime.now()
    run_command([raised_recompiled, *additional_args])
    end = datetime.datetime.now()
    diff = end - begin
    recompiled_times.append(diff.microseconds)

print("command,min,max,mean,median,stddev")
print(filename_without_ext, *additional_args, sep=" ", end=",")
print(min(orig_times), end=",")
print(max(orig_times), end=",")
print(statistics.mean(orig_times), end=",")
print(statistics.median(orig_times), end=",")
print(statistics.stdev(orig_times), end="\n")

print("command,min,max,mean,median,stddev")
print(raised_recompiled, *additional_args, sep=" ", end=",")
print(min(recompiled_times), end=",")
print(max(recompiled_times), end=",")
print(statistics.mean(recompiled_times), end=",")
print(statistics.median(recompiled_times), end=",")
print(statistics.stdev(recompiled_times), end="\n")
