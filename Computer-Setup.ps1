## COMPUTER SETUP: LIBRARY (ELEVATION: REGULAR USER)
#
# Requires -Version 7.0

## DIRECTORIES IN HOME TO KEEP VISIBLE
#
Push-Location $env:USERPROFILE
#
[System.Collections.ArrayList]`
$HOME_DIRS      =  ( Get-ChildItem -Directory -Path $env:USERPROFILE ).Name
$HOME_DIRS_KEEP = @(
  # ".config"
  # ".ms-ad"
  # ".vscode"
  # "3D Objects"
  # "Contacts"
  "Desktop"  # Protected and remains visible.
  "Documents"
  "Downloads"
  # "Favorites"
  # "Links"
  # "Music"
  "OneDrive"
  "Pictures"
  "Program-Manager"
  # "Saved Games"
  # "Searches"
  # "Videos"
  "WindowsTerminal.lnk"
)
foreach ( $home_dir_keep in $HOME_DIRS_KEEP ) { $HOME_DIRS.Remove( "$home_dir_keep" ) }
Get-ChildItem -Path $env:USERPROFILE -Exclude $HOME_DIRS_KEEP `
  | ForEach-Object { $_.Attributes = $_.Attributes -bor [System.IO.FileAttributes]::Hidden }

Pop-Location

## APPLICATIONS REGISTER AND FTA'S ASSOCIATE
#
# SetUserFTA:                     https://setuserfta.com
# Variables Inside Single Quotes: https://stackoverflow.com/a/32127808/4515565
# Loops with multiple arrays:     https://stackoverflow.com/a/25192032/4515565
#
$PROGRAMS = @("code.cmd","inkscape.exe","floorp.exe")
$PATHS    = @(
  "$env:SCOOP\apps\vscode\current\bin\code.cmd"
  "$env:SCOOP\apps\inkscape\current\bin\inkscape.exe"
  "$env:SCOOP\apps\floorp-libportable\current\core\floorp.exe"
  # "$env:SCOOP\apps\floorp\current\floorp.exe"
  # "$env:SCOOP\apps\waterfox-portable\current\waterfox.exe"
)
#
for ( $i = 0 ; $i -lt $PROGRAMS.Length ; $i++ ) {
  $program = $PROGRAMS[$i]
  $path    = $PATHS[$i]
  New-Item         -Force -Path "HKCU:\SOFTWARE\Classes\Applications\$program\shell\open\command\" `
    | Out-Null
  Set-ItemProperty -Force -Path "HKCU:\SOFTWARE\Classes\Applications\$program\shell\open\command\" -Name "(default)" -Value "$path `"%1`"" }
#
$EXTENSIONS = ( ".code-workspace",".ini",".json",".log",".markdown",".md",".psm1",".ps1",".txt",".xml" )
foreach ( $extension in $EXTENSIONS ) {
  SetUserFTA.exe $extension Applications\code.cmd }
#
$EXTENSIONS = ( "microsoft-edge", "microsoft-edge-holographic", ".htm", ".html", ".pdf", ".shtml", ".xht", ".xhtml", "ftp", "http", "https" )
foreach ( $extension in $EXTENSIONS ) {
  SetUserFTA.exe $extension Applications\floorp.exe }
#
$EXTENSIONS = ( ".svg" )
foreach ( $extension in $EXTENSIONS ) {
  SetUserFTA.exe $extension Applications\inkscape.exe }

## DATE AND TIME (https://stackoverflow.com/q/36726738)
#
Set-ItemProperty -Path "HKCU:\Control Panel\International\" -Name sShortTime  -Value "HH:mm"
Set-ItemProperty -Path "HKCU:\Control Panel\International\" -Name sTimeFormat -Value "HH:mm:ss"
Set-ItemProperty -Path "HKCU:\Control Panel\International\" -Name sShortDate  -Value "yyMMdd ddd"
Set-ItemProperty -Path "HKCU:\Control Panel\International\" -Name sLongDate   -Value "yyyy, MMMM dd, dddd"
#
Set-TimeZone -Id "Pacific Standard Time"
#
# tzutil.exe /s "Pacific Standard Time"
# Set-ItemProperty -Path "HKCU:\Control Panel\International\" -Name sShortDate  -Value "yy.MM.dd.ddd"

