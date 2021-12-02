    ##################################### Sweeper Script ##############################################
    ## Name: vlanSweeper.ps1                               
    ## Creator: Radoslav.Stefanov                   
    ## CreationDate: 29-10-2021                               
    ## LastModified: 29-10-2021                             
    ## Version: 0.1 
    ## Description: Goes trough all the ip-s in every vlan and resolves DNS host names.
    ## After they are resolved it stores them in a data.txt file.
    ## From there on the filter.ps1 takes over 
    ###################################################################################################


$vlanX1 = 'lan network'
$vlanX2 = 'lan network'
$vlanX3 = 'lan network'
$vlanX4 = 'lan network'
$vlanX5 = 'lan network'
$vlanX6 = 'lan network'
$textFilePath = 'CONFIDENTIAL\src\Sweeper\data.txt'

if (!(Test-Path -path $textFilePath))
    {
    New-Item "CONFIDENTIAL\AutoSweeper\src\Sweeper" -Name "data.txt" -ItemType "file"
    }

#Clear file before adding new entries.
Clear-Content $textFilePath

Write-Output $vlan17
(1..254) |
    ForEach-Object {
        $value = [System.Net.Dns]::Resolve( "$vlanX1$_" ).HostName
        Add-Content -Path C:\confidential\AutoSweeper\src\Sweeper\data.txt -Value $value.ToLower()
        }
Write-Output $vlan18
(1..254) |
    ForEach-Object {
        $value = [System.Net.Dns]::Resolve( "$vlanX2$_" ).HostName
        Add-Content -Path C:\confidential\AutoSweeper\src\Sweeper\data.txt -Value $value.ToLower()
        }
Write-Output $vlan19
(1..254) |
    ForEach-Object {
        $value = [System.Net.Dns]::Resolve( "$vlanX3$_" ).HostName
        Add-Content -Path C:\confidential\AutoSweeper\src\Sweeper\data.txt -Value $value.ToLower()
        }

Write-Output $vlan20
(1..254) |
    ForEach-Object {
        $value = [System.Net.Dns]::Resolve( "$vlanX4$_" ).HostName
        Add-Content -Path C:\confidential\AutoSweeper\src\Sweeper\data.txt -Value $value.ToLower()
        }

Write-Output $vlan21
(1..254) |
    ForEach-Object {
        $value = [System.Net.Dns]::Resolve( "$vlanX5$_" ).HostName
        Add-Content -Path C:\confidential\AutoSweeper\src\Sweeper\data.txt -Value $value.ToLower()
        }

Write-Output $vlan22
(1..254) |
    ForEach-Object {
        $value = [System.Net.Dns]::Resolve( "$vlanX6$_" ).HostName
        Add-Content -Path C:\confidential\AutoSweeper\src\Sweeper\data.txt -Value $value.ToLower()
        }