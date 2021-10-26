-include Makefile.config

build-native: out build/seq-x86.out build/pthread-x86.out build/seq-arm.out #build/pthread-arm.out

mctoll: build/seq.ll build/pthread.ll

recompile-x86: build/seq-x86.rt build/pthread-x86.rt

recompile-arm: build/seq-arm.rt #build/pthread-arm.rt

out:
	@test -d build || mkdir build

build/%-x86.out: %.c
	$(CC) $(CFLAGS) $(OPT_FLAGS) -o $@ $<

build/%-arm.out: %.c
	$(CC_ARM) $(CFLAGS) $(OPT_FLAGS) -o $@ $<

build/%.ll: build/%-x86.out
	$(MCTOLL) -d $< -o $@

build/%-x86.rt: build/%.ll
	$(CC) $(CFLAGS) $(RETARGET_OPT_FLAGS) -o $@ $<

build/%-arm.rt: build/%.ll
	$(CC_ARM) $(CFLAGS) $(RETARGET_OPT_FLAGS) -o $@ $<

.PHONY: clean

clean:
	rm -rf build
