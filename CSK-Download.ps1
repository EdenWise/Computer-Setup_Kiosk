$URIS = @(
  "https://raw.githubusercontent.com/EdenWise/Computer-Setup_Kiosk/master/Archive-Extract.ps1"
  "https://raw.githubusercontent.com/EdenWise/Computer-Setup_Kiosk/master/LinksVariables-Create.ps1"
  "https://raw.githubusercontent.com/EdenWise/Computer-Setup_Kiosk/master/pwsh-start.ps1"
  "https://raw.githubusercontent.com/EdenWise/Computer-Setup_Kiosk/master/pwsh-update.ps1"
  #
   "https://ice-us-sfo-56011.icedrive.io/download?p=Oun1Aw1B_AjOlnJgEpxiEjIFt5_QjNTWNKCRYYGppjNJU1eAH_ZjegR.ydmEuuAJKtIi8OqKVJnmiYmAlgSLp7Re_EKClSVuzADjEjL5AWOqGStjIR1TgYH4nMTX1T1IuBKtRXLz5yZHXv27FtKSLJHVxAjgMWaTTm.VTxb6HORNtkit57.qm0dw7wXclI25sDhZ42BVO2JdPJAXsqsRhg--"
   #"https://raw.githubusercontent.com/EdenWise/Computer-Setup_Kiosk/refs/heads/main/Archive-Extract.ps1"  ## alternate?!
   #"https://icedrive.net/s/98u236P7VuSCx94xh2a7uz5aAz7Q"  # fails to resolve
)

foreach ( $uri in $URIS ) {
    curl.exe --remote-name $uri
  # Start-BitsTransfer -Asyncronous $uri
}