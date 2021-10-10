#EXPORTING USERNAME AND SAMACCOUNTNAME AKA LOGIN USERNAME TO CSV
$Message = " The CSV file will be generated on the same folder where this script is exectuted `n"
Write-Host $Message -ForegroundColor Red

#ADGroup input
$ADgroup = Read-Host -Prompt ' AD Group you would like to export'

$Message = " Exporting $ADgroup to csv. If the group has many users it might take a while. Please wait... `n"
Write-Host $Message -ForegroundColor Yellow

#importing AD module and running the csv export
Import-Module ActiveDirectory;
Get-ADGroupMember -identity $ADgroup | select name,SamAccountName | Export-csv -path \$ADgroup.csv


$Message = " CSV $ADgroup.csv generated! `n"
Write-Host $Message -ForegroundColor Green
pause