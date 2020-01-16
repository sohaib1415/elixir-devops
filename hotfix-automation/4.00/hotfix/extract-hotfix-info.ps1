$Current_Directory 	= 	Split-Path -Parent $MyInvocation.MyCommand.Path
	write-host  CURRENTDIR: $Current_Directory
# 	-----------------------------------------------------------------	
# 	Call Environment setup file for environment (dir path / variable)
#	-----------------------------------------------------------------
#	. ("$Current_Directory\hotfix-variables.ps1")

$REQUIREDBIN = 0
$THFNO = 0
$SERVER = 0
$TARGETUPDATE = 0


foreach($line in [System.IO.File]::ReadLines(("$Current_Directory\thf-requested-artifacts.txt")))
{
       $line
	   
	   if($line.equals('[THF-REQUIRED-ARTIFACTS]')){
			$REQUIREDBIN = 1
			$THFNO = 0
			$TARGETUPDATE = 0
			$SERVER = 0
			}
		elseif($line.equals('[THF-TARGET-SERVER]')){
			$REQUIREDBIN = 0
			$THFNO = 0
			$TARGETUPDATE = 0
			$SERVER = 1
		}
		elseif($line.equals('[THF-NO]')){
			$REQUIREDBIN = 0
			$THFNO = 1
			$TARGETUPDATE = 0
			$SERVER = 0
			#Write-Host 		Lines Printed : 	$line
			}
		
		elseif( $line.equals('[THF-TARGET-UPDATE]')){
		
			$REQUIREDBIN = 0
			$THFNO = 0
			$TARGETUPDATE = 1
			$SERVER = 0
			
			}
			
		if( $TARGETUPDATE )
			{
				if (-not ([string]::IsNullOrEmpty($line))){	$THE_TARGETUPDATE = $line }
			}
			
		if( $THFNO )
			{
				if (-not ([string]::IsNullOrEmpty($line))){ $THFVALUE = $line }
			}
		if( $SERVER )
			{
				if (-not ([string]::IsNullOrEmpty($line))){ $SERVERVAL = $line }
			}
				
		}
		Start-Sleep -s 15