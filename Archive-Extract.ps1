## Archive extract.
### Option removed: -y (try to remove any duplicate files in archive).
#
$ARC_PTH = "$env:USERPROFILE\Downloads\Files_Library.wim"
#
if ( Test-Path $ARC_PTH ) {
  ~\Downloads\7zr.exe x $ARC_PTH -bsp1 -o"$env:USERPROFILE" }
else {
  Write-Output "Archive `"$ARC_PTH`" missing."
}

