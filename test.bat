@echo off
setlocal



FOR /F "delims=" %%v IN ('echo data') DO (
    IF "%%v"=="data" (
        goto found
    )
)

echo Volume 'data' does not exist yet and will be created...
echo docker volume create data
goto notfound

:found
echo Volume 'data' found, re-using it...

:notfound

:: Run the Docker container with both env vars
echo docker run ... -v data:/api imagefile

endlocal
pause


