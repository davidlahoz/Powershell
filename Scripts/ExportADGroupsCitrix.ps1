# Exports all Citrix Apps and the AD Groups that can use each app (aka 'Limited Visibility' on Citrix Studio) 
#
New-Item -ItemType Directory -Force -Path C:\TEMP
Set-Location -Path C:\temp
#Listing Citrix Apps installed. Returns name and AD Groups/users that have Visibility for the app
Get-BrokerApplication -MaxRecordCount 90000 | Select-Object PublishedName,@{Name=’AssociatedUserFullNames’;Expression={[string]::join(“;”, ($_.AssociatedUserFullNames))}} | ConvertTo-Html -Title "Citrix Applications - AD Groups" | Out-File .\index.html

#replaces strings and adds CSS link
(Get-Content c:\temp\index.html).replace('PublishedName', 'Citrix App Name') | Set-Content c:\temp\index.html
(Get-Content c:\temp\index.html).replace('AssociatedUserFullNames', 'ActiveDirectory Group') | Set-Content c:\temp\index.html
(Get-Content c:\temp\index.html).replace('</title>', '</title> <link rel="stylesheet" href="style.css">') | Set-Content c:\temp\index.html
(Get-Content c:\temp\index.html).replace('<body>', '<body> <h1>CITRIX APPS AND ITS AD GROUPS</h1><p><strong>If "ActiveDirectory Group" is blank/empty or only has users instead of AD Groups, please submit a ticket to BASE PLATFORMS/DISTRIBUTED SERVERS</strong></p>') | Set-Content c:\temp\index.html
#Citrix related ADGroups deletion from table (REPLACE DUMMY-ADGROUP AND UNCOMMENT IF NEEDED )
#(Get-Content c:\temp\index.html).replace('DUMMY-ADGROUP', '') | Set-Content c:\temp\index.html

#CSS file creation
New-Item -Path C:\temp -Name "style.css" -Force -ItemType "file" -Value "table {
    border: none;
    width: 100%;
    border-collapse: collapse;
}

td { 
    padding: 5px 10px;
    text-align: center;
    border: 1px solid #999;
}

tr:nth-child(1) {
    background: #0089fa;
    color: white;
}
h1 {
    text-align: center;
}
strong{
    color: red;
}"