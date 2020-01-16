

$Current_Directory 	= 	Split-Path -Parent $MyInvocation.MyCommand.Path

# 	-----------------------------------------------------------------	
# 	Call Environment setup file for environment (dir path / variable)
#	-----------------------------------------------------------------
	. ("$Current_Directory\hotfix-variables.ps1")
	
	
	
(get-content $UpdateSetupFile) | foreach-object {
	$_ -replace '^#define PATCH_VERSION.*$',$Updated_String1`
	   -replace '^#define PATCH_BUILD_NUMBER.*$',$Updated_String4`
	   -replace '^#define POC_VERSION.*$',$Updated_String2`
	   -replace '^#define CURRENT_BUILD.*$',$Updated_String3`
	   -replace $temp,$NEWVAR`
	
	} | set-content $UpdateSetupFile


$content = [System.IO.File]::ReadAllText($UpdateISM).Replace($tempProductName, $ISMProductName)
[System.IO.File]::WriteAllText($UpdateISM, $content)
	
$content = [System.IO.File]::ReadAllText($UpdateISM).Replace($tempProductVersion, $ISMProductVersion)
[System.IO.File]::WriteAllText($UpdateISM, $content)

Start-Sleep -s 20