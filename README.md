A small program created to solve Chez Scheme's original "launcher" eats your
command-line arguments.

# Rationale

According to the manual, the complete Chez Scheme implementation can be split
into 3 parts:

- A kernel (typically a dynamic library) that actually runs the codes.
- A launcher that parses command-line arguments and invoke the kernel.
- A boot file that contains the actual code.

When distributing Chez Scheme applications, you'll distribute these 3 things,
and rename the launcher and the boot file to your application name (e. g.
`app.exe` and `app.boot`) the annoying thing about distributing original
launcher is demonstrated below:

```shell
# Suppose we distributed our app as `app.exe`, and there is a `-b` flag
# in our app.

# When we try to invoke our app with the `-b` flag.
$ ./app.exe -b arg1
cannot find compatible boot file arg1 in search path:
  "C:\Program Files\Chez Scheme 10.3.0\boot\%m"

# We'll need to pass `--` first to stop the launcher's argument parsing.
$ ./app.exe -- -b arg1
Hello, arg1!
```

This is very inconvenient for a distributed app, it means you'll have to wrap
your app around a script to prevent this behaviour.

So I wrote this small program to solve this problem, my launcher doesn't consume
any command-line arguments (since almost all of them won't be needed in the
application anyway,) it passes them all to the underlying Scheme kernel.

# Building

## Windows MSVC

To build this launcher, you'll need some files from Chez Scheme.

- `scheme.h`.
- `csv1030.dll` and `csv1030.lib`.

The above files can be found in the Chez Scheme installation folder (), if they're
not there, you probably need to build Chez Scheme by yourself, see the [official
build doc](https://github.com/cisco/ChezScheme/blob/main/BUILDING) for more
info.

After these files are obtained, put them under the `chez` folder (or wherever
you prefer, as long as your compiler can find them).

Then run the build script, `build.bat`.

## UNIX

On UNIX systems, Chez Scheme is statically linked, so the required files are
different:

- `scheme.h`.
- `libkernel.a`.

And 2 files from other libraries:

- `liblz4.a` from lz4.
- `libz.a` from zlib.

I think lz4 and zlib can be in shared library format, but I'm not sure, feel
free to try.

Put these files into `chez` directory, then run the build script `build.sh`.

# Usage

Your Scheme program needs to be a top-level program, an example is provided in
`s/` directory.

Then you need to make your application into a boot file, it can be done like
this:

```scheme
(import (scheme))

(compile-imported-libraries #t)
(generate-wpo-files #t)

(compile-program "s/main.ss")
(compile-whole-program "s/main.wpo" "s/myapp.so")
(make-boot-file "myapp.exe.boot" '("petite" "scheme") "s/myapp.so")
```

After this, simply rename the launcher to `myapp.exe`, and you should be good to
go.
