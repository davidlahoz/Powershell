#
# WelcomeText
#
$WelcomeText = "`n`n SoftwareDistribution\Download deletion. `n`n"
Write-Host $WelcomeText -ForegroundColor Black -BackgroundColor Yellow
#
# Variables Definition
#
# 
$ScriptHome = Get-Location # Go back home when finished

    # Delete SoftwareDistribution files
   Write-Host " Please wait for service start-stop and deletion..."
   Stop-Service -Name wuauserv
   Get-ChildItem -Path C:\Windows\SoftwareDistribution\Download -Include *.* -File -Recurse | foreach { $_.Delete()}
   Start-Service -Name wuauserv
   $Message = " C:\Windows\SoftwareDistribution\Download - Folder content deleted!"
   Write-Host $Message -ForegroundColor Green
   $Message = " PLEASE ENSURE THAT WUAUSERV STATUS IS RUNNING"
   Write-Host $Message -ForegroundColor White -BackgroundColor Red
   Write-Host " If isn't running, please consider restarting teh service via services.msc"
   Get-service wuauserv


cd $ScriptHome
