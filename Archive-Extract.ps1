## .7z (LZMA2)
#
.\7zr.exe x Files_Library.7z -bsp1 -o"$env:USERPROFILE"
#
## WIM AND .7z
#
#.\7zr.exe x Files_Library.wim.7z
#.\7zr.exe x Files_Library.wim    -bsp1 -o"$env:USERPROFILE"

# Option removed (tring to remove any duplicate files in archive): -y
# Move C:\Users\library.user\AppData\Roaming\Microsoft\Windows\PowerShell\PSReadLine\ConsoleHost_history.txt
