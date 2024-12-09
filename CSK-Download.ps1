## Computer Setup on a Kiosk scripts
## curl.exe https://bit.ly/csk-d -Lo CSK-Download.ps1

$URIS = @(
  "https://7-zip.org/a/7zr.exe"
  #
  "https://raw.githubusercontent.com/EdenWise/Computer-Setup_Kiosk/master/Archive-Extract.ps1"
  "https://raw.githubusercontent.com/EdenWise/Computer-Setup_Kiosk/master/LinksVariables-Create.ps1"
  "https://raw.githubusercontent.com/EdenWise/Computer-Setup_Kiosk/master/pwsh-start.ps1"
  "https://raw.githubusercontent.com/EdenWise/Computer-Setup_Kiosk/master/pwsh-update.ps1"
  #
  # "https://raw.githubusercontent.com/EdenWise/Computer-Setup_Kiosk/refs/heads/main/Archive-Extract.ps1"  ## alternate
  # "https://icedrive.net/s/DQ5jYDyYVCXjTVDbkY4hG49uiwTT"                                                  ## Files_Library.7z download webpage.
  # "https://raw.githubusercontent.com/EdenWise/Computer-Setup_Kiosk/master/7za.exe"
  # "https://ice-eu-107586.icedrive.io/download?p=S0G47B2UMbGG2lGV0k.bLu1dXWojgQkI_hGi5L5cRRVc4iOiSnL_DdrdG2OyxdwiKtIi8OqKVJnmiYmAlgSLp7Re_EKClSVuzADjEjL5AWNwcytxnemqFHyNLvw1XWQZ1pRDk6wNCTJoj97OPYVoG6Tl7MToZg1slOsSnRZzxMdNtkit57.qm0dw7wXclI25Pm6DP5HYNk.EK5ttOXgP9w--" ## Files_Library.7z... looks like link alternates some.
  #
)

foreach ( $uri in $URIS ) {
    curl.exe --location $uri --remote-name
  # Start-BitsTransfer -Asyncronous $uri
}

Write-Output "curl.exe `"https://ice-eu-107586.icedrive.io/download?p=S0G47B2UMbGG2lGV0k.bLs2ifvrN6egv6nCfqG0HsG9c4iOiSnL_DdrdG2OyxdwiKtIi8OqKVJnmiYmAlgSLp7Re_EKClSVuzADjEjL5AWNwcytxnemqFHyNLvw1XWQZ1pRDk6wNCTJoj97OPYVoG6Tl7MToZg1slOsSnRZzxMdNtkit57.qm0dw7wXclI25Pm6DP5HYNk.EK5ttOXgP9w--`" -Lo Files_Library.7z"
Write-Output "curl.exe `"https://ice-eu-11554563.icedrive.io/download?p=h9mf.hTfydP9Yug7jMcGn6BN437nT3b3k3lVZkWyRZFc4iOiSnL_DdrdG2OyxdwiKtIi8OqKVJnmiYmAlgSLp7Re_EKClSVuzADjEjL5AWOeevq260HwRxWlPgD1s4l6aSR6gLk57AAgYfZqE85PfB3T78c4__SRyN410Q2yPaRNtkit57.qm0dw7wXclI25Pm6DP5HYNk.EK5ttOXgP9w--`" -Lo Files_Library.7z"
Write-Output "curl.exe `"https://icecube-eu-306.icedrive.io/download?p=HCso4ZNpfcFC5CcQNeZDLNCuB6htYpWYV5ZuadwG0v9c4iOiSnL_DdrdG2OyxdwiKtIi8OqKVJnmiYmAlgSLp7Re_EKClSVuzADjEjL5AWPLl.bW0qhWAPLp8vQea_wSz_WvjHr8FjZDQ5ZbCMOXIxI6ChxT71ub.LDUGjXqVptNtkit57.qm0dw7wXclI25Pm6DP5HYNk.EK5ttOXgP9w--`" -Lo Files_Libray.7z"
# 