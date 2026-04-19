@echo off
REM Compile Script for SuperSonic Project
REM Created: 2026-04-13

echo Setting Java Environment...
set JAVA_HOME=D:\java\jdk-21.0.10.7-hotspot
set PATH=%JAVA_HOME%\bin;%PATH%

echo Verifying Java Version...
java -version

echo.
echo Starting Maven Build...
cd /d E:\trae\supersonic

REM Clean and build
call "D:\maven-mvnd-1.0.5-windows-amd64\bin\mvnd.exe" clean package -DskipTests -pl launchers/standalone -am

echo.
echo Build completed.
pause
