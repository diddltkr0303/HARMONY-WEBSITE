@echo off
chcp 65001 >nul

echo.
echo =========================================
echo HARMONY 웹사이트 자동 업로드 스케줄 설정
echo =========================================
echo.

REM 기존 작업 삭제 (있으면)
schtasks /delete /tn "HARMONY-Auto-Sync" /f 2>nul

echo ✓ 기존 스케줄 제거 완료
echo.

REM 새 작업 생성 - 5분마다 실행
echo 새로운 스케줄을 생성 중입니다...
schtasks /create /tn "HARMONY-Auto-Sync" /tr "cmd /c C:\Users\diddl\OneDrive\바탕 화면\HARMONY-WEBSITE\auto-sync.bat" /sc minute /mo 5 /f

if %errorlevel% equ 0 (
    echo.
    echo =========================================
    echo ✅ 설정 완료!
    echo =========================================
    echo 📅 매 5분마다 자동으로 GitHub에 업로드됩니다.
    echo 🔄 변경사항이 있을 때만 업로드됩니다.
    echo.
    echo 📝 참고:
    echo - VSCode에서 파일 수정 후 저장하면 자동 감지
    echo - 지금부터 5분 이내에 GitHub에 업로드됨
    echo.
    timeout /t 5
) else (
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
    pause
)

exit /b 0
