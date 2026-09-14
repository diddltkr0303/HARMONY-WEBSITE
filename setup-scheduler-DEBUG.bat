@echo off
chcp 65001 >nul

echo.
echo =========================================
echo HARMONY 웹사이트 자동 업로드 스케줄 설정
echo =========================================
echo.

REM 로그 파일 생성
set LOG_FILE=C:\Users\diddl\OneDrive\바탕 화면\HARMONY-WEBSITE\setup-log.txt
(
echo [%date% %time%] 설정 시작
) > %LOG_FILE%

REM git 설치 확인
echo [진단] git 설치 확인 중...
git --version >> %LOG_FILE% 2>&1
if %errorlevel% neq 0 (
    echo.
    echo ❌ ERROR: git이 설치되지 않았습니다!
    echo Git을 먼저 설치해주세요: https://git-scm.com/download/win
    echo.
    pause
    exit /b 1
)
echo ✓ git 설치 확인됨
echo [진단] git OK >> %LOG_FILE%

REM 폴더 확인
echo [진단] 폴더 확인 중...
cd /d "C:\Users\diddl\OneDrive\바탕 화면\HARMONY-WEBSITE" 2>> %LOG_FILE%
if %errorlevel% neq 0 (
    echo.
    echo ❌ ERROR: 폴더를 찾을 수 없습니다!
    echo C:\Users\diddl\OneDrive\바탕 화면\HARMONY-WEBSITE
    echo.
    pause
    exit /b 1
)
echo ✓ 폴더 확인됨
echo [진단] 폴더 OK >> %LOG_FILE%

REM git 저장소 확인
echo [진단] git 저장소 확인 중...
git status >> %LOG_FILE% 2>&1
if %errorlevel% neq 0 (
    echo.
    echo ❌ ERROR: git 저장소가 아닙니다!
    echo 이 폴더에 .git 폴더가 없습니다.
    echo.
    pause
    exit /b 1
)
echo ✓ git 저장소 확인됨
echo [진단] git 저장소 OK >> %LOG_FILE%

REM 기존 작업 삭제 (있으면)
echo [설정] 기존 스케줄 제거 중...
schtasks /delete /tn "HARMONY-Auto-Sync" /f 2>> %LOG_FILE%
echo [설정] 기존 스케줄 제거 완료 >> %LOG_FILE%

REM 새 작업 생성 - 5분마다 실행
echo [설정] 새 스케줄 생성 중...
schtasks /create /tn "HARMONY-Auto-Sync" /tr "cmd /c C:\Users\diddl\OneDrive\바탕 화면\HARMONY-WEBSITE\auto-sync.bat" /sc minute /mo 5 /f 2>> %LOG_FILE%

if %errorlevel% equ 0 (
    echo [설정] 성공 >> %LOG_FILE%
    echo.
    echo =========================================
    echo ✅ 설정 완료!
    echo =========================================
    echo 📅 매 5분마다 자동으로 GitHub에 업로드됩니다.
    echo 🔄 변경사항이 있을 때만 업로드됩니다.
    echo.
    echo 📝 로그:
    echo C:\Users\diddl\OneDrive\바탕 화면\HARMONY-WEBSITE\setup-log.txt
    echo.
    timeout /t 3
) else (
    echo [설정] 실패 >> %LOG_FILE%
    echo.
    echo =========================================
    echo ❌ 설정 실패!
    echo =========================================
    echo.
    echo 해결 방법:
    echo 1. 이 파일을 마우스 우클릭
    echo 2. "관리자 권한으로 실행" 선택
    echo 3. 다시 시도
    echo.
    echo 로그: C:\Users\diddl\OneDrive\바탕 화면\HARMONY-WEBSITE\setup-log.txt
    echo.
    pause
    exit /b 1
)

exit /b 0
