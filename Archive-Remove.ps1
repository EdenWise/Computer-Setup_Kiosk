## Files remove that were part of archive.
### Some kiosk managers may leave files on the computer. This script will remove them with the files specified to the script "Archive-Create.ps1".

Push-Location $env:USERPROFILE

$FILE_INCS = $env:TEMP\archive-includes.txt
if ( -not (Test-Path $FILE_INCS) ) {
  Write-Output "File missing: $FILE_INCS"
  exit
}

$FILE_INCS = Get-Content $FILE_INCS

# A TIP I GOT: Note when using the -Recurse parameter with -Include in Remove-Item, it can be unreliable. So it's best to recurse the files first with Get-ChildItem and then pipe into Remove-Item. This may also help if you deleting large folder structures.
# Remove-Item -Recurse -Force -Path $FILE_INCS

$FILE_INCS | Get-ChildItem -Force -Recurse | Remove-Item -Force -Recurse

Pop-Location

