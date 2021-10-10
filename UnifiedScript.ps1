$ScriptHome = Get-Location 
#Main menu
function Show-Menu {
    param (
        [string]$Title = 'My Menu'
    )
    cls
    Write-Host "================ $Title ================"
    
    Write-Host "1: Press '1' for 'Freeing up space on C'."
    Write-Host "2: Press '2' for 'WUAUServ cleanup'."
    Write-Host "3: Press '3' for 'Exporting to csv members from an AD Group."
    Write-Host "Q: Press 'Q' to quit."
}

#menu choices
do {
    Show-Menu
    $input = Read-Host "Please make a selection"
    switch ($input) {
        #Launch FreeUpSpaceOnC
        '1' {
            cls
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
            $ErrorActionPreference = 'SilentlyContinue' # hide error messages. Used for files that can't be deleted such as VMWare related

            #Empty recycle bin

            Clear-RecycleBin -Force
            $Message = " All Recycle Bins have been emptied!`n"
            Write-Host $Message -ForegroundColor Green

            #
            # Delete WinSXS/Temp
            #
            Get-ChildItem -Path C:\Windows\WinSxS\temp -Include *.* -File -Recurse | foreach { $_.Delete() } 
            $Message = " C:\Windows\WinSXS\Temp - Folder content deleted! `n"
            Write-Host $Message -ForegroundColor Green

            #
            # Delete C:\Temp
            #
            Get-ChildItem -Path C:\Windows\Temp -Include *.* -File -Recurse | foreach { $_.Delete() } 
            $Message = " C:\Windows\Temp - Folder content deleted! `n"
            Write-Host $Message -ForegroundColor Green


            #
            # Delete CCMCache
            #
            Get-ChildItem -Path C:\Windows\WinSxS\ccmcache -Include *.* -File -Recurse | foreach { $_.Delete() }
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
                Get-ChildItem -Path C:\Windows\SoftwareDistribution\Download -Include *.* -File -Recurse | foreach { $_.Delete() }
                Start-Service -Name wuauserv
                $Message = " C:\Windows\SoftwareDistribution\Download - Folder content deleted!`n`n"
                Write-Host $Message -ForegroundColor Green
                $Message = " PLEASE ENSURE THAT WUAUSERV STATUS IS RUNNING`n`n"
                Write-Host $Message -ForegroundColor White -BackgroundColor Red
                Write-Host " If isn't running, please consider restarting the service via services.msc"
                Get-service wuauserv
            }
            else {
                $Message = " Windows Update service and related folders were skipped."
                Write-Host $Message -ForegroundColor White -BackgroundColor Red
                exit(0)
            }
        } '2' {
            # Launch WUAUServ Cleanup
            cls
            # WelcomeText

            $WelcomeText = "`n`n SoftwareDistribution\Download deletion. `n`n"
            Write-Host $WelcomeText -ForegroundColor Black -BackgroundColor Yellow

            # Delete SoftwareDistribution files
            Write-Host " Please wait for service start-stop and deletion..."
            Stop-Service -Name wuauserv
            Get-ChildItem -Path C:\Windows\SoftwareDistribution\Download -Include *.* -File -Recurse | foreach { $_.Delete() }
            Start-Service -Name wuauserv
            $Message = " C:\Windows\SoftwareDistribution\Download - Folder content deleted!"
            Write-Host $Message -ForegroundColor Green
            $Message = " PLEASE ENSURE THAT WUAUSERV STATUS IS RUNNING"
            Write-Host $Message -ForegroundColor White -BackgroundColor Red
            Write-Host " If isn't running, please consider restarting teh service via services.msc"
            Get-service wuauserv
        } '3' {
            #Launch AD Export to csv
            cls
            #EXPORTING USERNAME AND SAMACCOUNTNAME AKA LOGIN USERNAME TO CSV
            $Message = " The CSV file will be generated on the same folder where this script is exectuted `n"
            Write-Host $Message -ForegroundColor Red

            #ADGroup input
            $ADgroup = Read-Host -Prompt ' AD Group you would like to export'

            $Message = " Exporting $ADgroup to csv. If the group has many users it might take a while. Please wait... `n"
            Write-Host $Message -ForegroundColor Yellow

            #importing AD module and running the csv export
            Import-Module ActiveDirectory;
            Get-ADGroupMember -identity $ADgroup | select name, SamAccountName | Export-csv -path \$ADgroup.csv


            $Message = " CSV $ADgroup.csv generated! `n"
            Write-Host $Message -ForegroundColor Green
            pause
        } 'q' {
            return
        }
    }
    pause
}
until ($input -eq 'q')