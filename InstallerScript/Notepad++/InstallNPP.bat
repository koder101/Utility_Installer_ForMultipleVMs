@echo off
set install=%1
if %install% equ 1 (
	%2\npp.7.5.1.Installer.exe /S
	@echo NPP installed successfully
) else (
	"%ProgramFiles(x86)%\Notepad++\uninstall.exe" /S
	@echo NPP uninstalled successfully
)
