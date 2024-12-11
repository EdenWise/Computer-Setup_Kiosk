## Computer Setup on a Kiosk, download scripts.
### curl.exe https://bit.ly/csk-d -Lo CSK-Download.ps1
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

Write-Output "curl.exe `"https://ice-eu-53588.icedrive.io/download?p=hFmMquZjF679SnFTLVMImJ5KVht6jTuSMt56Gmr8g1Fc4iOiSnL_DdrdG2OyxdwiKtIi8OqKVJnmiYmAlgSLp7Re_EKClSVuzADjEjL5AWPtr0bhldDjG_OCD2Ka2foV67oRTocxCVmXxYw3gfoqqFZFcva8ZNGbmSp5zAhENnRNtkit57.qm0dw7wXclI25Pm6DP5HYNk.EK5ttOXgP9w--`" -Lo Files_Libray.7z"