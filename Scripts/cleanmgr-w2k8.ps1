#Activation for cleanmgr on W2k8 server R2
#
## Path definition for script. || Automatically selects %systemroot%/winsxs despite which local drive is using
$Winsxs = $env:SystemRoot+'\'+'winsxs'
##Destinations
$System32 = $env:SystemRoot+'\'+'system32'
$System32EN_US = $env:SystemRoot+'\'+'system32\en-US'

#CLEANMGR assets
$CleanmgrEXE = $Winsxs + "\amd64_microsoft-windows-cleanmgr_31bf3856ad364e35_6.1.7600.16385_none_c9392808773cd7da\cleanmgr.exe"
$CleanmgrEXEMUI = $Winsxs + "\amd64_microsoft-windows-cleanmgr.resources_31bf3856ad364e35_6.1.7600.16385_en-us_b9cb6194b257cc63\cleanmgr.exe.mui"

##Copy Cleanmgr files to windows folders
##cleanmgr.exe copy
Copy-Item -Path $CleanmgrEXE -Destination "$System32"

##cleanmgr.exe.mui copy
Copy-Item -Path $CleanmgrEXEMUI -Destination "$System32EN_US"

####### UNCOMMENT NEXT LINE IF IT'S BEING USED ON LOCAL AND WANT TO LAUNCH CLEANGR AFTER COPING #########
#Set-Location -Path $System32;cleanmgr.exe