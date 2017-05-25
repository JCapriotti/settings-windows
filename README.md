
Running Manually (using Boxstarter without automation)

    Import-Module Boxstarter.Chocolatey
    git clone https://github.com/JCapriotti/settings-windows c:\git\settings-windows
    New-PackageFromScript c:\git\settings-windows\boxstarter\settings-work.ps1 settings-work
    Install-BoxstarterPackage -PackageName settings-work
    