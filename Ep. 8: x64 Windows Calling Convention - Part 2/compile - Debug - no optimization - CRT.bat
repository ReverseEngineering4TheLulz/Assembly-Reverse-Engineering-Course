@echo off

call "C:\Program Files\Microsoft Visual Studio\18\Community\VC\Auxiliary\Build\vcvars64.bat"
cd /d C:\Users\Dominik\Desktop\Assembly Programming\NASM

nasm -f win64 file.asm -o file.obj -O0
link file.obj /subsystem:console kernel32.lib legacy_stdio_definitions.lib msvcrt.lib

pause

