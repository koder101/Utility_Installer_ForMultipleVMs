# Use the correct path for Input and Output files.
$inputfile = 'D:\UtilityLists.csv'
$outputfile = 'D:\Output.csv'

# Creating the header in the output log file.
'TargetMachine,Utility,Status' | Out-File -Append $outputfile -Encoding UTF8


$installdata = Import-csv  $inputfile

Foreach ($inputdata in $installdata)
{
	Write-Host ([Environment]::NewLine + 'Current Machine : ' + $inputdata.TargetMachineName)
	try {
		# Creating the destination path.
		$destinationpath = ('\\' + $inputdata.TargetMachineName + '\' + $inputdata.TargetFolder.Replace(":", "$"))
		
		# Copy the utility folder from Source machine to destination machine.
		If(!(test-path $destinationpath))
			{
			New-Item -ItemType Directory -Force -Path $destinationpath
			$sourcepath = ($inputdata.SourceFolder + '\*')
			Copy-Item -Path $sourcepath -Destination $destinationpath -recurse -Force
			}
			else{
			$sourcepath = ($inputdata.SourceFolder + '\*')
			Copy-Item -Path $sourcepath -Destination $destinationpath -recurse -Force
			}
	}
	catch
	{
		Write-Host ('Failed to copy - ' + $sourcepath)
		Write-Host $_.Exception.Message
		($inputdata.TargetMachineName +',' + $inputdata.InstallerBat + ',Could not Copy') | Out-File -Append $outputfile -Encoding UTF8
		continue
	}
		
		# Identify if its an Install or Un-Install based on the 'IsInstall' parameter of input file i.e. 1 = Install; 0 = UnInstall.
		$installmode = (' ' + $inputdata.IsInstall)
		
		# Creating the Invocation command with respect to target machine.
		$toinstall = ($inputdata.TargetFolder + '\' + $inputdata.InstallerBat + $installmode + ' ' + $inputdata.TargetFolder)
		

	try {
	
		Write-Host ($inputdata.InstallerBat + ' -> In Progress... ')
		
		IF( ! $inputdata.InstallerBat.equals('InstallNPP.bat') )
			{
				# Using the Invoke-Command for triggering the remote batch file.
				Invoke-Command -ComputerName $inputdata.TargetMachineName -ErrorAction Stop -ScriptBlock {Invoke-Expression -Command:"cmd.exe /c '$args'"} -Args $toinstall
			}
		Else
			{	
				# Using the PSTools for triggering the remote batch file.
				.\PSTools\PsExec64.exe ("\\" + $inputdata.TargetMachineName) -accepteula cmd /c $toinstall 2>$null				
			}
			
			# Append the status to the output log.
			($inputdata.TargetMachineName +',' + $inputdata.InstallerBat + ',Success') | Out-File -Append $outputfile -Encoding UTF8
		}
	catch
	{
		Write-Host ('Failed to Execute - ' + $inputdata)
		Write-Host $_.Exception.Message
		($inputdata.TargetMachineName +',' + $inputdata.InstallerBat + ',Failed') | Out-File -Append $outputfile -Encoding UTF8
		continue
	}
}

Read-Host -Prompt "Press Enter to exit"