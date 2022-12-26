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

The soution is to upgrade to binutils 2.39.
