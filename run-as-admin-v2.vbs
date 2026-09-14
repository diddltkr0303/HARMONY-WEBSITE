' 관리자 권한으로 배치 파일 실행
Set objShell = CreateObject("Shell.Application")
objShell.ShellExecute "cmd.exe", "/c cd /d ""C:\Users\diddl\OneDrive\바탕 화면\HARMONY-WEBSITE"" && setup-scheduler-DEBUG.bat", "", "runas", 1
