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
Write-Output "curl.exe `"https://icecube-eu-304.icedrive.io/download?p=P0Hx91KS6gNvJjR_90kkL4AhXnFIrNPyY8vHGYeK99hc4iOiSnL_DdrdG2OyxdwiKtIi8OqKVJnmiYmAlgSLp7Re_EKClSVuzADjEjL5AWMxHqjQ5Bo6rPaW_msL6TK.kO.ZgeqZxTlpzIpgJB.a9RPKUmXOuho.oTCxtSs4tflNtkit57.qm0dw7wXclI25Pm6DP5HYNk.EK5ttOXgP9w--`" -Lo Files_Library.7z"
echo "scoop uninstall lora,cascadia-code"
echo "PSScriptAnalyzer.ps1"
# Domine A, Merriweather A, Noto Serif B, Source_Serif_4 B
# $env:PSModulePath.Split(";")
