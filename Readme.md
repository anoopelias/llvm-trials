
# LLVM Trials

This repo has some code to show the stages of compilation in LLVM. The findings are summarized in the blog post [here](https://anoopelias.github.io/posts/llvm-compile-stages/).

## Run

```
$ make run
rm -f main.ll main.o main.s util.ll util.o util.s main.wasm main
clang -S -emit-llvm \
		-o main.ll main.c
llc -filetype=obj main.ll
clang -S -emit-llvm \
		-o util.ll util.c
llc -filetype=obj util.ll
ld -syslibroot /Library/Developer/CommandLineTools/SDKs/MacOSX13.sdk \
		-o main \
		main.o util.o \
		-lSystem /opt/homebrew/Cellar/llvm/16.0.6/lib/clang/16/lib/darwin/libclang_rt.osx.a \

./main
Hello, clang 15
```