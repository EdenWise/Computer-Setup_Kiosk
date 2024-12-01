## Link and Variable creation. 
#  * Program Manager (Scoop): recreate links that get lost in archiving.
#  * Variables: create that are needed for the environment (I have put script variables here too).

if ( -not ( Test-Path $env:USERPROFILE\Program-Manager ) ) {
  echo " * Run ``Archive-Extract.ps1`` first."
  exit
}

[Environment]::SetEnvironmentVariable("DSP_BRT", "80", "User")
[Environment]::SetEnvironmentVariable("MSE_SNS", "5", "User")
[Environment]::SetEnvironmentVariable("HOME", "$env:APPDATA\.config", "User")
[Environment]::SetEnvironmentVariable("INKSCAPE_PROFILE_DIR", "$env:USERPROFILE\Program-Manager\persist\inkscape\settings", "User")
[Environment]::SetEnvironmentVariable("Path", "$env:APPDATA\Microsoft\Windows\PowerShell\Scripts;" + $env:Path, "User")
[Environment]::SetEnvironmentVariable("Path", "$env:USERPROFILE\Program-Manager\shims\;" + $env:Path, "User")
[Environment]::SetEnvironmentVariable("SCOOP", "$env:USERPROFILE\Program-Manager", "User")
# requires new process to recognize settings.


## ENVIRONMENTAL VARIABLES FOR USER
#
# $VAR_NAMES = @(
#   "DSP_BRT"
#   "MSE_SNS"
#   "HOME"
#   "INKSCAPE_PROFILE_DIR"
#   "Path"
#   "Path"
#   "SCOOP"
# )
# $VAR_VALUS = @(
#   "80"
#   "5"
#   "$env:APPDATA\.config"
#   "$env:SCOOP\persist\inkscape\settings"
#   '"$env:APPDATA\Microsoft\Windows\PowerShell\Scripts;" + $env:Path'
#   '"$env:USERPROFILE\Program-Manager\shims\;" + $env:Path'
#   "$env:SCOOP\persist\inkscape\settings"
# )

# $var_name = $VAR_NAMES.getenumerator()
# $var_valu = $VAR_VALUS.getenumerator()

# while ($var_name.MoveNext() -and $var_valu.MoveNext()) {
#   echo "[Environment]::SetEnvironmentVariable($var_name.current, $var_valu.current, "User")"
#     # Write-Host $var_name.current $var_valu.current
# }

# $USER_VARS = @(
#   'DSPLY_BRIGHT, 80'                                    # Display Brightness
#   '"MSE_SNS"             , "5"'                                     # Mouse Sensitivity
#   '"HOME"                , "$env:APPDATA\.config"'                  # HOME dir for Linux-based apps
#   '"INKSCAPE_PROFILE_DIR", "$env:SCOOP\persist\inkscape\settings"'
#   '"Path"                , "$env:APPDATA\Microsoft\Windows\PowerShell\Scripts;" + $env:Path'
#   '"Path"                , "$env:USERPROFILE\Program-Manager\shims\;" + $env:Path'
#   '"SCOOP"               , "$env:USERPROFILE\Program-Manager"'  # Program Manager directory
#   )
# #
# foreach ( $user_var in $USER_VARS ) {
#   [Environment]::SetEnvironmentVariable($user_var, "User")
# }

$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")                 # $env:Path reset

## LINKS RECREATE FOR SCOOP
#
# The only archiving programs ,that I know of, that will preserve junctions
# and hard links are DISM or wimlib. This portion will recreate them by using
# the information from the installed applications's manifest.json files.
#
if ( -not $env:SCOOP ) {
  $env:SCOOP = "$env:USERPROFILE\Program-Manager"
}
if ( -not $env:SCOOP ) {
  Write-Output "Note: Script edit and define directory for Scoop installations."
  exit
}
#
# Junctions for `current` application version recreate.
#   * Use directories of newest date (assume they are the newest version).
#   * Simple clobber creation.
#
$APP_DIRS = (Get-ChildItem -Directory -Exclude scoop  -Path $env:SCOOP\apps).FullName
foreach ( $app_dir in $APP_DIRS ) {
  $app_new = Get-ChildItem -Directory -Exclude current -Path $app_dir | Sort-Object LastWriteTime -Descending | Select-Object -First 1
  # $app_new = ($app_new).FullName
  $app_cur = "$app_dir\current"
  if ( Test-Path $app_cur ) {
    Remove-Item -Force -Path $app_cur -Recurse
  if ( $? ) { echo "* Removed: $app_cur" } }
  New-Item -Force -ItemType Junction -Path $app_cur -Value $app_new | Out-Null
  if ( $? ) {
    Write-Output "* Junction created: $app_cur" } }
#
# Junctions and hardlinks from persist directory recreate. ARRAY_RM-ITEM: https://bit.ly/30i5gxC
#
$APPS_PSBL = (Get-ChildItem -Path $env:SCOOP\persist).Name
foreach ( $app in $APPS_PSBL ) { 
  if ( Test-Path $env:SCOOP\apps\$app ) {  # Use persist directory name and test if app is installed
    $MNFS_JSON = Get-Content -Path $env:SCOOP\apps\$app\current\manifest.json | ConvertFrom-Json
    $app_prsts = $MNFS_JSON.persist
    foreach ( $prst in $app_prsts ) {
      if ( Test-Path -PathType Container $env:SCOOP\persist\$app\$prst ) {
        if ( Test-Path $env:SCOOP\apps\$app\current\$prst ) {
            Remove-Item -Force -Path $env:SCOOP\apps\$app\current\$prst -Recurse }
        ## if ( $? ) { echo "* Removed: $app_cur" }    #### keeps repeating rm'd wt\current
        New-Item -ItemType Junction -Path $env:SCOOP\apps\$app\current\$prst -Value $env:SCOOP\persist\$app\$prst -Force }
      else {
        New-Item -ItemType HardLink -Path $env:SCOOP\apps\$app\current\$prst -Value $env:SCOOP\persist\$app\$prst -Force
        # | Out-Null
      }
    }
  }
}

## SCOOP: SHIMS (COMPARE ORIGINAL WITH NEW, PATH REPLACE WITH PROMPT)
#
$FILES_SHIM = Get-ChildItem -File -Path $env:SCOOP\shims\* -Include "*.shim", "scoop", "scoop.cmd"
$FILES_SHIM | foreach { (Get-Content $_) -replace "C:\\Users\\.*?(\\)","$env:USERPROFILE\" | Set-Content $_ }