## FONTS INSTALL <https://stackoverflow.com/q/60972345>
#
## List create (of fonts).
#
$FNT_PTHS = @(
  "$env:SCOOP\apps\merriweather\current\*.ttf"
  "$env:SCOOP\apps\roboto-slab\current\*.ttf"
  "$env:SCOOP\apps\roboto\current\*.ttf"
  "$env:SCOOP\apps\windows-terminal\current\*.ttf"
)
#
if ( ([Environment]::OSVersion.Version.Build) -ge 22000 ) {
  $FNT_PTHS[3] = $null
}
#
foreach ( $fnt_pth in $FNT_PTHS ) {
  $FNT_LST += Get-ChildItem -File -Path $fnt_pth -Exclude "static"
}
#
## Fonts register.
#
foreach ( $fnt in $FNT_LST ) {
  #
  # Font name acquire.
  #
  $FNT_DIR = $fnt | Split-Path -Parent
  $OBJ_SHL = New-Object -ComObject Shell.Application
  $SHL_DIR = $OBJ_SHL.Namespace($FNT_DIR)
  $SHL_FNT = $SHL_DIR.ParseName($fnt.Name)
  $FNT_NME = $SHL_DIR.GetDetailsOf($SHL_FNT, 21)
  #
  # Font register
  #
  $reg_pth = "HKCU:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Fonts"
  $INSTLLD = Get-ItemProperty -Path $reg_pth -Name "$FNT_NME (TrueType)" -ErrorAction SilentlyContinue
  if ( -not $INSTLLD ) {
    New-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Fonts" -Name "$FNT_NME (TrueType)" -PropertyType String -Value "$env:LOCALAPPDATA\Microsoft\Windows\Fonts\$fnt.Name" -Force | Out-Null
  }
}
#
## Font (add to font cache?!) <https://stackoverflow.com/a/58100621>
#
$fontCSharpCode = @'
using System;
using System.Collections.Generic;
using System.Text;
using System.IO;
using System.Runtime.InteropServices;
namespace FontResource
{
  public class AddRemoveFonts
  {
    [DllImport("gdi32.dll")]
    static extern int AddFontResource(string lpFilename);
    public static int AddFont(string fontFilePath) {
      try 
      {
        return AddFontResource(fontFilePath);
      }
      catch
      {
        return 0;
      }
    }
  }
}
'@

if ( [FontResource.AddRemoveFonts] ) {}
else { Add-Type $fontCSharpCode }

foreach( $font in $FNT_LST ) {
  Write-Output "Loading $($font.FullName)"
  [FontResource.AddRemoveFonts]::AddFont($font.FullName) | Out-Null
}


## KEYBOARD: NUMLOCK ON AND LEAVE ON, HOTKEY FOR INPUT LANGUAGE SWITCHING DISABLE
## https://superuser.com/a/813818/532630
#
if ( ! ( [console]::NumberLock ) ) { (New-Object -ComObject WScript.Shell).SendKeys('{NUMLOCK}') }
Set-ItemProperty -Path "HKCU:\Control Panel\Keyboard\" -Name "InitialKeyboardIndicators" -Value "2"
#
# https://www.elevenforum.com/t/turn-on-or-off-use-different-keyboard-layout-for-each-app-window-in-windows-11.4109/
#
# Set-WinLanguageBarOption
Set-WinLanguageBarOption -UseLegacySwitchMode -UseLegacyLanguageBar
#
$HKCUKeyboardLayoutToggle = 'HKCU:\Keyboard Layout\Toggle\'
Set-ItemProperty -Path $HKCUKeyboardLayoutToggle -Name 'Language Hotkey' -Value 3
Set-ItemProperty -Path $HKCUKeyboardLayoutToggle -Name 'Layout Hotkey' -Value 3
Set-ItemProperty -Path $HKCUKeyboardLayoutToggle -Name 'Hotkey' -Value 3

## VOLUME (https://stackoverflow.com/q/21355891/4515565)
#
function Volume_Set($volume) { $WshShell = New-Object -ComObject WScript.Shell;1..50 | ForEach-Object { $WshShell.SendKeys([char]174)}; $volume = $volume / 2;1..$volume | ForEach-Object { $WshShell.SendKeys([char]175) } }
Volume_Set -Volume 8

## DISPLAY: ADJUST BRIGHTNESS AND COLOR
#
Invoke-CimMethod -InputObject $(Get-CimInstance -Namespace root/WMI -ClassName WmiMonitorBrightnessMethods) -MethodName WmiSetBrightness -Arguments @{Timeout=10;Brightness=$env:DSP_BRT} | Out-Null

