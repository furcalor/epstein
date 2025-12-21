@echo off
setlocal enabledelayedexpansion

echo Converting all PDFs in current folder...
echo.

set DPI=300
set ALPHABITS=2
set QUALITY=80
set FIRSTPAGE=1
set LASTPAGE=9999
set MEMORY=300

REM Path to Ghostscript
set "GS=%~dp0bin\gswin32c.exe"

if not exist "%GS%" (
    echo Ghostscript not found at: %GS%
    pause
    exit /b
)

for %%F in (*.pdf) do (
    echo Processing: %%F

    set "PDFFILE=%%F"
    set "JPGFILE=%%~nF-%%%d.jpg"

    "%GS%" ^
        -sDEVICE=jpeg ^
        -sOutputFile=!JPGFILE! ^
        -r%DPI% ^
        -dNOPAUSE ^
        -dFirstPage=%FIRSTPAGE% ^
        -dLastPage=%LASTPAGE% ^
        -dJPEGQ=%QUALITY% ^
        -dGraphicsAlphaBits=%ALPHABITS% ^
        -dTextAlphaBits=%ALPHABITS% ^
        -dNumRenderingThreads=4 ^
        -dBufferSpace=%MEMORY%000000 ^
        -dBandBufferSpace=%MEMORY%000000 ^
        -c %MEMORY%000000 setvmthreshold ^
        -f "!PDFFILE!" -c quit

    echo.
)

echo Finished.
pause