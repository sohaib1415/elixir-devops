

$Current_Directory 	= 	Split-Path -Parent $MyInvocation.MyCommand.Path
write-host  CURRENTDIR: $Current_Directory
# 	-----------------------------------------------------------------	
# 	Call Environment setup file for environment (dir path / variable)
#	-----------------------------------------------------------------
#	. ("$Current_Directory\hotfix-variables.ps1")

$fullContent = ''

foreach($line in [System.IO.File]::ReadLines(("$Current_Directory\thf-requested-artifacts.txt")))
	{
       $line += "<br>"
       $fullContent += $line	  
	}
Start-Sleep -s 15	