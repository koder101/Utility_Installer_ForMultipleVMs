
<p align="right">
User guide and description
</p>
<p><font color="darkblue">
## Utility Installer ForMultipleVMs - A simple PowerShell Script to automate the utility installations on domain joined Virtual Machines.
</font></p>

## Release Notes

[Located at github.com/koder101/Utility_Installer_ForMultipleVMs](https://github.com/koder101/Utility_Installer_ForMultipleVMs/)

## Features

- This utilities can be Installed/UnInstalled silently without user intervention to click the UI.
> See `Important Note` for more details.
- This script is quite generic to support many type of utility installations.
- The same script can also be used to UnInstall the utilities based on config value in the input file.
- The scipt uses two ways to trigger the Installation -  
>    Invoke-Command  
>    PSTools [available here](https://docs.microsoft.com/en-us/sysinternals/downloads/pstools/)


## Quick Start

1. Clone the project to your local.
2. Open and configure the `UtilityLists.csv` file.
> - `SourceFolder`	: The Source machine folder path where individual utility folder will be present. This will contain the utility executable and the corresponding Installer batch file.
> - `TargetFolder`		: The Target machine folder path where each utility folder will be copied.
> - `InstallerBat`		: The name of the Installer batch file of each utility.
> - `InstallerBat`		: The name of the Installer batch file of each utility.
> - `TargetMachineName`	: The domained joined target Machine name.
> - `IsInstall`			: The boolean parameter which determines the install or uninstall of the utility. 1 = Install; 0 = UnInstall.

3. Prepare the individual utility's Installer batch file with Install and UnInstall commands as included in the sample.
4. Set the above prepared input file path and the any output file path.
5. Run the Script.





## Important Note:

1. Preparing the individual utility's silent Installer bat is a separate task.
2. Since different utilities can have their own commands for silent Install or UnInstall, hence it should be identified in advance, though it's a one time activity.
3. For installation of products like MS-Office or SharePoint desiigner, use their XML config files to configure silent installation.
4. Some utility's silent installation works well with `Invoke-Command` and some with `PSTools`. Most of the utilities can be installed via `Invoke-Command`, if not then use the `PSTools`. For this change in the PowerShell script.


## Contributing

Contributions are welcome!

1. Check for open issues or open a fresh issue to start a discussion around a feature idea or a bug.
2. Fork the repository to start making your changes to the master branch (or branch off of it).
3. I recommend to prepare a test which shows that the bug was fixed or that the feature works as expected.
4. Send a pull request and bug the maintainer until it gets merged and published. :smiley:

## Contact

Have some questions? Found a bug? Create [new issue](https://github.com/koder101/Utility_Installer_ForMultipleVMs/issues/new).

## License

This tool is released under the MIT license. See [LICENSE](LICENSE) for details.

