Write-Host "SCRIPT UNTESTED! PRESS ANY KEY TO CONTINUE" -ForegroundColor Red -BackgroundColor DarkRed
Pause




## Variables for %SYSTEMROOT%
## Origins
$Winsxs = $env:SystemRoot+'\'+'winsxs'
##Destinations
$System32 = $env:SystemRoot+'\'+'system32'
$System32ENus = $env:SystemRoot+'\'+'system32\en-US'

##Copy Cleanmgr files to windows folders
##cleanmgr.exe copy
Copy-Item -Path "$Winsxs\amd64_microsoft-windows-cleanmgr_31bf3856ad364e35_6.1.7600.16385_none_c9392808773cd7da\cleanmgr.exe" -Destination "$System32" '1'; if (-not $?) { Write-Host "UNABLE TO COPY CLEANMGR.EXE TO SYSTEM32" -ForegroundColor Red '2'}

##cleanmgr.exe.mui copy
Copy-Item -Path "$Winsxs\amd64_microsoft-windows-cleanmgr.resources_31bf3856ad364e35_6.1.7600.16385_en-us_b9cb6194b257cc63\cleanmgr.exe.mui" -Destination "$System32Enus" '1'; if (-not $?) { Write-Host "UNABLE TO COPY CLEANMGR.EXE.MUI TO SYSTEM32" -ForegroundColor Red '2'}

##Invoke cleanmgr
Set-Location -Path $System32;cleanmgr.exe
Exit-PSSession
