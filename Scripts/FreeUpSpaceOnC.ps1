#
# WelcomeText
#
$WelcomeText = "`n`n Freeing up space on C:\ drive. Please wait... `n`n"
Write-Host $WelcomeText -ForegroundColor Black -BackgroundColor Yellow
Write-Host ''

#
# Variables Definition
#
# 
$ScriptHome = Get-Location # Go back home when finished
$ErrorActionPreference = 'SilentlyContinue' # hide error messages. Used for files that can't be deleted such as VMWare related

#Empty recycle bin

Clear-RecycleBin -Force
$Message = " All Recycle Bins have been emptied!`n"
Write-Host $Message -ForegroundColor Green

#
# Delete WinSXS/Temp
#
    Get-ChildItem -Path C:\Windows\WinSxS\temp -Include *.* -File -Recurse | foreach { $_.Delete()} 
    $Message = " C:\Windows\WinSXS\Temp - Folder content deleted! `n"
    Write-Host $Message -ForegroundColor Green

#
# Delete C:\Temp
#
    Get-ChildItem -Path C:\Windows\Temp -Include *.* -File -Recurse | foreach { $_.Delete()} 
    $Message = " C:\Windows\Temp - Folder content deleted! `n"
    Write-Host $Message -ForegroundColor Green


#
# Delete CCMCache
#
    Get-ChildItem -Path C:\Windows\WinSxS\ccmcache -Include *.* -File -Recurse | foreach { $_.Delete()}
    $Message = " C:\Windows\WinSxS\CCMCache - Folder content deleted! `n"
    Write-Host $Message -ForegroundColor Green

#
# Delete SoftwareDistribution files
$Message = " This step is not always recommended"
Write-Host $Message -ForegroundColor Yellow
$confirmation = Read-Host "Are you sure you want to clean SoftwareDistribution files [Y/N]?"
if ($confirmation -eq 'y') {
    Write-Host "`n Please wait for service start-stop Windows Update and file deletion...`n"
   Stop-Service -Name wuauserv
   Get-ChildItem -Path C:\Windows\SoftwareDistribution\Download -Include *.* -File -Recurse | foreach { $_.Delete()}
   Start-Service -Name wuauserv
   $Message = " C:\Windows\SoftwareDistribution\Download - Folder content deleted!`n`n"
   Write-Host $Message -ForegroundColor Green
   $Message = " PLEASE ENSURE THAT WUAUSERV STATUS IS RUNNING`n`n"
   Write-Host $Message -ForegroundColor White -BackgroundColor Red
   Write-Host " If isn't running, please consider restarting the service via services.msc"
   Get-service wuauserv
}
else
{
   $Message = " Windows Update service and related folders were skipped."
   Write-Host $Message -ForegroundColor White -BackgroundColor Red
exit(0)
}

Set-Location $ScriptHome
#
# END
#