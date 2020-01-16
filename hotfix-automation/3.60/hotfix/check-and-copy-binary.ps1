# 	======================================================================== (COPY FILES (FILE TYPE WISE)) ===========================================================================

#	------------------------------------------------------------------------------ DOCUMENT SUMMARY ----------------------------------------------------------------------------------
#	This document is for Tango 3.60.xx Installer
#	Copy binaries (files type wise)
# 	Get three parameters (source path, target path, file type)
# 	----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

# 	-----------------------------------------------
#	Set Source, Target Path and file type Variables
#	-----------------------------------------------
	$Source_Path	=	$($args[0])
	$Target_Path	=	$($args[1])
	$File_Name		=	$($args[2])
	$File_Type		=	$($args[3])
	$Importance		=	$($args[4])
	
	Write-Host 	"=========================================================="
	Write-Host 	"Starting process of copy $File_Name" 	-fore green
	Write-Host 	"Source Path $Source_Path " 	-fore green
	Write-Host 	"Target Path $Target_Path " 	-fore green
	Write-Host 	"FileType $File_Type " 	-fore green
	Write-Host 	"----------------------------------------"

# 	---------------------------------------
#	Check source path contains source files
#	---------------------------------------
	If(Test-Path $Source_Path) 
	{	
#	------------------------
#	Check target path exists
#	------------------------
		If (!(Test-Path $Target_Path))
		{
#	----------------------------------------------------------------
#	If target path not exists then create it through try/catch block
#	----------------------------------------------------------------
			Try
			{
				Write-Host 		"Write-Log: Creating $Target_Path" 
				New-Item 		-Path $Target_Path 		-ItemType Directory 		-ErrorAction Stop
				Write-Host 		'Folder is created successfully!' 	-fore green	
			}
			Catch
			{
				Write-Verbose 	"Write-Log: Creating "$Target_Path" failed: "$($error[0].Exception.Message)
				$ErrorMessage 	= 	$_.Exception.Message
				Write-Host 		$ErrorMessage 			
				Exit 1
			}
		}
		# 	---------------
		#	Delete old file 
		#	---------------
		Write-Host 		"Deleting old" $File_Name" file." 	-fore green			
		Write-Host 		"----------------------------------------"
		
		If (Test-Path 	$Target_Path\$File_Name)
		{
			Remove-Item $Target_Path\$File_Name			-force -recurse -verbose	
		}	
		
		Write-Host 		"----------------------------------------"
		Write-Host 		"Copying new" $File_Name 	-fore green	
		Write-Host 		"----------------------------------------"	
		If (!(Test-Path 	$Target_Path\$File_Name))
		{
			Copy-Item 		$Source_Path\$File_Name 	-Destination $Target_Path		-verbose -recurse -force  	 -ErrorAction Stop
		}		
		If (!(Test-Path 	$Target_Path\$File_Name))
		{
			$($error[0].Exception.Message)
			$ErrorMessage 	= 	$_.Exception.Message
			Write-Host 		$ErrorMessage 			
			throw 		$File_Name + " is not copied in target location." 
		}			
	}
#	------------------------------------------------
#	Else condition of checking source path existence
#	------------------------------------------------
	Else
	{
		If ($Importance -eq 'important')
		{
			throw 		$File_Name + " is not found in source location." 
		#	Exit 1
		}
		Else
		{
			Write-Host 	$File_Name + " is not found in source location." 	-fore red
		}		
#		Exit 1
	}
	If ($Importance -eq 'important')
	{
		Write-Host 		"Process of copying ("$File_Name")  is completed successfully." 	-fore green
	}
	Write-Host 			"=========================================================="
	Write-Host			""
	
# 	==================================================================================================================================================================================