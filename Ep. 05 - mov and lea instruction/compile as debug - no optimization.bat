@echo off

call "C:\Program Files\Microsoft Visual Studio\18\Community\VC\Auxiliary\Build\vcvars64.bat"
cd /d C:\YourPath

nasm -f win64 file.asm -o file.obj -O0
link /subsystem:console /entry:main /DEBUG file.obj kernel32.lib

pause
