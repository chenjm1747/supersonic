@echo off
chcp 65001 >nul
setlocal

REM ============================================
REM SuperSonic 开发编译启动脚本 (Windows)
REM ============================================

set "JAVA_HOME=D:\java\jdk-21.0.10.7-hotspot"
set "MVND_HOME=D:\maven-mvnd-1.0.5-windows-amd64"
set "PROJECT_DIR=E:\trae\supersonic"
set "TARGET_DIR=%PROJECT_DIR%\launchers\standalone\target\launchers-standalone-1.0.0-SNAPSHOT"
set "FRONTEND_DIR=%PROJECT_DIR%\webapp\packages\supersonic-fe"
set "STATIC_DIR=%TARGET_DIR%\classes\static"

echo ========================================
echo SuperSonic 编译和启动
echo ========================================

cd /d "%PROJECT_DIR%"

REM 设置环境变量
set "PATH=%JAVA_HOME%\bin;%MVND_HOME%\bin;%PATH%"

REM 1. 停止现有服务
echo.
echo [1/5] 停止现有服务...
taskkill /F /IM java.exe >nul 2>&1
timeout /t 2 /nobreak >nul

REM 2. 编译后端
echo.
echo [2/5] 编译后端...
call "%MVND_HOME%\bin\mvnd.exe" clean package -DskipTests -Dspotless.skip=true -pl launchers/standalone -am
if errorlevel 1 (
    echo 编译失败！
    pause
    exit /b 1
)

REM 3. 解压 tar.gz
echo.
echo [3/5] 检查编译产物...
if not exist "%TARGET_DIR%\lib" (
    echo 解压 tar.gz...
    cd /d "%PROJECT_DIR%\launchers\standalone\target"
    tar -xzf launchers-standalone-1.0.0-SNAPSHOT-bin.tar.gz
    cd /d "%PROJECT_DIR%"
)

REM 4. 编译前端
echo.
echo [4/5] 编译前端...
cd /d "%FRONTEND_DIR%"
call pnpm build:os
if errorlevel 1 (
    echo 前端编译失败！
    pause
    exit /b 1
)

REM 5. 部署前端到 static 目录
echo.
echo [5/5] 部署前端...
if exist "%STATIC_DIR%" rmdir /s /q "%STATIC_DIR%"
mkdir "%STATIC_DIR%"
xcopy /E /Y "%FRONTEND_DIR%\dist\*" "%STATIC_DIR%\"

REM 6. 启动服务
echo.
echo [6/6] 启动服务...
cd /d "%TARGET_DIR%"
start "SuperSonic" cmd /c "java -Dspring.profiles.active=local -Xms1024m -Xmx2048m -cp \"conf;lib\launchers-standalone-1.0.0-SNAPSHOT.jar;lib\*\" com.tencent.supersonic.StandaloneLauncher"

REM 等待启动
echo.
echo 等待服务启动（约20秒）...
timeout /t 20 /nobreak >nul

REM 验证
echo.
echo ========================================
echo 验证服务状态
echo ========================================
netstat -ano | findstr "9080"
if errorlevel 1 (
    echo 服务未启动，请检查日志
) else (
    echo.
    echo 服务已启动！
    echo   Web 应用: http://localhost:9080
    echo   Swagger:  http://localhost:9080/swagger-ui.html
    echo   Knife4j:  http://localhost:9080/doc.html
)

echo.
echo 日志位置: %TARGET_DIR%\logs\
echo.
pause
