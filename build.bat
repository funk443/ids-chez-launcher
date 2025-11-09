@echo off

set CHEZ_VERSION=1030
set LIB_AND_INCLUDE_PATH="chez"

cl.exe /Fe"app.exe" /Wall /I"%LIB_AND_INCLUDE_PATH%" /O2 c\launcher.c /link /LIBPATH:"%LIB_AND_INCLUDE_PATH%" "csv%CHEZ_VERSION%.lib"

pause
