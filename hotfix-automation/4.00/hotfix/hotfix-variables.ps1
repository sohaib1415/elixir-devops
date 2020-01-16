# 	-------------
#	Set Variables
#	-------------
	$Current_Directory 			= 	Split-Path -Parent $MyInvocation.MyCommand.Path
	
# 	-----------------------------------
#	Call Parameterized Environment file
#	-----------------------------------
	. ("$Current_Directory\0-get-bamboo-variables.ps1")
	. ("$Current_Directory\extract-hotfix-info.ps1")
	
	Get-Content ("$Current_Directory\thf-requested-artifacts.txt")  | Foreach {$_.TrimStart()}  | Set-Content ("$Current_Directory\temp_start-thf-requested-artifacts.txt")
	Get-Content ("$Current_Directory\temp_start-thf-requested-artifacts.txt")  | Foreach {$_.TrimEnd()}  | Set-Content ("$Current_Directory\temp_end-thf-requested-artifacts.txt")

	#(get-content ("$Current_Directory\temp_start-thf-requested-artifacts.txt")) | out-file ("$Current_Directory\thf-requested-artifacts.txt")
	(get-content ("$Current_Directory\temp_end-thf-requested-artifacts.txt")) | out-file ("$Current_Directory\thf-requested-artifacts.txt")
	

	$HOTFIX_TYPE=$env:bamboo_HOTFIX_TYPE
	#$THFNO = $env:bamboo_THF_VALUE

	#$TARGETUPDATE=$env:bamboo_PATCH_BUILD_NUMBER
	#$THFNO = $env:bamboo_THF_VALUE

	$Bin_Src_Path					=	"$Compilation_VM\elxcm\$Fetching_C_Code_Key\TangoNeonCM\bin\cpp\vc141\x64\Release"
	$Msgs_Src_Path					=	"$Compilation_VM\elxcm\$Fetching_C_Code_Key\TangoNeonCM\src\common\messages"
	$War_Src_Path					=	"$Bamboo_Vm\elxcm\$Fetching_Code_Key\TangoNeonCM\war\"
	$Insternal_Jar_Src_Path			=	"$Bamboo_Vm\elxcm\$Fetching_Code_Key\TangoNeonCM\lib\java"
	$External_Jars_Src_Path			=	"$Bamboo_Vm\elxcm\$Fetching_Code_Key\TangoNeonCM\external\java"	
	$External_Deploy_Jars_Src_Path	=	"$External_Jars_Src_Path\deploy"
	$Installer_Root_Path			=	"$Installaer_Machine\$Hotfix_Resources_Path\Tango" + $Current_Base_version+ "_MSI\Hotfix"
	$Installer_Resources_Path		=	"$Installer_Root_Path\installer-resources"
	$Installer_Media_Path			=	"$Installer_Root_Path\installer-media\TangoHotfix\Media\Release 1\Package"
	$Installer_Rul_Path				=	"$Installer_Root_Path\installer-media\TangoHotfix\Script Files\Setup.Rul"
	$Installer_ISM_Path				=	"$Installer_Root_Path\installer-media\TangoHotfix.ism"
	$Hotfix_Datahub_Path 			= 	"\\datahub\Compile\PreReleases\Tango\TangoServer\" + $Current_Base_version+ "\Hotfixes"


	write-host $Fetching_C_Code_Key
	write-host $Fetching_Code_Key
	write-host $Bin_Src_Path


	#$IS2012_HOTFIX_SETUP_PATH = "\\172.23.1.46\d$\Install\QuickStep201\Tango3.60_Hotfixes\3.60\$HOTFIX_TYPE\Tango360AutoHotfix\Media\Release 1\Package"


	#$Installer_Rul_Path="\\172.23.1.46\d$\install\QuickStep201\Tango3.60_Hotfixes\3.60\$HOTFIX_TYPE\Script Files\Setup.Rul"
	#$UpdateISM="\\172.23.1.46\d$\install\QuickStep201\Tango3.60_Hotfixes\3.60\$HOTFIX_TYPE\Tango360AutoHotfix.ism"

	
	#==========Variables defined in bamboo plan.=================================
	#$build=$env:bamboo_buildNumber
	#$TARGETUPDATE=$env:bamboo_PATCH_BUILD_NUMBER
	#$THFNO = $env:bamboo_THF_VALUE
	#======================= DELETE IT LATER =======================================================================
	#$build = 966
	$TARGETUPDATE 		= 	$THE_TARGETUPDATE
	$THFNO 				= 	$THFVALUE
	#===============================================================================================

	$ISToDay 			= '"'+(get-date).year.ToString()  +(get-date (get-date).adddays(+2) -uformat %V) + '.' + @(7,1,2,3,4,5,6)[(get-date).dayofweek.value__]+'.' + $Build_No+'"'
	$ISToDay2 			= '.'+(get-date).year.ToString() +'.' +(get-date (get-date).adddays(+2) -uformat %V) + '.' + @(7,1,2,3,4,5,6)[(get-date).dayofweek.value__]+'.' + $Build_No

	$PATCH_VERSION		=	"#define PATCH_VERSION"
	$PATCH_BUILD_NUMBER	=	"#define PATCH_BUILD_NUMBER"
	$POC_VERSION		=	"#define POC_VERSION    	"
	$CURRENT_BUILD		=	"#define CURRENT_BUILD   "
	$Web_Server_Type	=	"#define SERVER_TYPE"

	$PRODUCT_NAME		=	"<row><td>ProductName</td><td>"
	$PRODUCT_VERSION	=	"<row><td>ProductVersion</td><td>"
	$tempProductName	=	(get-content $Installer_ISM_Path) | ? { $_ -match $PRODUCT_NAME }
	$tempProductVersion	=	(get-content $Installer_ISM_Path) | ? { $_ -match $PRODUCT_VERSION }

	$NEWVAR				=	$TARGETUPDATE     
	$Server_Type		=	$SERVERVAL     
	$temp				=	(get-content $Installer_Rul_Path) | ? { $_ -match $PATCH_VERSION }
	$temp1				=	(get-content $Installer_Rul_Path) | ? { $_ -match $POC_VERSION }	
	$temp2				=	(get-content $Installer_Rul_Path) | ? { $_ -match $CURRENT_BUILD }	
	$temp3				=	(get-content $Installer_Rul_Path) | ? { $_ -match $Web_Server_Type }	


	$index				=	0
	for($i=0;$i-le $TARGETUPDATE.length-1;$i++)
	{If ($TARGETUPDATE[$i] -eq '.') 
		{
		break
		}$index=$i
	}

	$TARGET_HOTFIX_DIR 	= 	$TARGETUPDATE.Substring($index,7)


	$Updated_Patch_Version	=	$PATCH_VERSION   			+ '		"' 		+ 	$TARGETUPDATE 		+ '"'	
	$Updated_Server_Type	=	$Web_Server_Type   			+ '          "' + 	$Server_Type 	+ '"'	
	
	$Updated_String2	=	$POC_VERSION + '          "' 	+ $TARGET_HOTFIX_DIR + ".THF-$THFNO"  +	$ISToDay2 	+ '"' 
	$Updated_String3	=	$CURRENT_BUILD + '          "' 	+ $TARGET_HOTFIX_DIR + ".THF-$THFNO"  +	$ISToDay2 	+ '"' 
	$Updated_String4	=	$PATCH_BUILD_NUMBER   			+ '          "' + 			$TARGETUPDATE 	+ '"'	
	
	$HOTFIXSINGLEEXE	= 	$TARGET_HOTFIX_DIR + ".THF-$THFNO"  +	$ISToDay2 	+ ".exe" 

	$ISMProductName		=	$PRODUCT_NAME + $TARGET_HOTFIX_DIR + ".THF-$THFNO"  +	$ISToDay2 	+ "</td><td/></row>" 
	$ISMProductVersion	=	$PRODUCT_VERSION + $TARGET_HOTFIX_DIR + ".THF-$THFNO"  +	$ISToDay2 	+ "</td><td/></row>" 


	$HOTFIXSETUPFOLDER 	= 	$HOTFIXSINGLEEXE.replace('.exe','')

	#=========================================================
	write-host : $TARGET_HOTFIX_DIR
	write-host : $THFNO