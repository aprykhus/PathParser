@echo off

SET SysRegPath=HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment
SET UsrRegPath=HKEY_CURRENT_USER\Environment

for /f "tokens=*" %%i IN ('reg query "%SysRegPath%" /v Path') DO set SYSVARPATH=%%i
for /f "tokens=*" %%i IN ('reg query "%UsrRegPath%" /v Path') DO set USRVARPATH=%%i
SET USRDATA=%USRVARPATH:~18%
SET SYSDATA=%SYSVARPATH:~25%
SET DATA=%SYSDATA%%USRDATA%

echo.
echo SYSTEM
echo ------
for /f "tokens=* delims= " %%f in ("%SYSDATA%") do (
  set line=%%f
  call :processToken
  )
  REM goto :eof
  
echo.
echo USER
echo ----
for /f "tokens=* delims= " %%f in ("%USRDATA%") do (
  set line=%%f
  call :processToken
  )
  goto :eof

:processToken

  for /f "tokens=1* delims=;" %%a in ("%line%") do (
  ECHO %%a
  set line=%%b
  )
  if not "%line%" == "" goto :processToken
  goto :eof