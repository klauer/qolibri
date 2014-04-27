@echo off

set proj_path=%1
cd "%proj_path%"

echo (gitversion.h) Project path is: %proj_path%

FOR /F "delims=" %%i IN ('git log -1 --format^=format:%%ci') DO set GIT_TIME=%%i
FOR /F "delims=" %%i IN ('git rev-parse -q --short --verify HEAD') DO set GIT_HASH=%%i

echo #ifndef _GITVERSION_H_ > gitversion.h
echo #define _GITVERSION_H_ >> gitversion.h
echo #define GITTIME "%GIT_TIME%" >> gitversion.h
echo #define GITHASH "%GIT_HASH%" >> gitversion.h
echo #endif >> gitversion.h
