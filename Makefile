-include Makefile.config

.PHONY: clean build mctoll recompile-x86 recompile-arm package-x86 package-arm

all: build mctoll package-x86 package-arm

TARGETS=$(shell find benchmarks/* -maxdepth 0 -type d)
# TARGETS=benchmarks/histogram

build:
	@set -e; for t in $(TARGETS); do make -C $$t build-native; done

mctoll: build
	@set -e; for t in $(TARGETS); do make -C $$t mctoll; done

recompile-x86: mctoll
	@set -e; for t in $(TARGETS); do make -C $$t recompile-x86; done

recompile-arm: mctoll
	@set -e; for t in $(TARGETS); do make -C $$t recompile-arm; done

clean:
	@set -e; for t in $(TARGETS); do make -C $$t clean; done

package:
	@rm -rf build
	@for t in $(TARGETS); do mkdir -p build/benchmarks/`basename $$t`; cp -r  $$t/inputs $$t/build build/benchmarks/`basename $$t`/; done
	@cp benchmark.py run-all.sh build/


