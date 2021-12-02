    ##################################### Cleaner Script ##############################################
    ## Name: logcleaner.ps1                               
    ## Creator: Radoslav.Stefanov                   
    ## CreationDate: 29-10-2021                               
    ## LastModified: 29-10-2021                             
    ## Version: 0.1 
    ## Description: Goes trough all backup logs and cleans the so it will not take space
    ###################################################################################################


#Reads main file so it would know what do delete
$fileText = Get-Content -Path C:\Confidential\StationPaths.txt

for($i=0;$i -lt $fileText.Length;$i++)
{

    ##Splits the paths to get the line and station
    Write-Output $fileText[$i]
    $splitArr = $fileText[$i].Split("-")
    if($splitArr[1].Length -eq 1)
    {$pLine = $splitArr[1].ToCharArray()[1]}
    else{$pLine = $splitArr[1].ToCharArray()[1]+$splitArr[1].ToCharArray()[2]}
    $station = $splitArr[2].Split("\")[0]
    

    ## Source directory
    $path = $fileText[$i]

    
    ## Destination Log File
    $logfile= "confidential"

    Clear-Content $logfile
}

    
     
    
    
Write-Output "--- Finished log clean ---"