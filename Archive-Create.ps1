## ARCHIVE CREATE FROM LISTS OF INCLUSIONS AND EXCLUSIONS AND WITH UPDATE CAPABILITIES.
#

# List of Excludes for 7-zip requires using relative paths. Also it is a problem if exclude entry
# has the same name as a sub-file name (Like "Downloads\").
#
# Links have to be recreated. MS-Zip, 7-zip's (.7z), 7-zip's WIM, and tar all fail for NTFS links:
# MS-Zip fails to do them; .7z fails to do them AND copies junctions as directories (which can make
# for large archives); 7-zip's WIM works some with symbolic links but can have extraction problems
# (junctions are created as a blank file, and hardlinks are copied); and tar only works on a 
# Linux-like filesytem. Using `dism.exe` works and is a nice container solution (a similar idea of
# WIM and tar) but requires administrative rights.

## VARIABLES
#
$TYPE = "Files"
$LCTN = "Library"
# $LOCL = "-Riverside"
$CONT = "wim"
$CMPR = "7z"
#
$PATH_CONT = "$env:USERPROFILE\Downloads\${TYPE}_${LCTN}${LOCL}.$CONT"
$PATH_CMPR = "$env:USERPROFILE\Downloads\${TYPE}_${LCTN}${LOCL}.$CMPR"
$PATH_COCM = "$env:USERPROFILE\Downloads\${TYPE}_${LCTN}${LOCL}.$CONT.$CMPR"  # Container and Compress
#
$FILE_INCS = "$env:USERPROFILE\Downloads\archive-includes.txt"
$FILE_EXCS = "$env:USERPROFILE\Downloads\archive-excludes.txt"

## LISTS OF INCLUDE AND EXCLUDE FILES
#
$LIST_INCS = @(
  # ".config"
  # "AppData\LocalLow\Daggerfall Workshop"
  # "AppData\Roaming\ColorCop"
  # "AppData\Roaming\inkscape"
  # "AppData\Roaming\Waterfox"
  # ".vscode"
  ".scrap"
  "AppData\Roaming\.config"
  "AppData\Roaming\Microsoft\Windows\My Games\Neverball-dev"
  "AppData\Roaming\Microsoft\Windows\PowerShell"
  "AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Scoop Apps"
  "Documents"
  "Program-Manager"
  #
  "tasks.code-workspace"
  "WindowsTerminal.lnk"
) | Out-File -Force $FILE_INCS

#
$LIST_EXCS = @(
  "Documents\My Music"
  "Documents\My Pictures"
  "Documents\My Shapes"
  "Documents\My Videos"
  # "Downloads"                               # DANGEROUS-will gestaltly effect other 'Download' dir.
  # "Program-Manager\apps\vscode\current\data"       # for .7z format
  # "Program-Manager\apps\waterfox\current\profile"  # for .7z format
  # "Program-Manager\apps\*\current"                 # DANGEROUS-will skip single dir `Scoop/apps/current`
) | Out-File -Force $FILE_EXCS
#
# List of junctions, SL, add to list for excludes.
#
cmd.exe /C dir /AL /S /B $env:SCOOP | foreach {$_.Replace("$env:USERPROFILE\","")} >> $FILE_EXCS

## ARCHIVE
#
Push-Location $env:USERPROFILE
#
# COMPRESSION ONLY
7zr.exe u $PATH_CMPR -up0q0r2x1y2z1w2 -ir@"$FILE_INCS" -xr@"$FILE_EXCS" -ms=off -snh -snl
#
# CONTAINER: WIM WITH OPTIONAL COMPRESSION (COMPRESSES VERY LITTLE, ABOUT 10%).
# 7zr.exe u $PATH_CONT -up0q0r2x1y2z1w2 -ir@"$FILE_INCS" -xr@"$FILE_EXCS" -ms=off -snh -snl
# 7zr.exe a $PATH_COCM $PATH_CONT -ms=off -mx5

Pop-Location