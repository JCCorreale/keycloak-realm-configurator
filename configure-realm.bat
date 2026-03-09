@echo off
setlocal enabledelayedexpansion

:: Defaults
set URL=http://localhost:8080
set USER=user
set PASSWORD=admin
set IMPORT=out/realm.yaml
set LOGKC=debug
set LOGHTTP=debug

:: Parse params
:parse
if "%~1"=="" goto endparse
set key=%~1
set val=%~2

if /I "%key%"=="-CONFIG" set CONFIG=%val%
if /I "%key%"=="-URL" set URL=%val%
if /I "%key%"=="-USER" set USER=%val%
if /I "%key%"=="-PASSWORD" set PASSWORD=%val%
if /I "%key%"=="-IMPORT" set IMPORT=%val%
if /I "%key%"=="-LOGKC" set LOGKC=%val%
if /I "%key%"=="-LOGHTTP" set LOGHTTP=%val%

shift
shift
goto parse
:endparse

:: gomplate command
if exist "%CONFIG%" (
  gomplate --verbose -c .=%CONFIG%
) else (
  gomplate --verbose
)

:: java command
java ^
 -agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=*:5020 ^
 -jar bin/keycloak-config-cli.jar ^
 --keycloak.url=%URL% ^
 --keycloak.user=%USER% ^
 --keycloak.password=%PASSWORD% ^
 --import.files.locations=%IMPORT% ^
 --logging.level.keycloak-config-cli=%LOGKC% ^
 --logging.level.http=%LOGHTTP%

endlocal