#
# Copy-Item -Force "$env:USERPROFILE\Documents\= Computer Setup =\Profile_Display_Pima_12.icc" "C:\Windows\System32\spool\drivers\color\"
# colorcpl.exe

## MOUSE: BUTTONS SWAP (https://stackoverflow.com/q/4806575)
#
$api = Add-Type -PassThru -Namespace Win32 -Name Win32SwapMouseButton -MemberDefinition @'
    [DllImport("user32.dll")]
    public static extern bool SwapMouseButton(bool fSwap);
'@
$api::SwapMouseButton($True)

## MOUSE: SENSITIVITY ADJUST (https://stackoverflow.com/a/71195076), (https://bit.ly/3Ug2s8e)
#
Set-StrictMode -Off
$winApi = add-type -name user32 -namespace tq84 -passThru -memberDefinition '
  [DllImport("user32.dll")]
    public static extern bool SystemParametersInfo(
      uint uiAction,
      uint uiParam ,
      uint pvParam ,
      uint fWinIni
    );
'
$SPI_SETMOUSESPEED = 0x0071   # 113
$MSE_SEN_BFR       = $( (Get-ItemProperty "HKCU:\Control Panel\Mouse").MouseSensitivity )
$null = $winApi::SystemParametersInfo($SPI_SETMOUSESPEED, 0, $env:MSE_SNS, 0)
Set-ItemProperty "HKCU:\Control Panel\Mouse" -Name MouseSensitivity -Value $env:MSE_SNS
   # Mouse Sensitivity only stored temporarily, needs to be changed in registry as well.
$MSE_SEN_AFT = $( (Get-ItemProperty "HKCU:\Control Panel\Mouse").MouseSensitivity )
" Mouse Sensitivity From: $MSE_SEN_BFR To: $MSE_SEN_AFT"

## MOUSE POINTER CHANGE TO INVERTED
#
Set-StrictMode -Version Latest
$RegConnect = [Microsoft.Win32.RegistryKey]::OpenRemoteBaseKey([Microsoft.Win32.RegistryHive]"CurrentUser","$env:COMPUTERNAME")
$RegCursors = $RegConnect.OpenSubKey("Control Panel\Cursors",$true)
$RegCursors.SetValue("","Windows Inverted")
$RegCursors.SetValue("CursorBaseSize",0x40)     # 64 FAIL
$RegCursors.SetValue("CursorBaseSize",0x20)     # 32
$RegCursors.SetValue("AppStarting","%SystemRoot%\cursors\wait_i.cur")
$RegCursors.SetValue("Arrow","%SystemRoot%\cursors\arrow_i.cur")
$RegCursors.SetValue("Crosshair","%SystemRoot%\cursors\cross_i.cur")
$RegCursors.SetValue("Hand","")
$RegCursors.SetValue("Help","%SystemRoot%\cursors\help_i.cur")
$RegCursors.SetValue("IBeam","%SystemRoot%\cursors\beam_i.cur")
$RegCursors.SetValue("No","%SystemRoot%\cursors\no_i.cur")
$RegCursors.SetValue("NWPen","%SystemRoot%\cursors\pen_i.cur")
$RegCursors.SetValue("SizeAll","%SystemRoot%\cursors\move_i.cur")
$RegCursors.SetValue("SizeNESW","%SystemRoot%\cursors\size1_i.cur")
$RegCursors.SetValue("SizeNS","%SystemRoot%\cursors\size4_i.cur")
$RegCursors.SetValue("SizeNWSE","%SystemRoot%\cursors\size2_i.cur")
$RegCursors.SetValue("SizeWE","%SystemRoot%\cursors\size3_i.cur")
$RegCursors.SetValue("UpArrow","%SystemRoot%\cursors\up_i.cur")
$RegCursors.SetValue("Wait","%SystemRoot%\cursors\busy_i.cur")
$RegCursors.Close()
$RegConnect.Close()
#
$CSharpSig = @'
[DllImport("user32.dll", EntryPoint = "SystemParametersInfo")]
public static extern bool SystemParametersInfo(
                  uint uiAction,
                  uint uiParam,
                  uint pvParam,
                  uint fWinIni);
