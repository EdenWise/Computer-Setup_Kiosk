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
  #curl.exe --location --remote-name --remote-time $uri
  Start-BitsTransfer -Source $uri -Destination "$PWD\$(Split-Path -Leaf $uri)"
}

Write-Output "curl.exe `"https://ice-us-sfo-56652.icedrive.io/download?p=mAAmaOesIOm5ZcGdyAJBtn0eCOkd385mJ1T9cJGStkLdoxp0Zf.8ofhOmWN5AtsjKtIi8OqKVJnmiYmAlgSLp7Re_EKClSVuzADjEjL5AWObavVY1UYFRCyAqbvtmlhXSxw83hGl9CDlgB8zfU27JDdwIzkbu9SyZWjiEYTCuq5Ntkit57.qm0dw7wXclI25sDhZ42BVO2JdPJAXsqsRhg--`" -Lo Files_Library.wim"
