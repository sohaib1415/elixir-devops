
# 	========================================================== (TANGO HOTFIX ENVIRONMENT SETUP) =======================================================
#	-------------------------------------------------------------- DOCUMENT SUMMARY ------------------------------------------------------------
# 	This file setup path and location of the following
# 	-- 	Fetching Location
#	--  Java/ANT Compilation Setup
#	--  Flex Compilation Setup
#	--  Installer Setup Location
#	--  Binaries Path Location
#	--------------------------------------------------------------------------------------------------------------------------------------------
#						Run this file as a Administrator, other wise you may get errors and failed to set the environment variables
# 	--------------------------------------------------------------------------------------------------------------------------------------------

	$Current_Directory 	= 	Split-Path -Parent $MyInvocation.MyCommand.Path
	write-host  CURRENTDIR: $Current_Directory
# 	-----------------------------------------------------------------	
# 	Call Environment setup file for environment (dir path / variable)
#	-----------------------------------------------------------------
	. ("$Current_Directory\hotfix-variables.ps1")
	write-host $HOTFIXSINGLEEXE

	write-host DLLsTarget Path: $DIRTARGET	
	
#==============================================================================================================================================================

# CREATE FOLDER at DATAHUB if Does not exists.

#==============================================================================================================================================================


if( -Not ([System.IO.Directory]::Exists($DATAHUB_HOTFIX_PATH+"\"+$TARGET_HOTFIX_DIR)))
{
   New-Item -ItemType Directory -Force -Path "$DATAHUB_HOTFIX_PATH\$TARGET_HOTFIX_DIR"
   New-Item -ItemType Directory -Force -Path "$DATAHUB_HOTFIX_PATH\$TARGET_HOTFIX_DIR\$HOTFIXSETUPFOLDER"
}
else { New-Item -ItemType Directory -Force -Path "$DATAHUB_HOTFIX_PATH\$TARGET_HOTFIX_DIR\$HOTFIXSETUPFOLDER"}	

#$IS2012_HOTFIX_SETUP_PATH
Write-Host 	DATAHUB: "$DATAHUB_HOTFIX_PATH\$TARGET_HOTFIX_DIR\$HOTFIXSETUPFOLDER"
Write-Host 	InstallShield 2012: "$IS2012_HOTFIX_SETUP_PATH\THF.exe"
#==============================================================================================================================================================

# COPY Media to DATAHUB
#==============================================================================================================================================================

$source = "$IS2012_HOTFIX_SETUP_PATH\THF.exe"
$datahub_destination = "$DATAHUB_HOTFIX_PATH\$TARGET_HOTFIX_DIR\$HOTFIXSETUPFOLDER"
 
	Copy-Item $source $datahub_destination

$Updated_Media_Name 		= 	$HOTFIXSINGLEEXE
$Default_Media_Name			=	"$DATAHUB_HOTFIX_PATH\$TARGET_HOTFIX_DIR\$HOTFIXSETUPFOLDER\THF.exe"  

$DESTINATIONROOT = "$DATAHUB_HOTFIX_PATH\$TARGET_HOTFIX_DIR\$HOTFIXSETUPFOLDER"
Write-Host 	Updated_Media_Name: $Updated_Media_Name
Write-Host 	Default_Media_Name: $Default_Media_Name
	
Rename-Item 	$Default_Media_Name $Updated_Media_Name

#=======================================================
$BINRARIES_ROOT = "$DESTINATIONROOT\binaries"
Write-Host 	BinariesROOT: $BINRARIES_ROOT
if( -Not ([System.IO.Directory]::Exists($BINRARIES_ROOT)))
{
   New-Item -ItemType Directory -Force -Path $BINRARIES_ROOT
  
}
#else { New-Item -ItemType Directory -Force -Path "$DATAHUB_HOTFIX_PATH\$TARGET_HOTFIX_DIR\$HOTFIXSETUPFOLDER"}	

#copy dlls....
$dllsdirectoryInfo = Get-ChildItem $DIRTARGET\dlls | Measure-Object
$dllscountNo = $dllsdirectoryInfo.count #  Returns the count of all of the files in the directory
if( -Not($dllsdirectoryInfo.count -eq 0)){Copy-Item -Path "$DIRTARGET\dlls" -Filter "*.*" -Recurse -Destination $BINRARIES_ROOT -Container}

#copy jars....
$jarsdirectoryInfo = Get-ChildItem $DIRTARGET\jars | Measure-Object
$jarscountNo = $jarsdirectoryInfo.count #  Returns the count of all of the files in the directory
if( -Not($jarsdirectoryInfo.count -eq 0)){Copy-Item -Path "$DIRTARGET\jars" -Filter "*.*" -Recurse -Destination $BINRARIES_ROOT -Container}

#copy wars....
$warsdirectoryInfo = Get-ChildItem $DIRTARGET\wars | Measure-Object
$warscountNo = $warsdirectoryInfo.count #  Returns the count of all of the files in the directory
if( -Not($warsdirectoryInfo.count -eq 0)){Copy-Item -Path "$DIRTARGET\wars" -Filter "*.*" -Recurse -Destination $BINRARIES_ROOT -Container}

#copy deploy....
$deploydirectoryInfo = Get-ChildItem $DIRTARGET\deploy | Measure-Object
$deploycountNo = $deploydirectoryInfo.count #  Returns the count of all of the files in the directory
if( -Not($deploydirectoryInfo.count -eq 0)){Copy-Item -Path "$DIRTARGET\deploy" -Filter "*.*" -Recurse -Destination $BINRARIES_ROOT -Container}

Start-Sleep -s 15

