#Setting working directory
Set-Location -Path C:\temp
#Listing Citrix Apps installed. Returns name and AD Groups/users that have Visibility for the app
Get-BrokerApplication -MaxRecordCount 90000 | Select-Object PublishedName,@{Name=’AssociatedUserFullNames’;Expression={[string]::join(“;”, ($_.AssociatedUserFullNames))}}
#Export to CSV
Export-CSV -Path .\CitrixApps.csv