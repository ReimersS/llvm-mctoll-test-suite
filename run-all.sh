#!/usr/bin/env bash

if [ "$#" -ne 1 ]; then
  echo "Usage: $0 architecture"
  exit 1
fi

arch=$1

if [ ! -e "$arch" ]; then
  echo "Architecture $arch not found"
  exit 1
fi

echo "benchmark,iterations,clang flags,min (orig),min (raised),max (orig),max (raised),mean (orig),mean (raised),overhead (mean),median (orig),median (raised),overhead (median),stddev (orig),stddev (raised)"

# Arguments:    benchmark                                   iter    benchmark flags
./benchmark.py "${arch}/histogram/seq-${arch}.out"             "100"   "${arch}/histogram/inputs/small.bmp"
./benchmark.py "${arch}/histogram/seq-${arch}.out"             "50"    "${arch}/histogram/inputs/med.bmp"
./benchmark.py "${arch}/histogram/seq-${arch}.out"             "25"    "${arch}/histogram/inputs/large.bmp"
./benchmark.py "${arch}/kmeans/seq-${arch}.out"                "100"
./benchmark.py "${arch}/linear_regression/seq-${arch}.out"     "250"   "${arch}/linear_regression/inputs/key_file_50MB.txt"
./benchmark.py "${arch}/linear_regression/seq-${arch}.out"     "100"   "${arch}/linear_regression/inputs/key_file_100MB.txt"
./benchmark.py "${arch}/linear_regression/seq-${arch}.out"     "50"    "${arch}/linear_regression/inputs/key_file_500MB.txt"
./benchmark.py "${arch}/matrix_multiply/seq-${arch}.out"       "100"   "200" "${arch}/matrix_multiply/inputs/matrix_a" "${arch}/matrix_multiply/inputs/matrix_b"
./benchmark.py "${arch}/pca/seq-${arch}.out"                   "1000"  "-r 100 -c 100 -s 1000"
./benchmark.py "${arch}/pca/seq-${arch}.out"                   "500"   "-r 200 -c 200 -s 1000"
./benchmark.py "${arch}/pca/seq-${arch}.out"                   "250"   "-r 1000 -c 1000 -s 1000"
./benchmark.py "${arch}/string_match/seq-${arch}.out"          "250"   "${arch}/string_match/inputs/key_file_50MB.txt"
./benchmark.py "${arch}/string_match/seq-${arch}.out"          "100"   "${arch}/string_match/inputs/key_file_100MB.txt"
./benchmark.py "${arch}/string_match/seq-${arch}.out"          "25"    "${arch}/string_match/inputs/key_file_500MB.txt"
./benchmark.py "${arch}/word_count/seq-${arch}.out"            "250"   "${arch}/word_count/inputs/word_10MB.txt"

# Arguments:    benchmark                                       iter    benchmark flags
./benchmark.py "${arch}/histogram/pthread-${arch}.out"         "100"   "${arch}/histogram/inputs/small.bmp"
./benchmark.py "${arch}/histogram/pthread-${arch}.out"         "50"    "${arch}/histogram/inputs/med.bmp"
./benchmark.py "${arch}/histogram/pthread-${arch}.out"         "25"    "${arch}/histogram/inputs/large.bmp"
./benchmark.py "${arch}/kmeans/pthread-${arch}.out"            "100"
./benchmark.py "${arch}/linear_regression/pthread-${arch}.out" "250"   "${arch}/linear_regression/inputs/key_file_50MB.txt"
./benchmark.py "${arch}/linear_regression/pthread-${arch}.out" "100"   "${arch}/linear_regression/inputs/key_file_100MB.txt"
./benchmark.py "${arch}/linear_regression/pthread-${arch}.out" "50"    "${arch}/linear_regression/inputs/key_file_500MB.txt"
./benchmark.py "${arch}/matrix_multiply/pthread-${arch}.out"   "150"   "200" "${arch}/matrix_multiply/inputs/matrix_a" "${arch}/matrix_multiply/inputs/matrix_b"
#./benchmark.py "${arch}/pca/pthread-${arch}.out"               "1000"  "-r 100 -c 100 -s 1000"
#./benchmark.py "${arch}/pca/pthread-${arch}.out"               "500"   "-r 200 -c 200 -s 1000"
#./benchmark.py "${arch}/pca/pthread-${arch}.out"               "250"   "-r 1000 -c 1000 -s 1000"
./benchmark.py "${arch}/string_match/pthread-${arch}.out"      "250"   "${arch}/string_match/inputs/key_file_50MB.txt"
./benchmark.py "${arch}/string_match/pthread-${arch}.out"      "100"   "${arch}/string_match/inputs/key_file_100MB.txt"
./benchmark.py "${arch}/string_match/pthread-${arch}.out"      "25"    "${arch}/string_match/inputs/key_file_500MB.txt"
./benchmark.py "${arch}/word_count/pthread-${arch}.out"        "250"   "${arch}/word_count/inputs/word_10MB.txt"
