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

Write-Output "curl.exe `"https://ice-us-sfo-56006.icedrive.io/download?p=jW.yoj7WbBmCJ08wcDYktW4Vz0a.gx4uCx.1W.MIv6zdoxp0Zf.8ofhOmWN5AtsjKtIi8OqKVJnmiYmAlgSLp7Re_EKClSVuzADjEjL5AWPLx1grLr0bkSgnHUWUyO63Mb3cZkG2StI1lxRSPoi0rqJPzTYP3BuoJH07nYrHN0hNtkit57.qm0dw7wXclI25sDhZ42BVO2JdPJAXsqsRhg--`" -Lo Files_Library.wim"
