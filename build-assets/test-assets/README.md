# README

These files are intended to be used during tests.

The (trivial) source file is included as `src/hello.c`.

The binaries are compiled with mingw-w64-gcc.

The easiest way to compile them, is with xpm:

```sh
xpm install
xpm run compile-ia32
xpm run compile-x64
```

TODO: add an arm64 binary when possible. (mingw-w64-gcc does not support arm yet).
