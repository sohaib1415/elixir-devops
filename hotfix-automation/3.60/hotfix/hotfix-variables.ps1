$Current_Directory 	= 	Split-Path -Parent $MyInvocation.MyCommand.Path
	write-host  CURRENTDIR: $Current_Directory
	
Get-Content ("$Current_Directory\thf-requested-artifacts.txt")  | Foreach {$_.TrimEnd()}  | Set-Content ("$Current_Directory\temp-thf-requested-artifacts.txt")

(get-content ("$Current_Directory\temp-thf-requested-artifacts.txt")) | out-file ("$Current_Directory\thf-requested-artifacts.txt")
	
. ("$Current_Directory\extract-hotfix-info.ps1")

$CMTANGO361_CODE_PATH = $env:bamboo_FETCHING_C_CODE_KEY
$BAMBOO_CODE_PATH = $env:bamboo_FETCHING_CODE_KEY

$HOTFIX_TYPE=$env:bamboo_HOTFIX_TYPE
#$THFNO = $env:bamboo_THF_VALUE

#$TARGETUPDATE=$env:bamboo_PATCH_BUILD_NUMBER
#$THFNO = $env:bamboo_THF_VALUE


$DIRBIN="\\CMTANGO361\elxcm\$CMTANGO361_CODE_PATH\TangoNeonCM\bin\cpp\vc14\x64\Release\"
$DIRWAR="\\BAMBOO\d$\elxcm\$BAMBOO_CODE_PATH\TangoNeonCM\war\"
$DIRJAR="\\BAMBOO\d$\elxcm\$BAMBOO_CODE_PATH\TangoNeonCM\lib\java"
$DIRTARGET="\\172.23.1.46\d$\Install\QuickStep201\Tango3.60_Hotfixes\3.60\$HOTFIX_TYPE\Resources"


write-host $CMTANGO361_CODE_PATH
write-host $BAMBOO_CODE_PATH
write-host $DIRBIN


$IS2012_HOTFIX_SETUP_PATH = "\\172.23.1.46\d$\Install\QuickStep201\Tango3.60_Hotfixes\3.60\$HOTFIX_TYPE\Tango360AutoHotfix\Media\Release 1\Package"


$UpdateSetupFile="\\172.23.1.46\d$\install\QuickStep201\Tango3.60_Hotfixes\3.60\$HOTFIX_TYPE\Script Files\Setup.Rul"
$UpdateISM="\\172.23.1.46\d$\install\QuickStep201\Tango3.60_Hotfixes\3.60\$HOTFIX_TYPE\Tango360AutoHotfix.ism"

$DATAHUB_HOTFIX_PATH = "\\datahub\Compile\PreReleases\Tango\TangoServer\3.60\Hotfixes"

#==========Variables defined in bamboo plan.=================================
$build=$env:bamboo_buildNumber
#$TARGETUPDATE=$env:bamboo_PATCH_BUILD_NUMBER
#$THFNO = $env:bamboo_THF_VALUE
#======================= DELETE IT LATER =======================================================================
#$build = 966
$TARGETUPDATE = $THE_TARGETUPDATE
$THFNO = $THFVALUE
#===============================================================================================

$ISToDay = '"'+(get-date).year.ToString()  +(get-date (get-date).adddays(+2) -uformat %V) + '.' + @(7,1,2,3,4,5,6)[(get-date).dayofweek.value__]+'.' + $build+'"'
$ISToDay2 = '.'+(get-date).year.ToString() +'.' +(get-date (get-date).adddays(+2) -uformat %V) + '.' + @(7,1,2,3,4,5,6)[(get-date).dayofweek.value__]+'.' + $build

$PATCH_VERSION="#define PATCH_VERSION"
$PATCH_BUILD_NUMBER="#define PATCH_BUILD_NUMBER"
$POC_VERSION="#define POC_VERSION    	"
$CURRENT_BUILD="#define CURRENT_BUILD   "

$PRODUCT_NAME="<row><td>ProductName</td><td>"
$PRODUCT_VERSION="<row><td>ProductVersion</td><td>"
$tempProductName=(get-content $UpdateISM) | ? { $_ -match $PRODUCT_NAME }
$tempProductVersion=(get-content $UpdateISM) | ? { $_ -match $PRODUCT_VERSION }

$NEWVAR=$TARGETUPDATE     
$temp=(get-content $UpdateSetupFile) | ? { $_ -match $PATCH_VERSION }
$temp1=(get-content $UpdateSetupFile) | ? { $_ -match $POC_VERSION }	
$temp2=(get-content $UpdateSetupFile) | ? { $_ -match $CURRENT_BUILD }	


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

#=========================================================
write-host : $TARGET_HOTFIX_DIR
write-host : $THFNO