## Scoop requires applications `pwsh` and `windows-terminal` to be updated with PowerShell 5.1.
#
if ( Get-Process -Name OpenConsole ) {
  # Stop-Process -Name OpenConsole
  echo "Stop-Process -Name OpenConsole"
  exit
}
if ( Get-Process -Name OpenConsole ) {
  # Stop-Process -Name WindowsTerminal
  echo "Stop-Process -Name WindowsTerminal"
  exit
}
conhost.exe powershell.exe -ExecutionPolicy Unrestricted -NoExit -NoProfile -Command "$env:USERPROFILE\Program-Manager\apps\scoop\current\bin\scoop.ps1 update pwsh,windows-terminal"
