	$Current_Directory 	= 	Split-Path -Parent $MyInvocation.MyCommand.Path
	write-host  CURRENTDIR: $Current_Directory
# 	-----------------------------------------------------------------	
# 	Call Environment setup file for environment (dir path / variable)
#	-----------------------------------------------------------------
	. ("$Current_Directory\hotfix-variables.ps1")
	. ("$Current_Directory\check-and-copy-binary.ps1")
	
	$Copy_Utility 	=	"$Current_Directory\check-and-copy-binary.ps1"
	
	Write-Host		"----------------------------------"
	Write-Host	 	"Removing previous hotfix resources"
	Write-Host		"----------------------------------"
	If (Test-Path $DIRTARGET\dlls)
	{
		Get-ChildItem 	-Path 	$DIRTARGET\dlls 	-Recurse | Remove-Item 		-force -recurse	-verbose
	}	
	If (!(Test-Path $DIRTARGET\dlls))
	{
		New-Item 		-Path 	$DIRTARGET\dlls		-ItemType Directory
	}
	If (Test-Path $DIRTARGET\jars)
	{
		Get-ChildItem 	-Path 	$DIRTARGET\jars 	-Recurse | Remove-Item 		-force -recurse	-verbose
	}	
	If (!(Test-Path $DIRTARGET\jars))
	{
		New-Item 		-Path 	$DIRTARGET\jars		-ItemType Directory
	}
	If (Test-Path $DIRTARGET\wars)
	{
		Get-ChildItem 	-Path 	$DIRTARGET\wars 	-Recurse | Remove-Item 		-force -recurse	-verbose
	}	
	If (!(Test-Path $DIRTARGET\wars))
	{
		New-Item 		-Path 	$DIRTARGET\wars		-ItemType Directory
	}
	If (Test-Path $DIRTARGET\deploy)
	{
		Get-ChildItem 	-Path 	$DIRTARGET\deploy 	-Recurse | Remove-Item 		-force -recurse	-verbose
	}	
	If (!(Test-Path $DIRTARGET\deploy))
	{
		New-Item 		-Path 	$DIRTARGET\deploy		-ItemType Directory
	}
	If (Test-Path $DIRTARGET\deploy-ref)
	{
		Get-ChildItem 	-Path 	$DIRTARGET\deploy-ref 	-Recurse | Remove-Item 		-force -recurse	-verbose
	}	
	If (!(Test-Path $DIRTARGET\deploy-ref))
	{
		New-Item 		-Path 	$DIRTARGET\deploy-ref		-ItemType Directory
	}
	Write-Host		"----------------------------------"
	Write-Host	 	"Removing previous hotfix completed"
	Write-Host		"----------------------------------"
	
	$THF_Number 				= 	0
	$THF_Target_Update 			= 	0

	$THF_Required_New_Binaries 	= 	0
	$THF_Required_Old_Binaries	= 	0
	
	$Is_Old_Bin					= 	0
	$Is_Old_Jar					= 	0
	$Is_Old_Webapps_War			= 	0
	$Is_Old_Deploy_War			= 	0


