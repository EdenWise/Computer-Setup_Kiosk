## Locate PowerShell-7/pwsh.exe (because location varies because path depends on version) and start.
#
$EXE_TERM = Get-ChildItem -Exclude "current" -Path $env:USERPROFILE\Program-Manager\apps\windows-terminal\*\WindowsTerminal.exe | Sort-Object -Property LastWriteTime -Descending | Select-Object -First 1 -ExpandProperty FullName
$EXE_PWSH = (Get-ChildItem -Exclude "current" -Path $env:USERPROFILE\Program-Manager\apps\pwsh\*\pwsh.exe).FullName | Select-Object -First 1
#
New-Alias winterm.exe $EXE_TERM -Force
winterm.exe
