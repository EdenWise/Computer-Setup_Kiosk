## COMPUTER SETUP ON A KIOSK, DOWNLOAD SCRIPTS.
### "https://raw.githubusercontent.com/EdenWise/Computer-Setup_Kiosk/master/7za.exe"
### Start-BitsTransfer -Asynchronous -Source $uri -Destination "$PWD\$(Split-Path -Leaf $uri)"
### curl.exe https://bit.ly/cskdo -Lo CSK-Download.ps1

$URIS = @(
  "https://7-zip.org/a/7zr.exe"
  #
  "https://raw.githubusercontent.com/EdenWise/Computer-Setup_Kiosk/refs/heads/main/Archive-Extract.ps1"
  "https://raw.githubusercontent.com/EdenWise/Computer-Setup_Kiosk/refs/heads/main/Computer-Setup.ps1"
  "https://raw.githubusercontent.com/EdenWise/Computer-Setup_Kiosk/refs/heads/main/pwsh-start.ps1"
  "https://raw.githubusercontent.com/EdenWise/Computer-Setup_Kiosk/refs/heads/main/pwsh-update.ps1"
  #
)

foreach ( $uri in $URIS ) {
  curl.exe --location --remote-name --remote-time $uri
}

Write-Output "curl.exe `"https://ice-us-sfo-103085.icedrive.io/download?p=KB_S2Y5WMfzksd8x2.ELmZZsz2l2ia8uaIS6KdLWuBDdoxp0Zf.8ofhOmWN5AtsjKtIi8OqKVJnmiYmAlgSLp7Re_EKClSVuzADjEjL5AWN8I0MEpsisvpsYmCbuTgDmOow3.WF_RY9V02yMV9l8J0tEyZ.lte7vdFrXm1IETipNtkit57.qm0dw7wXclI25sDhZ42BVO2JdPJAXsqsRhg--`" -Lo Files_Library.wim"
