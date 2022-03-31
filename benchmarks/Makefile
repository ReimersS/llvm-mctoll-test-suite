-include Makefile.config

build-native: out build/seq-x86.out build/pthread-x86.out build/seq-arm.out build/pthread-arm.out

mctoll: build/seq-unopt.ll build/pthread-unopt.ll build/seq-popt.ll build/pthread-popt.ll build/seq-ppopt.ll build/pthread-ppopt.ll

recompile-x86: build/seq-x86.rt build/pthread-x86.rt

recompile-arm: build/seq-unopt-arm.rt build/pthread-unopt-arm.rt build/seq-opt-arm.rt build/pthread-opt-arm.rt build/seq-popt-arm.rt build/pthread-popt-arm.rt build/seq-ppopt-arm.rt build/pthread-ppopt-arm.rt

out:
	@test -d build || mkdir build

build/%-x86.out: %.c
	$(CC) $(CFLAGS) $(OPT_FLAGS) -o $@ $<

build/%-arm.out: %.c
	$(CC_ARM) $(CFLAGS) $(OPT_FLAGS) -o $@ $<

build/%-unopt.ll: build/%-x86.out
	$(MCTOLL) -disable-optimizations=true -d $< -o $@

build/%-popt.ll: build/%-x86.out
	$(MCTOLL) -optimize-fences=true -disable-optimizations=true -d $< -o $@

build/%-ppopt.ll: build/%-x86.out
	$(MCTOLL) -optimize-fences=true -disable-optimizations=false -d $< -o $@

build/%-unopt-arm.rt: build/%-unopt.ll
	$(CC_ARM) $(CFLAGS) -O0 -o $@ $<

build/%-opt-arm.rt: build/%-unopt.ll
	$(CC_ARM) $(CFLAGS) $(RETARGET_OPT_FLAGS) -o $@ $<

build/%-popt-arm.rt: build/%-popt.ll
	$(CC_ARM) $(CFLAGS) $(RETARGET_OPT_FLAGS) -o $@ $<

build/%-ppopt-arm.rt: build/%-ppopt.ll
	$(CC_ARM) $(CFLAGS) $(RETARGET_OPT_FLAGS) -o $@ $<

.PHONY: clean

clean:
	rm -rf build
