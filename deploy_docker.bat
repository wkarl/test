@echo off
setlocal

set /p DEFAULT=Would you like to use the default certificate (not recommended for production)? (y/n)



if "%DEFAULT%"=="y" (
  set /p CONFIRM=This will delete the existing certificate if present. Are you sure? Type YES to confirm:


  if "%CONFIRM%"=="YES" (
    echo Using default certificate. Remember to use your own certificate when moving to production!
    del cert\server.crt
    del cert\server.key
    copy cert\default\server.crt cert\
    copy cert\default\server.key cert\
  )
)

echo docker build -t asdf --load .

if errorlevel 1 (
    echo Docker build failed. Exiting.
    pause
    exit /b 1
)

docker network create asdf 2>nul

echo docker run --detach --name="asdf" -p 3000:3000 --network=asdf asdf

endlocal
pause

