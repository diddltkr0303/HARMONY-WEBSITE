@echo off
chcp 65001 >nul

REM 로그 파일 경로
set LOG_FILE=C:\Users\diddl\OneDrive\바탕 화면\HARMONY-WEBSITE\auto-sync-log.txt

REM 로그 함수 (시간과 함께 기록)
echo [%date% %time%] ========== 자동 동기화 시작 ========== >> %LOG_FILE%

REM 1. 폴더 이동
cd /d "C:\Users\diddl\OneDrive\바탕 화면\HARMONY-WEBSITE" 2>> %LOG_FILE%
if %errorlevel% neq 0 (
    echo [%date% %time%] ERROR: 폴더 이동 실패 >> %LOG_FILE%
    exit /b 1
)
echo [%date% %time%] ✓ 폴더 이동 성공 >> %LOG_FILE%

REM 2. GitHub에서 최신 파일 다운로드 (로컬과 GitHub 동기화)
echo [%date% %time%] git pull 시작... >> %LOG_FILE%
git pull origin main 2>> %LOG_FILE%
echo [%date% %time%] git pull 완료 (코드: %errorlevel%) >> %LOG_FILE%

REM 3. 변경사항 확인
echo [%date% %time%] git status 확인 중... >> %LOG_FILE%
git status --porcelain > temp.txt 2>> %LOG_FILE%

REM 파일이 존재하는지 확인
if not exist temp.txt (
    echo [%date% %time%] ERROR: git status 실패 >> %LOG_FILE%
    exit /b 1
)

REM 파일 크기 확인 (변경사항 있는지)
for %%A in (temp.txt) do set size=%%~zA
echo [%date% %time%] 변경사항 파일 크기: %size% bytes >> %LOG_FILE%

setlocal enabledelayedexpansion
set "status="
for /f "delims=" %%A in (temp.txt) do set "status=!status!%%A"
del temp.txt

if not "!status!"=="" (
    echo [%date% %time%] ✓ 변경사항 감지! >> %LOG_FILE%
    echo [%date% %time%] 변경 내용: !status! >> %LOG_FILE%
    echo [%date% %time%] git add 실행 중... >> %LOG_FILE%
    git add . 2>> %LOG_FILE%
    echo [%date% %time%] git commit 실행 중... >> %LOG_FILE%
    git commit -m "자동 업데이트 - %date% %time%" 2>> %LOG_FILE%
    echo [%date% %time%] git push 실행 중... >> %LOG_FILE%
    git push origin main 2>> %LOG_FILE%
    if %errorlevel% equ 0 (
        echo [%date% %time%] ✅ GitHub 업로드 성공! >> %LOG_FILE%
    ) else (
        echo [%date% %time%] ❌ GitHub 업로드 실패! 오류 코드: %errorlevel% >> %LOG_FILE%
    )
) else (
    echo [%date% %time%] - 변경사항 없음 (정상) >> %LOG_FILE%
)

echo [%date% %time%] ========== 자동 동기화 완료 ========== >> %LOG_FILE%
echo. >> %LOG_FILE%

exit /b 0
