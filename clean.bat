@echo off

del *.exe > nul 2>&1
rmdir .vscode > nul 2>&1
if exist RGFW pushd RGFW
del *.dll > nul 2>&1
del *.o > nul 2>&1
if exist lib pushd lib
del *.lib > nul 2>&1
popd
popd