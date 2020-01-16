

$Current_Directory 	= 	Split-Path -Parent $MyInvocation.MyCommand.Path

# 	-----------------------------------------------------------------	
# 	Call Environment setup file for environment (dir path / variable)
#	-----------------------------------------------------------------
	. ("$Current_Directory\hotfix-variables.ps1")
	
	
	
	(get-content $Installer_Rul_Path) | foreach-object {
		$_ -replace '^#define PATCH_VERSION.*$',$Updated_Patch_Version`
		   -replace '^#define PATCH_BUILD_NUMBER.*$',$Updated_String4`
		   -replace '^#define POC_VERSION.*$',$Updated_String2`
		   -replace '^#define CURRENT_BUILD.*$',$Updated_String3`
		   -replace $temp3,$Updated_Server_Type`
		
		} | set-content $Installer_Rul_Path


	$content = [System.IO.File]::ReadAllText($Installer_ISM_Path).Replace($tempProductName, $ISMProductName)
	[System.IO.File]::WriteAllText($Installer_ISM_Path, $content)
		
	$content = [System.IO.File]::ReadAllText($Installer_ISM_Path).Replace($tempProductVersion, $ISMProductVersion)
	[System.IO.File]::WriteAllText($Installer_ISM_Path, $content)

	Start-Sleep -s 20