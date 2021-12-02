    ##################################### AutoSweep Script ############################################
    ## Name: AutoSweep.ps1                               
    ## Creator: Radoslav.Stefanov                   
    ## CreationDate: 29-10-2021                               
    ## LastModified: 29-10-2021                             
    ## Version: 0.1 
    ## Description: Starts all the scripts in a defined order
    ## This is the MAIN file you need to start to use the sweeper correctly
    ###################################################################################################


Write-Output "Calling VLan Sweeper!"
.("confidential\vlanSweeper.ps1")

Write-Output "Calling Result Filter!"
.("confidential\filter.ps1")

Write-Output "Calling Change Writer!"
.("confidential\writer.ps1")