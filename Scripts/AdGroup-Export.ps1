# This script exports the members of a desired AD Group to csv file
#
#Create C:\Temp
New-Item -ItemType Directory -Force -Path C:\TEMP

#EXPORTING USERNAME AND SAMACCOUNTNAME AKA LOGIN USERNAME TO CSV
$Message = " The CSV file will be generated on C:\TEMP `n"
Write-Host $Message -ForegroundColor Red

#ADGroup input structure
$ADgroup = Read-Host -Prompt ' AD Group you would like to export'
$ExportCSV = "c:\TEMP\"+$ADgroup+".csv"

$Message = " Exporting $ADgroup to csv. If the group has many users it might take a while. Please wait... `n"
Write-Host $Message -ForegroundColor Yellow

#importing AD module and running the csv export
Import-Module ActiveDirectory;
Get-ADGroupMember -identity $ADgroup | Select-Object name,SamAccountName | Export-csv -path $ExportCSV -force

$Message = " CSV $ADgroup.csv generated on C:\temp!`n"
Write-Host $Message -ForegroundColor Green
Read-Host -Prompt "Press any key to continue"