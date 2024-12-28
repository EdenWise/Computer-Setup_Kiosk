## ARCHIVE CREATE FROM LISTS (INCLUSIONS AND EXCLUSIONS) AND WITH UPDATE CAPABILITIES (USING 7ZIP).
#
# List of Excludes requires using relative paths if archiving non-root. Also avoid using generic
# names as 7zip excludes has the ability for general matching (like "Downloads" will match 
# "Music\Downloads").
#
# 7zip (and almost all other archiving programs that I know of [MS-Zip, tar...]) lacks being able to
# archive links (soft links, hard links, and junctions): MS-Zip fails to do them; .7z fails to do
# them AND junctions get copied as directories (which can make for LARGE archives); 7-zip's WIM works
# some with symbolic links but can have extraction problems (junctions are created as a blank file, and hard-links are copied); and tar only works on a Linux-like filesystem. Using `dism.exe` works and
# is a nice container solution, however it does require administrative rights and I lack knowing
# if it works good with lists (made more for disk copies). 'wimlib' works and can be used be a regular
# user but I have yet to find out how to do it with lists. In short, links are best removed from
# archive and then recreated after extraction.

## VARIABLES
#
$TYPE = "Files"
$LCTN = "Library"
# $LOCL = "-Locale"
$CONT = "wim"
$CMPR = "7z"
#
$PATH_CONT = "$env:USERPROFILE\Downloads\${TYPE}_${LCTN}${LOCL}.$CONT"
$PATH_CMPR = "$env:USERPROFILE\Downloads\${TYPE}_${LCTN}${LOCL}.$CMPR"
#
$FILE_INCS = "$env:TEMP\archive-includes.txt"
$FILE_EXCS = "$env:TEMP\archive-excludes.txt"

## LISTS OF INCLUDE AND EXCLUDE FILES
#
$LIST_INCS = @(
  # ".config"
  # "AppData\LocalLow\Daggerfall Workshop"
  # "AppData\Roaming\Microsoft\Windows\PowerShell"
  # ".vscode"
  # "WindowsTerminal.lnk"
  ".scrap"
  "AppData\Roaming\.config"
  "AppData\Roaming\Microsoft\Windows\My Games\Neverball-dev"
  "AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Scoop Apps"
  "Documents"
  "Program-Manager"
  #
  "tasks.code-workspace"
) | Out-File -Encoding utf8 -Force $FILE_INCS
#
$LIST_EXCS = @(
  "desktop.ini"
  "Documents\My Music"
  "Documents\My Pictures"
  "Documents\My Shapes"
  "Documents\My Videos"
  "~\Downloads\"
) | Out-File -Encoding utf8 -Force $FILE_EXCS
#
# LIST OF JUNCTIONS/SOFT-LINKS CREATE AND ADD TO LIST FOR EXCLUDES.
#
cmd.exe /C dir /AL /S /B $env:SCOOP | foreach {$_.Replace("$env:USERPROFILE\","")} >> $FILE_EXCS

## ARCHIVE
#
Push-Location $env:USERPROFILE
#
# CONTAINER: WIM (RECOMMENDED)---FASTER, OFFERS REASONABLE COMPRESSION.
7zr.exe u $PATH_CONT -up0q0r2x1y2z1w2 -ir@"$FILE_INCS" -xr@"$FILE_EXCS" -ms=off -snh -snl
#
# COMPRESSION ONLY (compression [low-high]: -mx=[0-9])
# 7zr.exe u $PATH_CMPR -up0q0r2x1y2z1w2 -ir@"$FILE_INCS" -xr@"$FILE_EXCS" -ms=off -snh -snl -mx=5
#
Pop-Location