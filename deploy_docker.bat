@echo off
setlocal

read -p "Would you like to use the default certificate (not recommended for production)? (y/n)" DEFAULT

echo -e "\n"

if [[ "$DEFAULT" == "y" ]]; then
  read -p "This will delete the existing certificate if present. Are you sure? Type YES to confirm: " CONFIRM
  echo -e "\n"

  if [[ "$CONFIRM" != "YES" ]]; then
    echo Using default certificate. Remember to use your own certificate when moving to production!
    del cert\server.crt
    del cert\server.key
    copy cert\default\server.crt cert\
    copy cert\default\server.key cert\
  fi
fi

echo docker build -t bla --load .

if errorlevel 1 (
    echo Docker build failed. Exiting.
    pause
    exit /b 1
)

docker network create blanetwork >nul


docker run --detach --name="bla" -p 3000:3000 --network=blanetwork bla

endlocal
pause

