## Archive extract.
### Option removed: -y (try to remove any duplicate files in archive).
#
## CONTAINER: WIM
#
.\7zr.exe x Files_Library.wim -bsp1 -o"$env:USERPROFILE"
#
## COMPRESSION: .7z
#
# .\7zr.exe x Files_Library.7z -bsp1 -o"$env:USERPROFILE"
