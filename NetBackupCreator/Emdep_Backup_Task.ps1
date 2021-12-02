    ##################################### Backup Script ###############################################
    ## Name: Backup_Script.ps1                               
    ## Creator: Erwin Bierens                     
    ## CreationDate: 10-02-2017                               
    ## LastModified: 10-05-2021 -by R.Stefanov                               
    ## Version: 2.1
    ## Website: https://erwinbierens.com/powershell-backup-script
    ## 
    ## Description: Copies the Backupdir to the Destination folder
    ## Deviations will be written to logfile
    ## Only Change Variables in Variables Section  
    ##
    ## Thx to the followingg scripts i created this one, source information
    ## http://www.krist-online.nl/index.php/scripts/14-robocopy-powershell-wekelijks-backup-schema
    ## https://blog.sat.iit.edu/2011/11/backup-script-using-robocopy-and-powershell/
    ## 
    ##
    ## Example: powershell -command "&amp; 'c:\temp\Backup_Script.ps1' "
    ## 
    ####################################################################################################
     
    ####################
    ##Variables Section
    ####################

$fileText = Get-Content -Path C:\confidential\StationPaths.txt


##Loops trough all the station paths and extracts the files
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
    $source1="$path\c`$\Foo\Bar"
    $source2="$path\c`$\Foo\Bar\Foo"
    $source3="$path\c`$\Foo\Bar"
    $source4="$path\c`$\Foo\Bar\Bar Images"


    ##if host is accessable it starts the backup
    $result = Test-Path $("$source1")
    if($result -eq "True")
    {
        ## Destination Directory
    ## you can also use the network path "\\server\share"
    $destination1= "confidential"
    $destination2= "confidential"
    $destination3= "confidential"
    $destination4= "confidential"

    
    ## Destination Log File
    $logfile= "confidential"

    ## BackupRapport is being used to check if backup is succesfull
    $backupReport= "confidential"

    ## Make changes for email reports
    $EmailFrom= "confidential.com"
    $EmailTo="confidential.com"
    $SMTPServer="confidential"

    ## Email Subjects and Body info
    $successEmailSubject="Backup Succesfull"
    $successEmailBody="The Backup is succesfull"
    $failEmailSubject="Backup Failed"
    $failEmailBody="The backup is failed, please check the attached log file"

    ## =========================================================
    ## =========== DONT CHANGE PARAMETERS BELOW ================
    ## =========================================================
     
    ## Check if destination exists, if no create folder
    if (!(Test-Path -path $destination1))
    {
    New-Item $destination1 -type directory
    }
    if (!(Test-Path -path $destination2))
    {
    New-Item $destination2 -type directory
    }
    if (!(Test-Path -path $destination3))
    {
    New-Item $destination3 -type directory
    }
    if (!(Test-Path -path $backupReport))
    {
    New-Item "confidential" -Name "logfile_backup.txt" -ItemType "file"
    }
     
    ## robocopy command
    ## /XO Excludes older files.
    ## /COPY:DATSO Specifies the file properties to be copied. D Data, A Attributes, T Time stamps, S NTFS access control list (ACL), O Owner information
    ## /E /Purge Mirrors a directory tree
    ## /R:10 Specifies the number of retries on failed copies. The default value of N is 1,000,000 (one million retries)
    ## /log: Writes the status output to the log file (overwrites the existing log file). use /log+: for appending 
    ## /NP Specifies that the progress of the copying operation (the number of files or directories copied so far) will not be displayed.
    robocopy $source1 $destination1 *.* /XO /COPY:DATSO /E /purge /R:10 /log+:$logfile /NP
    robocopy $source2 $destination2 *.* /XO /COPY:DATSO /E /purge /R:10 /log+:$logfile /NP
    robocopy $source3 $destination3 *.* /XO /COPY:DATSO /E /purge /R:10 /log+:$logfile /NP
     
    ## Check variables to compare source and destination
    $check_source1 = Dir $source1
    $check_destination1 = Dir $destination1
     $check_source2 = Dir $source2
    $check_destination2 = Dir $destination2
     $check_source3 = Dir $source3
    $check_destination3 = Dir $destination3

    ##check if station is a Vision so it will take the folder Vision Images
    if($station -eq "vc1")
    {
        if (!(Test-Path -path $destination4))
        {
            New-Item $destination4 -type directory
        }
        robocopy $source4 $destination4 *.* /XO /COPY:DATSO /E /purge /R:10 /log+:$logfile /NP
        $check_source4 = Dir $source4
        $check_destination4 = Dir $destination4

    }

    function sendFailEmail{
    send-mailmessage -from $EmailFrom -to $EmailTo -subject $failEmailSubject -body $failEmailBody -Attachments "$logfile" -priority High -dno onSuccess, onFailure -smtpServer $SMTPServer
    }
     
    ## If backup report is not empty, something is going wrong. Email will be send
    $File = Get-ChildItem $backupReport
    if ($File.Length -gt 0) {sendFailEmail}
    #EOF
    Start-Sleep -Seconds 10
    Write-Output "--- Finished station: L$pLine-$station ---"
    }
    
}
Write-Output "--- Finished plant backup ---"