## FILES REMOVE THAT WERE PART OF ARCHIVE.
###
### Some kiosk managers may leave files on the computer. This script will remove
### files left behind on the kiosk that are recorded in the 
### `Archive-Compress.ps1 script.
#
# A TIP I GOT: Note when using the -Recurse parameter with -Include in Remove-Item,
# it can be unreliable. So it's best to recurse the files first with Get-ChildItem
# and then pipe into Remove-Item. This may also help if you deleting large folder
# structures `Remove-Item -Recurse -Force -Path ...`
#

$FILE_INCS = "$env:TEMP\archive-includes.txt"
if ( -not (Test-Path $FILE_INCS) ) {
  Write-Output "File missing: $FILE_INCS"
  exit
}

Push-Location $env:USERPROFILE

$ANSWER = Read-Host "Files remove that were extracted from the Archive."
if ( $ANSWER -eq "y" -or $ANSWER -eq "Y") {
  $LIST_FILES = Get-Content $FILE_INCS
  foreach ( $file in $LIST_FILES )
    $files += $LIST_FILES | Get-ChildItem -Force -Recurse
    #| Remove-Item -Force -Recurse
}

Pop-Location

