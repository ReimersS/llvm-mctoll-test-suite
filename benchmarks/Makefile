-include Makefile.config

build-native: out build/seq-x86.out build/pthread-x86.out build/seq-arm.out build/pthread-arm.out

mctoll: build/seq-unopt.ll build/pthread-unopt.ll build/seq-opt.ll build/pthread-opt.ll build/seq-popt.ll build/pthread-popt.ll build/seq-ppopt.ll build/pthread-ppopt.ll

recompile-x86: build/seq-x86.rt build/pthread-x86.rt

recompile-arm: build/seq-arm-unopt.rt build/pthread-arm-unopt.rt build/seq-arm-opt.rt build/pthread-arm-opt.rt build/seq-arm-popt.rt build/pthread-arm-popt.rt build/seq-arm-ppopt.rt build/pthread-arm-ppopt.rt

out:
	@test -d build || mkdir build

build/%-x86.out: %.c
	$(CC) $(CFLAGS) $(OPT_FLAGS) -o $@ $<

build/%-arm.out: %.c
	$(CC_ARM) $(CFLAGS) $(OPT_FLAGS) -S -emit-llvm -o $@-native.ll $<
	$(CC_ARM) $(CFLAGS) $(OPT_FLAGS) -o $@ $<

build/%-unopt.ll: build/%-x86.out
	$(MCTOLL) -disable-optimizations=true -d $< -o $@

build/%-opt.ll: build/%-x86.out
	$(MCTOLL) -disable-optimizations=true -d $< -o $@
	$(OPT) -S -o $@.opt.ll $@ -O3

build/%-popt.ll: build/%-x86.out
	$(MCTOLL) -optimize-fences=true -disable-optimizations=true -d $< -o $@
	$(OPT) -S -o $@.opt.ll $@ -O3

build/%-ppopt.ll: build/%-x86.out
	$(MCTOLL) -optimize-fences=true -disable-optimizations=false -d $< -o $@
	$(OPT) -S -o $@.opt.ll $@ -O3

build/%-arm-unopt.rt: build/%-unopt.ll
	$(CC_ARM) $(CFLAGS) -O0 -o $@ $<

build/%-arm-opt.rt: build/%-opt.ll
	$(CC_ARM) $(CFLAGS) $(RETARGET_OPT_FLAGS) -o $@ $<

build/%-arm-popt.rt: build/%-popt.ll
	$(CC_ARM) $(CFLAGS) $(RETARGET_OPT_FLAGS) -o $@ $<

build/%-arm-ppopt.rt: build/%-ppopt.ll
	$(CC_ARM) $(CFLAGS) $(RETARGET_OPT_FLAGS) -o $@ $<

.PHONY: clean

clean:
	rm -rf build
