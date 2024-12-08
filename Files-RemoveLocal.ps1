Set-Location $env:USERPROFILE

$LIST_OF_INCLUDES = @(
  ".vscode"
  ".scrap"
  "AppData\Local\.config"
  "AppData\LocalLow\Daggerfall Workshop"
  "AppData\Roaming\inkscape"
  "AppData\Roaming\Microsoft\Windows\My Games"
  "AppData\Roaming\Microsoft\Windows\PowerShell"
  "Documents\*"
  # "Documents\My Games"
  # "Documents\PowerShell\*"
  # "Documents\Source"
  # "Documents\Vault"
  "Program-Manager"
  "WindowsTerminal.lnk"
  "Downloads\*" )

Remove-Item -Recurse -Force -Path $LIST_OF_INCLUDES

# Note when using the -Recurse parameter with -Include in Remove-Item, it can be unreliable. So it's best to recurse the files first with Get-ChildItem and then pipe into Remove-Item. This may also help if you deleting large folder structures.

# Get-ChildItem $directoryPath -Recurse | Remove-Item -Force  