		---AutoSweeper--- 	v0.1
Description:
This is a series of powershell scripts that perform a specific task.

0. AutoSweeper.ps1 starts all the other scripts in the specific order:

1. The VlanSweeper is executed, it searches all declared vlans for hosts and resolves their hostnames.
	1.1 After the sweeper has resolved the hostnames it saves its results in the adjacent data.txt file.
2. Filter script reads the data.txt that comes from the VlanSweeper and filters the entries that comply
with the Emdep naming convention.
	2.1 The Filter takes the filtered entries and performs a Test-Path in a search for a "MyProject" folder.
	-this helps to test if the host is accessable and if it is indeed an Emdep equipment.
	2.2 Every entry that has passed all checks gets formated to the *"cap" format "\\xxxx-xx-xxx" and
	gets saved in the adjacent result.txt file.
3. A Writer script starts reading from the main StationPaths.txt and compares it to the result.txt file
	from the Filter.
	3.1 Any entry that is not present in the StationPaths file gets writen inside.



		---Important---
1.Since powershell takes relative paths depending on where its executed and not from where the file is stored
the program is hardcoded with declarative paths. Any changes of storage placing has to be configured to get the 
program working again.

2.The "cap" inside the StationPaths is MANDATORY. DO NOT DELETE OR TINKER WITH IT!

3. Do NOT start the individual scripts by their own. To use the program correctly only start AutoSweep.ps1!

4.In order for the program to work it HAS to be on a server with Domain Admin Rights!


		---Info---
*"cap" - is a suffix inside the StationPaths.txt that declares the end. Without it the program will work will
skip the last station.


		---Version 0.1---
Created: 29.10.21
CreatedBy: Radoslav.Stefanov