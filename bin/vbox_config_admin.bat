@ECHO OFF
IF NOT "%~f0" == "~f0" GOTO :WinNT
@"C:\Ruby\bin\rake.bat" "vbox_config_admin" %1 %2 %3 %4 %5 %6 %7 %8 %9
GOTO :EOF
:WinNT
@"C:\Ruby\bin\rake.bat" -f "%~d0%~p0%~n0" %*
