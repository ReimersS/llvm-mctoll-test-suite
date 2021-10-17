-include Makefile.config

.PHONY: clean package-x86

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

package-x86: build recompile-x86
	@test -e build || mkdir build
	@rm -rf build/x86
	@mkdir build/x86
	@for t in $(TARGETS); do mkdir build/x86/`basename $$t`; cp -r  $$t/{inputs,build/*-x86.{out,rt}} build/x86/`basename $$t`/; done
	@cp benchmark.py run-all.sh build/

package-arm: build recompile-arm
	@test -e build || mkdir build
	@rm -rf build/arm
	@mkdir build/arm
	@for t in $(TARGETS); do mkdir build/arm/`basename $$t`; cp -r  $$t/{inputs,build/*-arm.{out,rt}} build/arm/`basename $$t`/; done
	@cp benchmark.py run-all.sh build/


