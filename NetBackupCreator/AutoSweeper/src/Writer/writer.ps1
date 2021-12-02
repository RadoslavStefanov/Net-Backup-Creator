    ##################################### Writer Script ###############################################
    ## Name: writer.ps1                               
    ## Creator: Radoslav.Stefanov                   
    ## CreationDate: 29-10-2021                               
    ## LastModified: 29-10-2021                             
    ## Version: 0.1 
    ## Description: Goes trough all entries generater from the filter.
    ## Check for ones that dont match the array of names inside the StationPaths.txt.
    ## Any entry that is NOT recorded inside the main StationPaths.txt file gets added to it. 
    ###################################################################################################


$stationPaths = Get-Content -Path confidential\StationPaths.txt
$candidateEntries = Get-Content -Path confidential\src\Filter\result.txt
$textFilePath = 'confidential\src\Writer\lastChanges.txt'

if (!(Test-Path -path $textFilePath))
    {
    New-Item "confidential\AutoSweeper\src\Writer" -Name "lastChanges.txt" -ItemType "file"
    }

#Clear file before adding new entries.
Clear-Content $textFilePath

#removes "\\xxxx-xxx-xx" a.k.a "cap" from the file 
$stationPaths[0..($stationPaths.Count-2)]|Out-File "confidential\StationPaths.txt" -Force


#checks if there are new unsaved entries,and if so, it adds them
for($i=0;$i -lt $candidateEntries.Length;$i++)
{    
    $hasItem = "False"

    for($j=0;$j -lt $stationPaths.Length;$j++)
    {    
        if($candidateEntries[$i] -eq $stationPaths[$j])
        {
            $hasItem = "True";
        }
    }

    if($hasItem -eq "False")
    {
        Add-Content -Path C:confidential\StationPaths.txt -Value $candidateEntries[$i].ToLower()
        Add-Content -Path $textFilePath -Value $candidateEntries[$i].ToLower()
    }
}


#adds the cap back !Important!
Add-Content -Path C:\EmdepBackupTask\StationPaths.txt -Value "\\xxxx-xx-xxx".ToLower()