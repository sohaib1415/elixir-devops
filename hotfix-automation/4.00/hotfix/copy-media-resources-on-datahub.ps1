
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

	write-host DLLsTarget Path: $Installer_Resources_Path	
	
#==============================================================================================================================================================

# CREATE FOLDER at DATAHUB if Does not exists.

#==============================================================================================================================================================


if( -Not ([System.IO.Directory]::Exists($Hotfix_Datahub_Path+"\"+$TARGET_HOTFIX_DIR)))
{
   New-Item -ItemType Directory -Force -Path "$Hotfix_Datahub_Path\$TARGET_HOTFIX_DIR"
   New-Item -ItemType Directory -Force -Path "$Hotfix_Datahub_Path\$TARGET_HOTFIX_DIR\$HOTFIXSETUPFOLDER"
}
else { New-Item -ItemType Directory -Force -Path "$Hotfix_Datahub_Path\$TARGET_HOTFIX_DIR\$HOTFIXSETUPFOLDER"}	

#$Installer_Media_Path
Write-Host 	DATAHUB: "$Hotfix_Datahub_Path\$TARGET_HOTFIX_DIR\$HOTFIXSETUPFOLDER"
Write-Host 	InstallShield 2018: "$Installer_Media_Path\THF.exe"
#==============================================================================================================================================================

# COPY Media to DATAHUB
#==============================================================================================================================================================

$source = "$Installer_Media_Path\THF.exe"
$datahub_destination = "$Hotfix_Datahub_Path\$TARGET_HOTFIX_DIR\$HOTFIXSETUPFOLDER"
 
	Copy-Item $source $datahub_destination

$Updated_Media_Name 		= 	$HOTFIXSINGLEEXE
$Default_Media_Name			=	"$Hotfix_Datahub_Path\$TARGET_HOTFIX_DIR\$HOTFIXSETUPFOLDER\THF.exe"  

$DESTINATIONROOT = "$Hotfix_Datahub_Path\$TARGET_HOTFIX_DIR\$HOTFIXSETUPFOLDER"
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
#else { New-Item -ItemType Directory -Force -Path "$Hotfix_Datahub_Path\$TARGET_HOTFIX_DIR\$HOTFIXSETUPFOLDER"}	

#copy dlls....
$dllsdirectoryInfo = Get-ChildItem $Installer_Resources_Path\bin | Measure-Object
$dllscountNo = $dllsdirectoryInfo.count #  Returns the count of all of the files in the directory
if( -Not($dllsdirectoryInfo.count -eq 0)){Copy-Item -Path "$Installer_Resources_Path\bin" -Filter "*.*" -Recurse -Destination $BINRARIES_ROOT -Container}

#copy jars....
$jarsdirectoryInfo = Get-ChildItem $Installer_Resources_Path\shared-lib | Measure-Object
$jarscountNo = $jarsdirectoryInfo.count #  Returns the count of all of the files in the directory
if( -Not($jarsdirectoryInfo.count -eq 0)){Copy-Item -Path "$Installer_Resources_Path\shared-lib" -Filter "*.*" -Recurse -Destination $BINRARIES_ROOT -Container}

$jarsdirectoryInfo = Get-ChildItem $Installer_Resources_Path\root-lib | Measure-Object
$jarscountNo = $jarsdirectoryInfo.count #  Returns the count of all of the files in the directory
if( -Not($jarsdirectoryInfo.count -eq 0)){Copy-Item -Path "$Installer_Resources_Path\root-lib" -Filter "*.*" -Recurse -Destination $BINRARIES_ROOT -Container}

#copy wars....
$warsdirectoryInfo = Get-ChildItem $Installer_Resources_Path\wars | Measure-Object
$warscountNo = $warsdirectoryInfo.count #  Returns the count of all of the files in the directory
if( -Not($warsdirectoryInfo.count -eq 0)){Copy-Item -Path "$Installer_Resources_Path\wars" -Filter "*.*" -Recurse -Destination $BINRARIES_ROOT -Container}

#copy deploy....
$deploydirectoryInfo = Get-ChildItem $Installer_Resources_Path\deploy | Measure-Object
$deploycountNo = $deploydirectoryInfo.count #  Returns the count of all of the files in the directory
if( -Not($deploydirectoryInfo.count -eq 0)){Copy-Item -Path "$Installer_Resources_Path\deploy" -Filter "*.*" -Recurse -Destination $BINRARIES_ROOT -Container}

$deploydirectoryInfo = Get-ChildItem $Installer_Resources_Path\deploy-ref | Measure-Object
$deploycountNo = $deploydirectoryInfo.count #  Returns the count of all of the files in the directory
if( -Not($deploydirectoryInfo.count -eq 0)){Copy-Item -Path "$Installer_Resources_Path\deploy-ref" -Filter "*.*" -Recurse -Destination $BINRARIES_ROOT -Container}

Start-Sleep -s 15

