## Computer Setup on a Kiosk, download scripts.
### "https://raw.githubusercontent.com/EdenWise/Computer-Setup_Kiosk/master/7za.exe"

$URIS = @(
  "https://7-zip.org/a/7zr.exe"
  #
  "https://raw.githubusercontent.com/EdenWise/Computer-Setup_Kiosk/refs/heads/main/Archive-Extract.ps1"
  "https://raw.githubusercontent.com/EdenWise/Computer-Setup_Kiosk/refs/heads/main/Computer-Setup.ps1"
  "https://raw.githubusercontent.com/EdenWise/Computer-Setup_Kiosk/refs/heads/main/LinksVariables-Create.ps1"
  "https://raw.githubusercontent.com/EdenWise/Computer-Setup_Kiosk/refs/heads/main/pwsh-start.ps1"
  "https://raw.githubusercontent.com/EdenWise/Computer-Setup_Kiosk/refs/heads/main/pwsh-update.ps1"
  #
)

foreach ( $uri in $URIS ) {
  curl.exe --location --remote-name --remote-time $uri
  # Start-BitsTransfer -Asynchronous -Source $uri -Destination "$PWD\$(Split-Path -Leaf $uri)"
}

### curl.exe https://bit.ly/cskdo -Lo CSK-Download.ps1
Write-Output "curl.exe `"https://ice-eu-108052.icedrive.io/download?p=ciZ6QmkI6ndmBBpr1D2aX7dktv1nitA4wIgXPcR82jdc4iOiSnL_DdrdG2OyxdwiKtIi8OqKVJnmiYmAlgSLp7Re_EKClSVuzADjEjL5AWOzWv7iPGgRLRHd4kC61xTwLOSepCyZLoTqyJM4tOl.HhErMT0zv5krUe32kUZqDglNtkit57.qm0dw7wXclI25Pm6DP5HYNk.EK5ttOXgP9w--`" -Lo Files_Library.7z"

echo "PSScriptAnalyzer.ps1"
