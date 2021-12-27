#Setting working directory
New-Item -ItemType Directory -Force -Path C:\TEMP
Set-Location -Path C:\temp
#Listing Citrix Apps installed. Returns name and AD Groups/users that have Visibility for the app
Get-BrokerApplication -MaxRecordCount 90000 | Select-Object PublishedName,@{Name=’AssociatedUserFullNames’;Expression={[string]::join(“;”, ($_.AssociatedUserFullNames))}}
#Export to CSV
Export-CSV -Path .\CitrixApps.csv
#end message
$Message = " CSV CitrixApps.csv generated on C:\temp!`n"
Write-Host $Message -ForegroundColor Green
Read-Host -Prompt "Press any key to continue"