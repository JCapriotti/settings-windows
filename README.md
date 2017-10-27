windows-settings
================

Maintains my Windows settings and installation scripts.

Details
-------

### Machine Setup

Machine setup scripts are in the `boxstarter` directory.

### Setting Files

Setting files are intended to be used as hard link targets. Links are set up in `utility\make-links.ps1`

Usage
-----

Running Manually (using Boxstarter without automation)

    setx JCAP_CONFIG "C:\config"
    Import-Module Boxstarter.Chocolatey
    git clone https://github.com/JCapriotti/settings-windows c:\config
    New-PackageFromScript c:\git\settings-windows\boxstarter\settings-work.ps1 settings-work
    Install-BoxstarterPackage -PackageName settings-work
