## COMPUTER SETUP ON A KIOSK, DOWNLOAD SCRIPTS.
### "https://raw.githubusercontent.com/EdenWise/Computer-Setup_Kiosk/master/7za.exe"
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
  # Start-BitsTransfer -Asynchronous -Source $uri -Destination "$PWD\$(Split-Path -Leaf $uri)"
}

Write-Output "curl.exe `"https://icecube-eu-306.icedrive.io/download?p=8e7mJF02YX2R1adF.rspKU1m1XWeEPlnpkSb3zhay6jdoxp0Zf.8ofhOmWN5AtsjKtIi8OqKVJnmiYmAlgSLp7Re_EKClSVuzADjEjL5AWNaq11P1Qoly6VK234wTnCrTv_qrID6gsl8dYRfd2Fzg6vNudA9d4GNzl6OasvqlZBNtkit57.qm0dw7wXclI25sDhZ42BVO2JdPJAXsqsRhg--`" -Lo Files_Library.7z"
