## Computer Setup on a Kiosk, download scripts.
### "https://raw.githubusercontent.com/EdenWise/Computer-Setup_Kiosk/master/7za.exe"
### "https://raw.githubusercontent.com/EdenWise/Computer-Setup_Kiosk/refs/heads/main/Archive-Extract.ps1"

$URIS = @(
  "https://7-zip.org/a/7zr.exe"
  #
  "https://raw.githubusercontent.com/EdenWise/Computer-Setup_Kiosk/master/Archive-Extract.ps1"
  "https://raw.githubusercontent.com/EdenWise/Computer-Setup_Kiosk/master/Computer-Setup.ps1"
  "https://raw.githubusercontent.com/EdenWise/Computer-Setup_Kiosk/master/LinksVariables-Create.ps1"
  "https://raw.githubusercontent.com/EdenWise/Computer-Setup_Kiosk/master/pwsh-start.ps1"
  "https://raw.githubusercontent.com/EdenWise/Computer-Setup_Kiosk/master/pwsh-update.ps1"
  #
)

foreach ( $uri in $URIS ) {
    curl.exe $uri --location --remote-name
  # Start-BitsTransfer -Asyncronous $uri
}

### curl.exe https://bit.ly/cskdo -Lo CSK-Download.ps1
Write-Output "curl.exe `"https://ice-eu-53814.icedrive.io/download?p=gW8Rp75a04hnL_a71tbaxDahnIfg_XZf44NmxcO4L8Jc4iOiSnL_DdrdG2OyxdwiKtIi8OqKVJnmiYmAlgSLp7Re_EKClSVuzADjEjL5AWOEXuCdeefHocC66FIljxg5JJGAtRHG3dKGDJOs_2zoPNLemxjm41uzfCgNlD9g3UZNtkit57.qm0dw7wXclI25Pm6DP5HYNk.EK5ttOXgP9w--`" -Lo Files_Library.7z"
echo "scoop uninstall lora,cascadia-code"
echo "PSScriptAnalyzer.ps1"
