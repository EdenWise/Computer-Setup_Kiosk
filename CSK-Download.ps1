## COMPUTER SETUP ON A KIOSK, DOWNLOAD SCRIPTS.
### "https://raw.githubusercontent.com/EdenWise/Computer-Setup_Kiosk/master/7za.exe"
### Start-BitsTransfer -Asynchronous -Source $uri -Destination "$PWD\$(Split-Path -Leaf $uri)"
### curl.exe https://bit.ly/cskdo -Lo CSK-Download.ps1
### Set-ExecutionPolicy Unrestricted CurrentUser

$URIS = @(
  "https://7-zip.org/a/7zr.exe"
  #
  "https://raw.githubusercontent.com/EdenWise/Computer-Setup_Kiosk/refs/heads/main/Archive-Extract.ps1"
  "https://raw.githubusercontent.com/EdenWise/Computer-Setup_Kiosk/refs/heads/main/Computer-Setup.ps1"
  "https://raw.githubusercontent.com/EdenWise/Computer-Setup_Kiosk/refs/heads/main/pwsh-update.ps1"
  "https://raw.githubusercontent.com/EdenWise/Computer-Setup_Kiosk/refs/heads/main/wt-start.ps1"
  #
)

foreach ( $uri in $URIS ) {
  # Start-BitsTransfer -Source $uri -Destination "$PWD\$(Split-Path -Leaf $uri)"
  curl.exe --location --remote-name --remote-time $uri
}

# Write-Output "curl.exe `"https://ice-us-sfo-57081.icedrive.io/download?p=BbzEARLuiCYZ_F.FwJ4QqYVA9kL4JH4uJdXFJEAGwOLdoxp0Zf.8ofhOmWN5AtsjKtIi8OqKVJnmiYmAlgSLp7Re_EKClSVuzADjEjL5AWNQvSvyQG.dEFqizHKi159_aq4pTCkSe7H6OIX7MMcwFflzxXY6E9flKg2YDXLbYFFNtkit57.qm0dw7wXclI25sDhZ42BVO2JdPJAXsqsRhg--`" -Lo Files_Library.wim"
