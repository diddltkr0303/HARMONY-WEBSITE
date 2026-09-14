' auto-sync.bat을 관리자 권한으로 실행 (로그 표시)
Set objShell = CreateObject("Shell.Application")
objShell.ShellExecute "cmd.exe", "/k cd /d ""C:\Users\diddl\OneDrive\바탕 화면\HARMONY-WEBSITE"" && call auto-sync.bat && echo. && echo 로그 파일 확인: auto-sync-log.txt && timeout /t 5", "", "runas", 1