foreach($line in [System.IO.File]::ReadLines(("$Current_Directory\thf-requested-artifacts.txt")))
{
   if($line.equals('[THF-REQUIRED-ARTIFACTS]'))
	{
		$THF_Required_New_Binaries 	= 	1
		$THF_Number 				= 	0
		$THF_Target_Update 			= 	0
		$THF_Required_Old_Binaries	= 	0
		$Is_Old_Bin					= 	0
		$Is_Old_Jar					= 	0
		$Is_Old_Webapps_War			= 	0
		$Is_Old_Deploy_War			= 	0
	}
	elseif($line.equals('[THF-NO]'))
	{
		$THF_Required_New_Binaries 	= 	0
		$THF_Number 				= 	1
		$THF_Target_Update 			= 	0
		$THF_Required_Old_Binaries	= 	0
		$Is_Old_Bin					= 	0
		$Is_Old_Jar					= 	0
		$Is_Old_Webapps_War			= 	0
		$Is_Old_Deploy_War			= 	0
	}		
	elseif( $line.equals('[THF-TARGET-UPDATE]'))
	{		
		$THF_Required_New_Binaries 	= 	0
		$THF_Number 				= 	0
		$THF_Target_Update 			= 	1
		$THF_Required_Old_Binaries	= 	0
		$Is_Old_Bin					= 	0
		$Is_Old_Jar					= 	0
		$Is_Old_Webapps_War			= 	0
		$Is_Old_Deploy_War			= 	0			
	}
	elseif( $line.equals('[THF-OLD-ARTIFACTS-NAMES]'))
	{		
		$THF_Required_New_Binaries 	= 	0
		$THF_Number 				= 	0
		$THF_Target_Update 			= 	0
		$THF_Required_Old_Binaries	= 	1
		$Is_Old_Bin					= 	0
		$Is_Old_Jar					= 	0
		$Is_Old_Webapps_War			= 	0
		$Is_Old_Deploy_War			= 	0				
	}			
	elseif( $line.equals('[THF-OLD-BIN-ARTIFACTS-PATH]'))
	{
		$THF_Required_New_Binaries 	= 	0
		$THF_Number 				= 	0
		$THF_Target_Update 			= 	0
		$THF_Required_Old_Binaries	= 	0
		$Is_Old_Bin					= 	1
		$Is_Old_Jar					= 	0
		$Is_Old_Webapps_War			= 	0
		$Is_Old_Deploy_War			= 	0
	}	
	elseif( $line.equals('[THF-OLD-JAR-ARTIFACTS-PATH]'))
	{		
		$THF_Required_New_Binaries 	= 	0
		$THF_Number 				= 	0
		$THF_Target_Update 			= 	0
		$THF_Required_Old_Binaries	= 	0
		$Is_Old_Bin					= 	0
		$Is_Old_Jar					= 	1
		$Is_Old_Webapps_War			= 	0
		$Is_Old_Deploy_War			= 	0				
	}	
	elseif( $line.equals('[THF-OLD-WEBAPPS-WAR-ARTIFACTS-PATH]'))
	{		
		$THF_Required_New_Binaries 	= 	0
		$THF_Number 				= 	0
		$THF_Target_Update 			= 	0
		$THF_Required_Old_Binaries	= 	0
		$Is_Old_Bin					= 	0
		$Is_Old_Jar					= 	0
		$Is_Old_Webapps_War			= 	1
		$Is_Old_Deploy_War			= 	0
	}
	elseif( $line.equals('[THF-OLD-DEPLOY-WAR-ARTIFACTS-PATH]'))
	{		
		$THF_Required_New_Binaries 	= 	0
		$THF_Number 				= 	0
		$THF_Target_Update 			= 	0
		$THF_Required_Old_Binaries	= 	0
		$Is_Old_Bin					= 	0
		$Is_Old_Jar					= 	0
		$Is_Old_Webapps_War			= 	0
		$Is_Old_Deploy_War			= 	1
	}
	if (-not ([string]::IsNullOrEmpty($line)))
	{
		if( $THF_Target_Update ) 
		{
			$THE_TARGETUPDATE	= 	$line 
		}			
		if( $THF_Number )
		{
			$THFVALUE 			= 	$line	
		}
		if( $Is_Old_Bin )
		{
			$OLDBINPATH 		= 	$line	
		}
		if( $Is_Old_Jar )
		{
			$OLDJARSPATH 		= 	$line	
		}
		if( $Is_Old_Webapps_War )
		{
			$OLDWARSPATH 		= 	$line
		}
		if( $Is_Old_Deploy_War )
		{
			$OLDDeployWARSPATH 	= 	$line
		}
	
		if(
			(($THF_Required_Old_Binaries) -or ($THF_Required_New_Binaries)) -and 
			($line -ne '[THF-REQUIRED-ARTIFACTS]') -and 
			($line -ne '[THF-OLD-ARTIFACTS-NAMES]')
		)
		{ 
			if($THF_Required_Old_Binaries)
			{
				$Src_Bin_Path			=	$OLDBINPATH
				$Src_Msgs_Path			=	$OLDBINPATH
				$Src_Jar_Path			=	$OLDJARSPATH
				$Src_War_Path			=	$OLDWARSPATH
				$Src_Deploy_War_Path	=	$OLDDeployWARSPATH
			}
			else 
			{
				$Src_Bin_Path			=	$DIRBIN
				$Src_Msgs_Path			=	$DIRMSGS
				$Src_Jar_Path			=	$DIRJAR
				$Src_War_Path			=	$DIRWAR
				$Src_Deploy_War_Path	=	$Src_War_Path
			}
			
				
			$Extension					= 	[System.IO.Path]::GetExtension($line)
			$str_lenght					=	$Extension.Length			
			$File_Type					=	$Extension.Substring(1,$str_lenght-1)		
			$File_Name					=	$line
			
			if( 
				($File_Type -Match "dll")	-or
				($File_Type -Match "exe")	-or
				($File_Type -Match "msgs")	-or
				($File_Type -Match "rplg")
				)
			{
				if($File_Type -Match "rplg")
				{
					$Final_Src_Path		=	"$Src_Msgs_Path"
				}
				else
				{
					$Final_Src_Path		=	"$Src_Bin_Path"
				}
				$Final_Target_Path		=	"$DIRTARGET\dlls"
			}		
			elseif ( $File_Type -Match "jar")	
			{
				$Final_Src_Path			=	"$Src_Jar_Path"
				$Final_Target_Path		=	"$DIRTARGET\jars"
			} 	   
			elseif ( $File_Type	-Match "war")
			{
				$Match_File_Name		=	[System.IO.Path]::GetFileName($line)
				if (					
					( $Match_File_Name -Match "tango-hook-6.2.10.1.war") -or
					( $Match_File_Name -Match "helium-portlet-6.2.10.1.war") -or
					( $Match_File_Name -Match "tango-cui-portlet-6.2.10.1.war") -or
					( $Match_File_Name -Match "helium-default-theme-6.2.10.1.war") -or
					( $Match_File_Name -Match "helium-myworkflow-ext-6.2.10.1.war")
					)
				{
					$Final_Src_Path			=	"$Src_Deploy_War_Path"					
					$Final_Target_Path		=	"$DIRTARGET\deploy"
					& "$Copy_Utility" 	$Final_Src_Path "$DIRTARGET\deploy-ref"	$File_Name $File_Type important
				}				
				else 
				{
					$Final_Src_Path			=	"$Src_War_Path"
					$Final_Target_Path		=	"$DIRTARGET\wars"
				}	
			}
			& "$Copy_Utility" 	$Final_Src_Path $Final_Target_Path	$File_Name $File_Type important
	    }
		}

}
Write-Host THFVALUE : 	$THFVALUE
Write-Host THETARGETUPDATE : $THE_TARGETUPDATE
Start-Sleep -s 15
