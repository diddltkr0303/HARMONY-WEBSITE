@echo off
chcp 65001 >nul
cd /d "C:\Users\diddl\OneDrive\바탕 화면\HARMONY-WEBSITE"

REM 변경사항 확인
git status --porcelain > temp.txt
set /p status=<temp.txt
del temp.txt

if not "%status%"=="" (
    echo [%date% %time%] 변경사항 감지! GitHub에 업로드 중...
    git add .
    git commit -m "자동 업데이트 - %date% %time%"
    git push origin main
    echo [%date% %time%] 완료!
) else (
    echo [%date% %time%] 변경사항 없음
)

exit /b 0
