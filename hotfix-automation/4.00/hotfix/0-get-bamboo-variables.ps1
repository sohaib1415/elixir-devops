<#
:: 	============================================================================= (BAMBOO VARIABLES) ==============================================================================

#	------------------------------------------------------------------------------ DOCUMENT SUMMARY -------------------------------------------------------------------------------
#	This document is for Tango 3.60.xx Hotfix
# 	Get bamboo variables (dir path / variable) for all the script files
# 	-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#>

# 	-------------------------
# 	Bamboo Built-in Variables
# 	-------------------------
	$Working_Dir					=	$env:bamboo_agentWorkingDirectory
	$Plan_Key						=	$env:bamboo_planKey
	$Job_Key						=	$env:bamboo_buildKey
	$Main_Plan_Build_No				=	$env:bamboo_buildNumber
	$Build_No						=	$env:bamboo_buildNumber
	$Build_Time						=	$env:bamboo_buildTimeStamp
	$Build_Triggered 				=	$env:bamboo_ManualBuildTriggerReason_userName
	$Repository1_Name				=	$env:bamboo_planRepository_1_name
	$Repository2_Name				=	$env:bamboo_planRepository_2_name
	$Branch_Type					=	$env:bamboo_planRepository_1_branch
	$Branch2_Name					=	$env:bamboo_planRepository_2_branch
	$Branch1_Revision_No			=	$env:bamboo_planRepository_1_revision
	$Branch2_Revision_No			=	$env:bamboo_planRepository_2_revision
	$Branch1_Previous_Revision_No	=	$env:bamboo_repository_previous_revision_number
	$Jira_Link						=	"http://bamboo.elixir.com.pk/browse/" + $Plan_Key + "-" + $Build_No + "/issues"
	
	
# 	===============================================================================================================
# 	----------------------------------------------- Global Variables ----------------------------------------------
# 	===============================================================================================================
	$DATAHUB						=	$env:bamboo_DATAHUB_MACHINE					#	\\172.23.0.245\Compile
	
	$Bamboo_Vm						=	$env:bamboo_BAMBOO_MACHINE					#	\\172.23.1.44\d$
	$Installer_Vm					=	$env:bamboo_INSTALLER_MACHINE				#	\\172.23.1.46\d$
	$Compilation_VM					= 	$env:bamboo_COMPILATION_MACHINE
	
	$Buildscript_Path				=	$env:bamboo_BUILDSCRIPT_PATH				#	TangoNeonCM\buildscripts\cm
	$Bamboo_Build_Dir				=	$env:bamboo_LATEST_BUILD_LOCAL_DIR			#	Base_Build_Dir
	$Bamboo_Patch_Build_Dir			=	$env:bamboo_PATCH_LATEST_BUILD_LOCAL_DIR	#	Patch_Latest_Build
	$Bamboo_Plugin_Build_Dir		=	$env:bamboo_PLUGINS_LATEST_BUILD_LOCAL_DIR	#	Plugins_Latest_Build
	$Product_Version				=	$env:bamboo_PRODUCT_VERSION					#	3.60
	$Product_Latest_Version			=	$env:bamboo_LATEST_PRODUCT_VERSION			#	3.80
	$Tango_Plus_Plan_Key			=	$env:bamboo_TANGO_PLUS_PLAN_KEY				#	TN-TP360-FLC
	
	$Fetching_Code_Key				=	$env:bamboo_FETCHING_CODE_KEY				#	TN-TAN360VS2015-FLC
	$Fetching_C_Code_Key			=	$env:bamboo_FETCHING_C_CODE_KEY				#	TN-TAN360VS2015-FLCOC
	$Base_Clone						=	$env:bamboo_CLONE							#	
	
# 	---------------------------------------------------------------------------------------------------------------
# 	Patch/Update Variables (in Global Variables)
# 	---------------------------------------------------------------------------------------------------------------
	$Current_Patch_Actual_Value		=	$env:bamboo_CURRENT_PATCH_ACTUAL_VALUE		#	#define PATCH_360xx_ACTUAL	
	$Current_Patch_No				=	$env:bamboo_CURRENT_PATCH_NO				#	xx
	$Current_Patch_Version			=	$env:bamboo_CURRENT_PATCH_VERSION 			# 	3.60.xx
	$Current_Base_Version			=	$env:bamboo_CURRENT_BASE_VERSION 			# 	4.00
	$Current_Update_No				=	$env:bamboo_CURRENT_UPDATE_NO				#	YY
	$Current_Update_Version			=	$env:bamboo_CURRENT_UPDATE_VERSION			#	Update-YY
#	===============================================================================================================

# 	----------------------------------
# 	Custom (Patches/Updates) Variables
# 	----------------------------------	
	$Build_Path						=	$env:bamboo_BUILD_PATH

# 	===============================================================================================================
# 	---------------------------------- Common Variables But Different Values --------------------------------------
# 	===============================================================================================================
#	s
	
	$Tango_Binaries_Path			=	$env:bamboo_TANGO_BINARIES_PATH
	
	
	$Installaer_Machine 	= $env:bamboo_INSTALLER_MACHINE
	$BAMBOO_CODE_PATH 		= $env:bamboo_FETCHING_CODE_KEY
	$Hotfix_Resources_Path	= $env:bamboo_HOTFIX_RESOURCES_PATH
	
