<#
:: 	============================================================ (UPDATE SETUP.RUL on is2018 - VM) ================================================================

::	--------------------------------------------------------------------- DOCUMENT SUMMARY ------------------------------------------------------------------------
::	This document is for 3.80.xx Installer
:: 	Update setup.rul on 
::	"\\is2018\d$\Installers\buildscripts\cm\installers\Tango4.00_MSI\Hotfix\installer-media\TangoHotfix\Script Files\" on the basis of the following:
::	current day and week number 
::	current build number
:: 	---------------------------------------------------------------------------------------------------------------------------------------------------------------
	
#>
# 	-------------
#	Set Variables
#	-------------
	$Current_Directory 			= 	Split-Path -Parent $MyInvocation.MyCommand.Path
	
# 	-----------------------------------
#	Call Parameterized Environment file
#	-----------------------------------
	. "$Current_Directory\..\utilities\0-set-tango-cm-env.ps1"
	
# 	---------------------------------------------------------------------------------------------------
# 	Update following in setup.rul 
#	#define Current_Version_BUILD
#	#define PATCH_BUILDNO
# 	---------------------------------------------------------------------------------------------------
	write-host "rul path: "$Setup_Rul_Path	
	$Current_Version		=	"#define 	CURRENT_VERSION"				#	"$Current_Year$Current_Week_No.$Build_No"  :  "3.80.00"
	$Current_Build_No		=	"#define 	CURRENT_BUILD"					#	"$Current_Year$.Current_Week_No.$Build_No" :  "2018.12.5.629"
	
	
	$Updated_String1		=	$Current_Version   			+ '          	"' + 			$Current_Base_Version 	+ '"'	
	$Updated_String2		=	$Current_Build_No   		+ '         	"' + 			$Build_Date 			+ '"'	
	write-host "rul path: "$Build_Date	
	
	$Match_String1			=	(get-content $Setup_Rul_Path) | ? { $_ -match $Current_Version }	
	$Match_String2			=	(get-content $Setup_Rul_Path) | ? { $_ -match $Current_Build_No }
	Write-host 	{Old Value:}	$Match_String1 
	Write-host  ------------------------	
	Write-host 	{Old Value:}	$Match_String2 

	(get-content $Setup_Rul_Path) | foreach-object {
		$_ 	-replace $Match_String1,$Updated_String1`
			-replace $Match_String2,$Updated_String2`

		} | set-content $Setup_Rul_Path

		
	$PATCH_VERSION		=	"#define PATCH_VERSION"
	$PATCH_BUILD_NUMBER	=	"#define PATCH_BUILD_NUMBER"
	$POC_VERSION		=	"#define POC_VERSION    	"
	$CURRENT_BUILD		=	"#define CURRENT_BUILD   "

	$PRODUCT_NAME		=	"<row><td>ProductName</td><td>"
	$PRODUCT_VERSION	=	"<row><td>ProductVersion</td><td>"
	$tempProductName	=	(get-content $UpdateISM) | ? { $_ -match $PRODUCT_NAME }
	$tempProductVersion	=	(get-content $UpdateISM) | ? { $_ -match $PRODUCT_VERSION }

	$NEWVAR=$TARGETUPDATE     
	$temp=(get-content $Setup_Rul_Path) | ? { $_ -match $PATCH_VERSION }
	$temp1=(get-content $Setup_Rul_Path) | ? { $_ -match $POC_VERSION }	
	$temp2=(get-content $Setup_Rul_Path) | ? { $_ -match $CURRENT_BUILD }	


	$index=0
	for($i=0;$i-le $TARGETUPDATE.length-1;$i++)
	{If ($TARGETUPDATE[$i] -eq '.') 
		{
		break
		}$index=$i
	}

	$TARGET_HOTFIX_DIR = $TARGETUPDATE.Substring($index,7)


	$Updated_String1		=	$PATCH_VERSION   			+ '          "' + 			$TARGETUPDATE 	+ '"'	
	$Updated_String2		=	$POC_VERSION + '          "' 	+ $TARGET_HOTFIX_DIR + ".THF-$THFNO"  +	$ISToDay2 	+ '"' 
	$Updated_String3		=	$CURRENT_BUILD + '          "' 	+ $TARGET_HOTFIX_DIR + ".THF-$THFNO"  +	$ISToDay2 	+ '"' 
	$Updated_String4		=	$PATCH_BUILD_NUMBER   			+ '          "' + 			$TARGETUPDATE 	+ '"'	
	$HOTFIXSINGLEEXE				= $TARGET_HOTFIX_DIR + ".THF-$THFNO"  +	$ISToDay2 	+ ".exe" 

	$ISMProductName		=	 $PRODUCT_NAME + $TARGET_HOTFIX_DIR + ".THF-$THFNO"  +	$ISToDay2 	+ "</td><td/></row>" 
	$ISMProductVersion		=	$PRODUCT_VERSION + $TARGET_HOTFIX_DIR + ".THF-$THFNO"  +	$ISToDay2 	+ "</td><td/></row>" 


	$HOTFIXSETUPFOLDER = $HOTFIXSINGLEEXE.replace('.exe','')

	Write-host 	$Current_Version
	Write-host 	$Current_Build_No
	Write-host 	Rul File Path
	Write-host 	-------------
	Write-host 	$Setup_Rul_Path
	Write-host 		
	Write-host 	Build No String with dot	
	Write-host  ------------------------	
	Write-host 	{Old Value:}	$Match_String2 
	Write-host 	{New Value:}	$Updated_String2
	Write-host 		
	Write-host 	Version
	Write-host 	--------
	Write-host 	{Old Value:}	$Match_String1 
	Write-host 	{New Value:}	$Updated_String1
	
	
# 	=================================================================================================================================================================================

		
		