'@
$CursorRefresh = Add-Type -MemberDefinition $CSharpSig -Name WinAPICall -Namespace SystemParamInfo -PassThru
$CursorRefresh::SystemParametersInfo(0x2029, 0, 32, 0x01);
$CursorRefresh::SystemParametersInfo(0x0057,0,$null,0)
# Out-Null here?!

## OTHER
#
# PowerShell: Profile location redefine.
#
# New-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders" -Name "Personal" -PropertyType String -Value "$env:APPDATA\Microsoft\Windows" -Force | Out-Null
#
# Explorer: View set for default as "Details", https://superuser.com/a/1300695/532630
#
# Remove-Item -Path "HKCU:\Software\Classes\Local Settings\Software\Microsoft\Windows\Shell\Bags\" -Force -Recurse
# Remove-Item -Path "HKCU:\Software\Classes\Local Settings\Software\Microsoft\Windows\Shell\BagMRU\" -Force -Recurse
# New-Item -Force -Path "HKCU:\Software\Classes\Local Settings\Software\Microsoft\Windows\Shell\Bags\AllFolders\Shell\{5C4F28B5-F869-4E84-8E60-F11DB97C5CC7}"
# New-ItemProperty -Path "HKCU:\Software\Classes\Local Settings\Software\Microsoft\Windows\Shell\Bags\AllFolders\Shell\{5C4F28B5-F869-4E84-8E60-F11DB97C5CC7}" -Name FileOpenDialog -PropertyType DWord -Value 0x00000004
# New-ItemProperty -Path "HKCU:\Software\Classes\Local Settings\Software\Microsoft\Windows\Shell\Bags\AllFolders\Shell\{5C4F28B5-F869-4E84-8E60-F11DB97C5CC7}" -Name LogicalViewMode -PropertyType DWord -Value 0x00000004
# #
# $FldrTypes = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderTypes'
# $hkcuBags  = 'HKCU:\Software\Classes\Local Settings\Software\Microsoft\Windows\Shell\Bags'

# gci $FldrTypes | gp | ? CanonicalName -match '\.SearchResults$' | %{
#     New-Item ('{0}\AllFolders\Shell\{1}' -f $hkcuBags , $_.PSChildName) -Force |
#         Set-ItemProperty -Name '(Default)' -Value (gp $_.PSPath).CanonicalName -PassThru |
#         New-ItemProperty -Name Mode            -value 4  |
#         New-ItemProperty -Name IconSize        -value 16 |
#         New-ItemProperty -Name LogicalViewMode -value 1  | Get-Item ### Dislpays key after creation
#     $hkcuBags | gci | ? PSChildName -match '\d+' | gci -s | ? PSChildName -eq $_.PSChildName | Remove-Item
# }

## FILES FOR LIBRARY FIX PATH (REPLACE USERPROFILE PART FOR PORTABLE USE).
#
$ENV_USERPROFILE = $env:USERPROFILE
$ENV_USERPROFILE_LINUX = ($ENV_USERPROFILE) -replace "\\","/"  # REPLACE \ WITH / FOR LINUX
#
# C:\Users\RMLO\Program-Manager\persist\vscode\data\user-data\User\settings.json
#
# GIT (COMPARE ORIGINAL WITH NEW, PATH REPLACE WITH PROMPT)
#
$GITCONFIGS = @(
  "$env:HOME\.gitconfig"
  "$env:SCOOP\persist\git-persist\etc\gitconfig" )
