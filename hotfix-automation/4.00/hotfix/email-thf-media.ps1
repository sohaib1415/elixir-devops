<#
:: 	=========================================================================== (EMAIL TO ALL STAKEHOLDERS) ==========================================================================

::	------------------------------------------------------------------------------ DOCUMENT SUMMARY ----------------------------------------------------------------------------------
::	This document is for 3.60.xx installer
:: 	Copy patch from bamboo to stpvss
:: 	Email to relevent stakeholders
:: 	----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	
#>

	$Current_Directory 			= 	Split-Path -Parent $MyInvocation.MyCommand.Path
	
	# 	-----------------------------------
	#	Call Parameterized Environment file
	#	-----------------------------------
	
	#. "$Current_Directory\..\utilities\send-email.ps1"
	. "$Current_Directory\copy-media-resources-on-datahub.ps1"
	. "$Current_Directory\requested-THF.ps1"
	. "$Current_Directory\0-get-bamboo-variables.ps1"
	
	

	$Note = " Please make sure NO binary should be locked on install/uninstall of hotfix"
	$Email_Subject=$HOTFIXSETUPFOLDER
Write-Host 	EMAIL SUB: $Email_Subject
# 	---------------------
# 	Email Recipients list
# 	---------------------
<#	$Email_Recipients		=	"Sohaib_Danish@elixir.com, Iabad_CM@elixir.com, Mohsin_Siddiqui@elixir.com, Iabad_Tango@elixir.com, tangosos@elixir.com"
	$Email_CC_Recipients	=	"Zulfiqar_Bashir@elixir.com"

	$Email_Recipients		=	"Sohaib_Danish@elixir.com, Mohsin_Siddiqui@elixir.com, abrar_hashmi@elixir.com, hafiz_m_sarwar@elixir.com, syed_ali_imran@elixir.com"
	$Email_CC_Recipients	=	"Sohaib_Danish@elixir.com"
#>	

	$Email_Recipients		=	"Iabad_Tango@elixir.com"
	$Email_CC_Recipients	=	"Iabad_CM@elixir.com"

	
	
$Email_Subject=$HOTFIXSETUPFOLDER
	# 	---------------
	# 	Email Structure
	# 	---------------
	$Email_Msg 				= 	"
		<div style='padding:10px 0;'>
			<p style='margin:5px 0;'>
				$Email_Subject is available at: <br>
			</p>
			<div>
				<span style='margin:5px 0; color:#00F; border-bottom:1px solid #00F;'>$datahub_destination</span>
			</div>
			<br>
			<p style='margin:5px 0;'>
				JIRA issues related to subject build can be viewed at:
			</p>
			<p style='margin:5px 0;'>
				<a href='$Jira_Link'>$Jira_Link</a>
				<p style='margin:5px 0;'><b></b>  </p>
				<div>
					<br>
					<span style='margin:5px 0; color:#00F; border-bottom:1px solid #00F;'>NOTE: </span>
					<p style='margin:5px 0;'>$Note</p>
				</div>
			</p>
			
		</div>
		<br>
		<div style='border-top:1px solid #999; border-bottom:1px solid #999;  padding: 10px 0;'>
			<p style='margin:5px 0;'><b>Requested THF Branch	: </b> $Branch_Type</p>
				<span style='margin:5px 0; color:#000000; border-bottom:1px solid #999;'>CPP-Code-2015 Repository: </span>
			<p style='margin:5px 0;'><b></b>$Repository1_Name</p><br>
				<span style='margin:5px 0; color:#000000; border-bottom:1px solid #999;'>External For VS 2015 Repository: </span>
			<p style='margin:5px 0;'><b></b>$Repository2_Name</p><br>
			<p style='margin:5px 0;'><b>Build Time Stamp		: </b> $Build_Time</p>
			<p style='margin:5px 0;'><b>Manual Run By		: </b> $Build_Triggered </p>
			<div style='border-top:1px solid #00F; border-bottom:1px solid #00F;  padding: 10px 0;'>
				<p style='margin:5px 0;'><b>Requested THF Details		:</b></p>
			</div>
			
			<p style='margin:5px 0;'><b></b></p>
			<p style='margin:5px 0;'><b></b>$fullContent</p>
			<br>
			
		</div>
		
	"

# 	-------------
# 	Sending Email
# 	-------------
    Write-Host ---------------
    Write-Host Email Structure
    Write-Host ---------------
	Write-Host {Recipients     :} $Email_Recipients
	Write-Host {CC Recipients  :} $Email_CC_Recipients
	Write-Host {Subject        :} $Email_Subject
	Write-Host {Message        :} $Email_Msg

	
		# 	----------------
		# 	SMTP server name
		# 	----------------
			$SMTP_Server 			= 	"172.23.0.1"

		# 	----------------------
		# 	Creating a Mail object
		# 	----------------------
			$Mail_Object 			= 	new-object Net.Mail.MailMessage

		
		# 	---------------------------
		# 	Creating SMTP server object
		# 	---------------------------
			$SMTP_Client_Object 	= 	new-object Net.Mail.SmtpClient($SMTP_Server)

		# 	---------------------
		# 	Email Recipients list
		# 	---------------------
			$Mail_Object.From 		=	"Bamboo@elixir.com"
			$Mail_Object.ReplyTo 	= 	"Iabad_CM@elixir.com"

			$Mail_Object.To.Add($Email_Recipients)
			$Mail_Object.CC.Add($Email_CC_Recipients)
			
			$Mail_Object.subject 	=	$Email_Subject
			
			$Mail_Object.body 		= 	"
			<div style='font-family:Arial;    font-size: small;'>
				<div style='padding:10px 0;'>
					Assalam o Alaikum,
				</div>
				$Email_Msg
				<br>
				<br>
				<div style='padding:20px 0;'>
					<p style='margin:5px 0;color:#757b80'>---</p>
					<p style='margin:5px 0;color:#757b80'>Best Regards,</p>
					<p style='margin:5px 0;color:#757b80;font-weight:bold;'>Configuration Management Team</p>
					<p style='margin:5px 0; color:#757b80; font-weight:bold'>Email: <a style='color:#0082BF' href='mailto:iabad_cm@elixir.com'>iabad_cm@elixir.com</a></p>
					<p style='margin:5px 0;'><img src='cid:Email_Image' /></p>
				</div>
				<br>
				<div style='color:#757b80; font-size: x-small; padding: 10px 0;'>
					<div style='border-top:1px dotted #aaa; border-bottom:1px dotted #aaa; text-align:center; padding: 2px 0;'><b>CONFIDENTIALITY NOTICE</b></div>
					<div style='border-bottom:1px dotted #aaa; text-align:left; padding: 2px 0;'>
						This message may contain confidential and/or proprietary information, and is intended for the person/entity to whom it was originally addressed. Any use by others is strictly prohibited.
					</div>
				</div>
			</div>
			"		
	
		# 	------------------
		# 	Allow HTML to work
		# 	------------------
			$Mail_Object.IsBodyHtml = 	$true

		# 	-------------
		# 	Sending email
		# 	-------------
			Write-Host {Sending Email...}
			Write-Host
			$SMTP_Client_Object.Send($Mail_Object)

# 	==================================================================================================================================================================================