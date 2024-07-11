@echo off

if defined VSCMD_VER goto compile
if defined env_set goto compile

REM Check for Visual Studio 2022
if not defined vs_path (
    if exist "%ProgramFiles%\Microsoft Visual Studio\2022\Community\VC\Auxiliary\Build\vcvars64.bat" (
        set "vs_path=%ProgramFiles%\Microsoft Visual Studio\2022\Community\VC\Auxiliary\Build\vcvars64.bat"
    ) else (
        REM Check for Visual Studio 2019
        if exist "%ProgramFiles%\Microsoft Visual Studio\2019\Community\VC\Auxiliary\Build\vcvars64.bat" (
            set "vs_path=%ProgramFiles%\Microsoft Visual Studio\2019\Community\VC\Auxiliary\Build\vcvars64.bat"
        ) else (
            REM Check for Visual Studio 2017
            if exist "%ProgramFiles(x86)%\Microsoft Visual Studio\2017\Community\VC\Auxiliary\Build\vcvars64.bat" (
                set "vs_path=%ProgramFiles(x86)%\Microsoft Visual Studio\2017\Community\VC\Auxiliary\Build\vcvars64.bat"
            ) else (
                echo Visual Studio environment not found.
                exit /b 1
            )
        )
    )
)

if defined vs_path (
    call "%vs_path%"
    set "env_set=1"
)

:compile
pushd rgfw
cl -nologo -TC -c rgfw.c -wd4005
lib -nologo rgfw.obj -out:RGFW.lib
popd
