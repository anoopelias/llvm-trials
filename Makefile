# clang -o main main.c util.c
all: clean main

clean:
	rm -f main.ll main.o main.s util.ll util.o util.s main.wasm main

%.ll: %.c
	clang -S -emit-llvm \
		-o $@ $<

main.o: main.ll
	llc -filetype=obj $< 

util.o: util.ll
	llc -filetype=obj $< 

main: main.o util.o
	ld -syslibroot /Library/Developer/CommandLineTools/SDKs/MacOSX13.sdk \
		-o $@ \
		main.o util.o \
		-lSystem /opt/homebrew/Cellar/llvm/16.0.6/lib/clang/16/lib/darwin/libclang_rt.osx.a \

run: all
	./main
