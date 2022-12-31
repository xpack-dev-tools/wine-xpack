# Developer info

## binutils 2.38 bug

https://bugs.launchpad.net/ubuntu/+source/binutils-mingw-w64/+bug/1971901

```console
tools/winebuild/winebuild -b x86_64-w64-mingw32 -w --implib -o dlls/winmm/libwinmm.delay.a --export \
  ../wine-6.0.4/dlls/winmm/winmm.spec
Assembler messages:
Error: can't open winmm_dll_t.s for reading: No such file or directory
/usr/bin/x86_64-w64-mingw32-dlltool: /usr/bin/x86_64-w64-mingw32-as exited with status 1
/usr/bin/x86_64-w64-mingw32-dlltool: failed to open temporary tail file: winmm_dll_t.o: No such file or directory
winebuild: /usr/bin/x86_64-w64-mingw32-dlltool failed with status 1
make: *** [Makefile:195227: dlls/winmm/libwinmm.delay.a] Error 1
```

The workaround is to disable the parallel build.

The solution is to upgrade to binutils 2.39.

## 32-bit wine

To build the 32-bit version of wine, it is necessary to:

- have gcc support `-m32`
- `i686-w64-mingw32-gcc` be present
- 32-bit libraries be present

```console
checking whether /home/ilg/Work/wine-xpack.git/build/linux-x64/xpacks/.bin/gcc -m32 works... no
configure: error: Cannot build a 32-bit program, you need to install 32-bit development libraries.
```
