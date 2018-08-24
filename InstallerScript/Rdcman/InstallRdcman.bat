@echo off
set install=%1
if %install% equ 1 (
	msiexec /i %2\rdcman.msi /quiet /norestart
	echo rdcman installed successfully
) else (
	msiexec /uninstall %2\rdcman.msi /quiet /norestart
	echo rdcman uninstalled successfully
)
