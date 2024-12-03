$URIS = @(
  "https://7-zip.org/a/7zr.exe"  ## ???
  "https://raw.githubusercontent.com/EdenWise/Computer-Setup_Kiosk/master/7za.exe"
  #
  "https://raw.githubusercontent.com/EdenWise/Computer-Setup_Kiosk/master/Archive-Extract.ps1"
  "https://raw.githubusercontent.com/EdenWise/Computer-Setup_Kiosk/master/LinksVariables-Create.ps1"
  "https://raw.githubusercontent.com/EdenWise/Computer-Setup_Kiosk/master/pwsh-start.ps1"
  "https://raw.githubusercontent.com/EdenWise/Computer-Setup_Kiosk/master/pwsh-update.ps1"
  #
   "https://ice-us-sfo-56011.icedrive.io/download?p=Oun1Aw1B_AjOlnJgEpxiEjIFt5_QjNTWNKCRYYGppjNJU1eAH_ZjegR.ydmEuuAJKtIi8OqKVJnmiYmAlgSLp7Re_EKClSVuzADjEjL5AWOqGStjIR1TgYH4nMTX1T1IuBKtRXLz5yZHXv27FtKSLJHVxAjgMWaTTm.VTxb6HORNtkit57.qm0dw7wXclI25sDhZ42BVO2JdPJAXsqsRhg--"  ## Files_Library.wim
   #
   #"https://ice-us-sfo-56011.icedrive.io/download?p=Oun1Aw1B_AjOlnJgEpxiEorQ3j_p7N4DruHOxdIoCirqlhHqGcVHB4GdonHWLWDaKtIi8OqKVJnmiYmAlgSLp7Re_EKClSVuzADjEjL5AWMeSr9EZSiE0G5uIwBwEzuUTF0xkXiSdeoYMHrtCxCiooN4dWxoaXTj5o6iRqE03NkSt2pwV7jGDv1xGrEtZNF9"  ## 7zr.exe
   #"https://raw.githubusercontent.com/EdenWise/Computer-Setup_Kiosk/refs/heads/main/Archive-Extract.ps1"  ## alternate?!
   #"https://icedrive.net/s/98u236P7VuSCx94xh2a7uz5aAz7Q"  # fails to resolve
)

foreach ( $uri in $URIS ) {
    curl.exe --location $uri --remote-name
  # Start-BitsTransfer -Asyncronous $uri
}

mv download?p=Oun1Aw1B_AjOlnJgEpxiEjIFt5_QjNTWNKCRYYGppjNJU1eAH_ZjegR.ydmEuuAJKtIi8OqKVJnmiYmAlgSLp7Re_EKClSVuzADjEjL5AWOqGStjIR1TgYH4nMTX1T1IuBKtRXLz5yZHXv27FtKSLJHVxAjgMWaTTm.VTxb6HORNtkit57.qm0dw7wXclI25sDhZ42BVO2JdPJAXsqsRhg-- Files_Library.wim
#mv download?p=Oun1Aw1B_AjOlnJgEpxiEorQ3j_p7N4DruHOxdIoCirqlhHqGcVHB4GdonHWLWDaKtIi8OqKVJnmiYmAlgSLp7Re_EKClSVuzADjEjL5AWMeSr9EZSiE0G5uIwBwEzuUTF0xkXiSdeoYMHrtCxCiooN4dWxoaXTj5o6iRqE03NkSt2pwV7jGDv1xGrEtZNF9" 7zr.exe