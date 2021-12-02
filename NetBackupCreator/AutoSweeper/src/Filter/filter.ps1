    ##################################### Filter Script ###############################################
    ## Name: filter.ps1                               
    ## Creator: Radoslav.Stefanov                   
    ## CreationDate: 29-10-2021                               
    ## LastModified: 29-10-2021                             
    ## Version: 0.1 
    ## Description: Goes trough all entries generater from the lanSweeper.
    ## Check for ones that match the naming convention of Emdep.
    ## Every match is tested if it has a MyProject folder, to confirm it is an Emdep equipment.
    ## If the check passes the entry is recorded in the result.txt file.
    ###################################################################################################


$fileText = Get-Content -Path C:\EmdepBackupTask\AutoSweeper\src\Sweeper\data.txt
$textFilePath = 'confidential\result.txt'
$folderPath = "confidential\src\Filter"


#Test if file exists. If no -> create it.
if (!(Test-Path -path $textFilePath))
    {
    New-Item $folderPath -Name "result.txt" -ItemType "file"
    }

#Clear file before adding new entries.
Clear-Content $textFilePath


#Search for names with emdep convention.
for($i=0;$i -lt $fileText.Length;$i++)
{    
    if($fileText[$i] -match 'ybed-l[0-9][0-9]?-[foo][bar][b]?[0-9]')
    {        
        $stationHostName = $Matches.0
        $emdepFileLocation="\\$stationHostName\c`$\confidential"

        #if the stations has a folder MyProject its considered a legit emdep equipment and will be added to the backups.
        if (!(Test-Path $("$emdepFileLocation")))
        {
            Add-Content -Path $textFilePath -Value ('\\'+$stationHostName)
        }

    }
}

