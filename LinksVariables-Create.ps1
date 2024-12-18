## LINK AND VARIABLE CREATION
### Links recreate for Program Manager (Scoop).
### Variables for the environment create (I have put script variables here too).

## VARIABLES FOR SCRIPT
#
$env:DSP_BRT              = "85"                                    # Display Brightness
$env:MSE_SNS              = "5"                                     # Mouse Sensitivity
$env:HOME                 = "$env:APPDATA\.config"                  # Home dir for Linux-apps
$env:INKSCAPE_PROFILE_DIR = "$env:USERPROFILE\persist\inkscape\settings"  # Vector editor settings loc.
$env:SCOOP                = "$env:USERPROFILE\Program-Manager"      # Program-Manager install dir.
$env:XDG_CONFIG_HOME      = "$env:HOME"                             # Scoop uses this for a log file.
#
## ENVIRONMENTAL VARIABLES FOR "USER"
#
$KEY_VALU = @{
  "DSP_BRT"               = $env:DSP_BRT
  "MSE_SNS"               = $env:MSE_SNS
  "HOME"                  = $env:HOME
  "INKSCAPE_PROFILE_DIR"  = $env:INKSCAPE_PROFILE_DIR
  "SCOOP"                 = $env:SCOOP
  "XDG_CONFIG_HOME"       = $env:XDG_CONFIG_HOME }
#
## PATHS TO ADD
#
$PATHS = @(                                                        # Paths with executables to add.
  "$env:USERPROFILE\Documents\PowerShell;"
  "$env:USERPROFILE\Program-Manager\shims;"
)
#
## PATH FOR MODULES TO ADD
#
$MOD_PTH = ";$env:SCOOP\persist\pwsh\Modules"
#
# --- SECTION FOR CONFIGURING ENDS HERE ---

#
#
## ENVIRONMENTAL VARIABLES SET
#
$KEY_VALU.GetEnumerator() | ForEach-Object {
  [System.Environment]::SetEnvironmentVariable("$($_.Key)", "$($_.Value)", "User")
  New-Item -Force -Path env:\$($_.Key) -Value "$($_.Value)"
}
#
## PATHS SET
#
foreach ( $path in $PATHS ) {
  [System.Environment]::SetEnvironmentVariable("Path", $env:Path + "$path", "User")
  $env:Path = [System.Environment]::GetEnvironmentVariable("Path","User")
  #New-Item -Force -Path env:\$Path -Value "$env:Path"
}
#
## MODULES-PATH SET (FORCED TO USE ~\DOCUMENTS\POWERSHELL\MODULES)
#
$PSMOD_PTHS = $env:PSModulePath.Split(";")
$env:PSModulePath = ""
foreach ( $psmod_pth in $PSMOD_PTHS ) {
  if ( Test-Path $psmod_pth/* ) {
    $env:PSModulePath = $env:PSModulePath + "${psmod_pth};"
  }
}

[System.Environment]::SetEnvironmentVariable("PSModulePath", $env:PSModulePath + "$MOD_PTH", "User")
$env:PSModulePath = [System.Environment]::GetEnvironmentVariable("PSModulePath","User")

## LINKS RECREATE FOR SCOOP
#
# The only archiving programs ,that I know of, that will preserve junctions
# and hard links are DISM or wimlib. This portion will recreate them by using
# the information from the installed applications's manifest.json files.
#
## Junctions for `current` application version recreate.
###  Use directories of newest date (assume they are the newest version).
###  Simple clobber creation.
#
$APP_DIRS = (Get-ChildItem -Directory -Exclude scoop  -Path $env:SCOOP\apps).FullName
foreach ( $app_dir in $APP_DIRS ) {
  $app_new = Get-ChildItem -Directory -Exclude current -Path $app_dir | Sort-Object LastWriteTime -Descending | Select-Object -First 1
  $app_cur = "$app_dir\current"
  if ( Test-Path $app_cur ) {
    Remove-Item -Force -Path $app_cur -Recurse }  ## This is dangerous, use only if sure.
    # echo "rm'd: $app_cur"
  New-Item -Force -ItemType Junction -Path $app_cur -Value $app_new | Select-Object -ExpandProperty FullName }
#
## Junctions and Hard-Links recreate to persist directory.
### Array remove item: https://bit.ly/30i5gxC
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
        New-Item -ItemType Junction -Path $env:SCOOP\apps\$app\current\$prst -Value $env:SCOOP\persist\$app\$prst -Force | Select-Object -ExpandProperty FullName }
      else {
        New-Item -ItemType HardLink -Path $env:SCOOP\apps\$app\current\$prst -Value $env:SCOOP\persist\$app\$prst -Force | Select-Object -ExpandProperty FullName
      }
    }
  }
}

## SCOOP: SHIMS (COMPARE ORIGINAL WITH NEW, PATH REPLACE WITH PROMPT)
#
$FILES_SHIM = Get-ChildItem -File -Path $env:SCOOP\shims\* -Include "*.shim", "scoop", "scoop.cmd"
$FILES_SHIM | foreach { (Get-Content $_) -replace "C:\\Users\\.*?(\\)","$env:USERPROFILE\" | Set-Content $_ }