#
foreach ( $gitconfig in $GITCONFIGS ) {
  Select-String -Pattern "C:/Users(/).*?(/)" -Path $gitconfig
  # -Raw
  Write-Output "====="
  (Get-Content $gitconfig) -replace "C:/Users(/).*?(/)","$ENV_USERPROFILE_LINUX/"
  Write-Output "====="
  #
  $ANSWER = Read-Host "${gitconfig}: replace with new PATH? (y/n)"
  if ( $ANSWER -eq "y" -or $ANSWER -eq "Y") {
    (Get-Content $gitconfig) -replace "C:/Users(/).*?(/)","$ENV_USERPROFILE_LINUX/" `
      | Set-Content $gitconfig } }
#
# POWERSHELL (COMMENTED BECAUSE I USUALLY USER ENV:USERPROFILE)
#
( Get-Content $( Get-PSReadLineOption ).HistorySavePath ) -replace "C:\\Users\\.*?\\","$ENV_USERPROFILE\" | Set-Content $( Get-PSReadLineOption ).HistorySavePath
#
# WEB BROWSER
#
# $FILES_INIS = "$env:SCOOP\apps\floorp\Profiles\AppData\Floorp\profiles.ini"
# Write-Output "====="
# Get-Content $FILES_INIS
# Write-Output "====="
# $FILES_INIS | ForEach-Object { (Get-Content $_) -replace "C:\\Users\\.*?\\","$ENV_USERPROFILE\" }
# Write-Output "====="
# $ANSWER = Read-Host "Floorp's profile.ini replace with new PATH? (y/n)"
# if ( $ANSWER -eq "y" -or $ANSWER -eq "Y") {
#  $FILES_INIS | ForEach-Object { (Get-Content $_) -replace "C:\\Users\\.*?\\","$ENV_USERPROFILE\" `
#   | Set-Content $_ }
# }
#
# SCOOP: INSTALLS THAT ARE LOCAL CHANGE PATH IN install.json FOR PORTABILITY.
#
# $ENV_USERPROFILE_SCOOP = ($ENV:USERPROFILE) -replace "\\","\\"
# $FILES_INST = (Get-ChildItem -File -Path $env:SCOOP\manifests-local\*.json).BaseName
# #
# foreach ( $file in $FILES_INST ) {
#   (Get-Content "$env:SCOOP\apps\$file\current\install.json") -replace "C:\\\\Users\\.*?(\\\\)","$ENV_USERPROFILE_SCOOP\\" }
# #
# $ANSWER = Read-Host "Scoop replace local install.jsons with new PATH? (y/n)"
# if ( $ANSWER -eq "y" -or $ANSWER -eq "Y") {
#   foreach ( $file in $FILES_INST ) {
#     (Get-Content "$env:SCOOP\apps\$file\current\install.json") -replace "C:\\\\Users\\.*?(\\\\)","$ENV_USERPROFILE_SCOOP\\" `
#     | Set-Content "$env:SCOOP\apps\$file\current\install.json" }
#   # $file | ForEach-Object { (Get-Content $_) -replace "C:\\\\Users(\\\\).*?(\\\\)","$ENV_USERPROFILE_SCOOP\\" | Set-Content $_ 
# }


## WINDOWS-TERMINAL START
#
# wt.exe fails to find the settings?!
#echo "PowerShell: New settings loading..."
#Invoke-Command { . pwsh.exe -nologo } -NoNewScope
# conhost.exe powershell.exe -ExecutionPolicy Unrestricted -NoExit -NoProfile -Command "echo '$env:SCOOP\apps\scoop\current\bin\scoop.ps1 update pwsh,windows-terminal'"
# wt new-tab --help
# wt new-tab --profile "pwsh"
#
# $EXE_TERM = (Get-ChildItem -Path $env:SCOOP\apps\windows-terminal -Filter wt.exe -Recurse).FullName | Select-Object -First 1
#
#
# start $EXE_TERM
# start $env:USERPROFILE\WindowsTerminal.lnk
# Start-Process     -FilePath $EXE_TERM
# Invoke-Expression -Command  $EXE_TERM
# &($EXE_TERM)


## HELP
#
# Add script execution checks: https://bit.ly/4fkuBDb ; ScriptAnalyze: https://bit.ly/3SuMeXd
# Setting Windows PowerShell environment variables  https://stackoverflow.com/a/27524483/4515565
#
# [System.Environment]::SetEnvironmentVariable("SCOOP_GLOBAL","$env:SCOOP\","Machine")
#
# `New-Item -ItemType Junction`: target requires absolute path, mklink can be relative.
#

Pop-Location
# Shell restart or Close and open new shell
# Variables that are for process... remove.


# # store this shell's parent PID for later use
# $parentPID = $PID
# # get the the path of this shell's executable
# $thisExePath = (Get-Process -Id $PID).Path
# # start a new shell, same window
# Start-Process $thisExePath -NoNewWindow
# # stop this shell if it's still alive
# Stop-Process -Id $parentPID -Force

# Start-Process $PID -NoNewWindow && Stop-Process -Id $PID -Force
# Get-Process -Id $PID | Select-Object -ExpandProperty Path | ForEach-Object { Start-Process -NoNewWindow $_ }

# Set-ItemProperty HKCU:\Environment\ -Name INKSCAPE_PROFILE_DIR -Value "$env:USERPROFILE\AppData\Roaming\inkscape"
# By default set to %appdata%/inkscape... did I bother for certain reason??
