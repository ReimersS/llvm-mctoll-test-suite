# LLVM-MCTOLL Test suite

Please do not clone this repository from Github, as Github imposes a limit for LFS bandwith and storage.
Instead, clone from https://git.baey.eu/martin/llvm-mctoll-test-suite.

This repo serves as an additional test suite for the [llvm-mctoll](https://github.com/microsoft/llvm-mctoll) repository.
It uses modified sources from [phoenix-2.0](https://github.com/kozyraki/phoenix).

The license for phoenix-2.0 sources can be found in the individual files.

This repo uses [git lfs](https://git-lfs.github.com) for large input files.

### Usage

```bash
cd /path/to/llvm-mctoll
git clone https://git.baey.eu/martin/llvm-mctoll-test-suite.git test/llvm-mctoll-test-suite
cd ../../../build
ninja check-mctoll
```
