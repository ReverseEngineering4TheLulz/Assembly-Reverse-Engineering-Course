@echo off

call "C:\Program Files\Microsoft Visual Studio\18\Community\VC\Auxiliary\Build\vcvars64.bat"
cd /d C:\Users\YourUsername\Desktop\Assembly Programming\NASM

nasm -f win64 file.asm -o file.obj
link /subsystem:console /entry:main file.obj kernel32.lib

pause
cls

file.exe
