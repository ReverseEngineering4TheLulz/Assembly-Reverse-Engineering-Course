@echo off

call "C:\Program Files\Microsoft Visual Studio\18\Community\VC\Auxiliary\Build\vcvars64.bat"
cd /d C:\Users\YourUsername\Desktop\ASM

nasm -f win64 file.asm -o file.obj
link /subsystem:console /entry:main /DEBUG file.obj kernel32.lib

