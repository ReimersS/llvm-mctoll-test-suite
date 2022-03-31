#!/usr/bin/env bash

arch=arm

echo "benchmark,iterations,mean-native,stddev-native,mean-unopt,stddev-unopt,mean-opt,stddev-opt,mean-popt,stddev-popt,mean-ppopt,stddev-ppopt"

# Arguments:    benchmark                                   iter    benchmark flags
./benchmark.py "benchmarks/histogram/build/seq-${arch}.out"             "100"   "benchmarks/histogram/inputs/small.bmp"
./benchmark.py "benchmarks/histogram/build/seq-${arch}.out"             "50"    "benchmarks/histogram/inputs/med.bmp"
./benchmark.py "benchmarks/histogram/build/seq-${arch}.out"             "25"    "benchmarks/histogram/inputs/large.bmp"
./benchmark.py "benchmarks/kmeans/build/seq-${arch}.out"                "100"
./benchmark.py "benchmarks/linear_regression/build/seq-${arch}.out"     "250"   "benchmarks/linear_regression/inputs/key_file_50MB.txt"
./benchmark.py "benchmarks/linear_regression/build/seq-${arch}.out"     "100"   "benchmarks/linear_regression/inputs/key_file_100MB.txt"
./benchmark.py "benchmarks/linear_regression/build/seq-${arch}.out"     "50"    "benchmarks/linear_regression/inputs/key_file_500MB.txt"
./benchmark.py "benchmarks/matrix_multiply/build/seq-${arch}.out"       "100"   "200" "benchmarks/matrix_multiply/inputs/matrix_a" "benchmarks/matrix_multiply/inputs/matrix_b"
./benchmark.py "benchmarks/pca/build/seq-${arch}.out"                   "1000"  "-r 100 -c 100 -s 1000"
./benchmark.py "benchmarks/pca/build/seq-${arch}.out"                   "500"   "-r 200 -c 200 -s 1000"
./benchmark.py "benchmarks/pca/build/seq-${arch}.out"                   "250"   "-r 1000 -c 1000 -s 1000"
./benchmark.py "benchmarks/string_match/build/seq-${arch}.out"          "250"   "benchmarks/string_match/inputs/key_file_50MB.txt"
./benchmark.py "benchmarks/string_match/build/seq-${arch}.out"          "100"   "benchmarks/string_match/inputs/key_file_100MB.txt"
./benchmark.py "benchmarks/string_match/build/seq-${arch}.out"          "25"    "benchmarks/string_match/inputs/key_file_500MB.txt"
./benchmark.py "benchmarks/word_count/build/seq-${arch}.out"            "250"   "benchmarks/word_count/inputs/word_10MB.txt"

# Arguments:    benchmark                                       iter    benchmark flags
./benchmark.py "benchmarks/histogram/build/pthread-${arch}.out"         "100"   "benchmarks/histogram/inputs/small.bmp"
./benchmark.py "benchmarks/histogram/build/pthread-${arch}.out"         "50"    "benchmarks/histogram/inputs/med.bmp"
./benchmark.py "benchmarks/histogram/build/pthread-${arch}.out"         "25"    "benchmarks/histogram/inputs/large.bmp"
./benchmark.py "benchmarks/kmeans/build/pthread-${arch}.out"            "100"
./benchmark.py "benchmarks/linear_regression/build/pthread-${arch}.out" "250"   "benchmarks/linear_regression/inputs/key_file_50MB.txt"
./benchmark.py "benchmarks/linear_regression/build/pthread-${arch}.out" "100"   "benchmarks/linear_regression/inputs/key_file_100MB.txt"
./benchmark.py "benchmarks/linear_regression/build/pthread-${arch}.out" "50"    "benchmarks/linear_regression/inputs/key_file_500MB.txt"
./benchmark.py "benchmarks/matrix_multiply/build/pthread-${arch}.out"   "150"   "200" "benchmarks/matrix_multiply/inputs/matrix_a" "benchmarks/matrix_multiply/inputs/matrix_b"
./benchmark.py "benchmarks/string_match/build/pthread-${arch}.out"      "250"   "benchmarks/string_match/inputs/key_file_50MB.txt"
./benchmark.py "benchmarks/string_match/build/pthread-${arch}.out"      "100"   "benchmarks/string_match/inputs/key_file_100MB.txt"
