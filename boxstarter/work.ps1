# Ninite stuff
# https://ninite.com/?select=7zip-chrome-evernote-filezilla-foxit-gimp-java8-jdkx8-paint.net-realvnc-vlc-vscode-windirstat-winmerge

# Boxstarter URL
# http://boxstarter.org/package/nr/url?

# Choco / Boxstarter config
Set-BoxstarterConfig -NugetSources "http://choco.directs.com/nuget;http://chocolatey.org/api/v2;http://www.myget.org/F/boxstarter/api/v2"
choco sources add -name NuGet -source https://nuget.org/api/v2/
choco sources add -name DS -source http://choco.directs.com/nuget

Disable-UAC 
Set-WindowsExplorerOptions -EnableShowHiddenFilesFoldersDrives -EnableShowProtectedOSFiles -EnableShowFileExtensions -EnableShowFullPathInTitleBar

# Main Install
choco install visualstudiocode -y
choco install SQLServer2014-Developer -y --allow-empty-checksums

# This doesn't work
# choco install Sql2014.TcpAndAliases -y --allow-empty-checksums

# Figure out install args
#-InstallArguments "/Features:WebTools" 
choco install visualstudio2015enterprise -y

choco install resharper -y
choco install NugetPackageExplorer -y
choco install VirtualCloneDrive -y
choco install virtualbox -y
choco install notepad2 -y
choco install ilspy -y
choco install sysinternals -y
choco install Powershell -y
choco install cmder -y
choco install nssm -y
choco install scriptcs -y
choco install slickrun -y
choco install rsat.featurepack -y
choco install octopusdeploy.tentacle -y
choco install OctopusTools -y
choco install nodejs.install -y

# Copy backup directory
Copy-Item \\ds\home\jasonc\Backup\* C:\ -Force -Recurse

# Create scheduled tasks
$taskDir = "C:\Utility\ScheduledTasks"
schtasks /create /xml "$taskDir\Backup.xml" /tn "Backup Files"
schtasks /create /xml "$taskDir\LogStuff.xml" /tn "Log Stuff"

# Text file associations
$textEditor = "$env:programfiles\Notepad2\Notepad2.exe"
Install-ChocolateyFileAssociation ".txt" $textEditor
Install-ChocolateyFileAssociation ".xml" $textEditor
Install-ChocolateyFileAssociation ".nuspec" $textEditor
Install-ChocolateyFileAssociation ".config" $textEditor

# Fix missing "New Text Document" in Explorer context menu (https://github.com/chocolatey/chocolatey/issues/563)
reg add HKCR\.txt /ve /f /d txtfile

# VS Extensions
Install-ChocolateyVsixPackage "SpecFlow for 2015" https://visualstudiogallery.msdn.microsoft.com/c74211e7-cb6e-4dfa-855d-df0ad4a37dd6/file/160542/7/TechTalk.SpecFlow.Vs2015Integration.v2015.1.2.vsix
Install-ChocolateyVsixPackage "Productivity Power Tools (2015)" https://visualstudiogallery.msdn.microsoft.com/34ebc6a2-2777-421d-8914-e29c1dfa7f5d/file/169971/3/ProPowerTools.vsix

# Taskbar pins
Install-ChocolateyPinnedTaskBarItem "$env:programfiles\Internet Explorer\iexplore.exe"
Install-ChocolateyPinnedTaskBarItem "$($Boxstarter.programFiles86)\Google\Chrome\Application\chrome.exe"
Install-ChocolateyPinnedTaskBarItem "$env:windir\explorer.exe"
# Install-ChocolateyPinnedTaskBarItem "$($Boxstarter.programFiles86)\Microsoft Visual Studio 12.0\Common7\IDE\devenv.exe"
Install-ChocolateyPinnedTaskBarItem "$($Boxstarter.programFiles86)\Evernote\Evernote\evernote.exe"
Install-ChocolateyPinnedTaskBarItem "$env:windir\system32\SnippingTool.exe"
Install-ChocolateyPinnedTaskBarItem "$env:programfiles\Oracle\VirtualBox\VirtualBox.exe"
Install-ChocolateyPinnedTaskBarItem "$env:ChocolateyInstall\bin\ILSpy.exe"
Install-ChocolateyPinnedTaskBarItem "$env:programfiles\GIMP 2\bin\gimp-2.8.exe"
Install-ChocolateyPinnedTaskBarItem "$env:windir\system32\inetsrv\InetMgr.exe"

# Set up Springfield DNS
netsh interface ipv4 add dnsserver "Local Area Connection" address=172.25.106.19 index=1
netsh interface ipv4 add dnsserver "Local Area Connection" address=10.0.128.1 index=2
netsh interface ipv4 add dnsserver "Local Area Connection" address=10.0.128.2 index=3
netsh interface ipv4 add dnsserver "Local Area Connection" address=10.0.128.3 index=4
netsh interface ipv4 add dnsserver "Local Area Connection" address=10.0.128.4 index=5
reg add HKLM\System\currentcontrolset\services\tcpip\parameters /v SearchList /d springfield.local,mtolympus.partners.directs.com,partners.directs.com,directs.com /f

# Disable offline files
sc config CscService start= disabled

# Create startup command; link to file pulled down from backup.
New-Item -Path "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Startup" -Name "jason-startup.cmd" -ItemType "File" -Value "@powershell -NoProfile -ExecutionPolicy unrestricted -Command `"C:\Utility\Tools\startup.ps1`""

# Enable Active Directory tools 
dism /online /enable-feature /featurename:RemoteServerAdministrationTools /featurename:RemoteServerAdministrationTools-Roles /featurename:RemoteServerAdministrationTools-Roles-AD /featurename:RemoteServerAdministrationTools-Roles-AD-DS /featurename:RemoteServerAdministrationTools-Roles-AD-DS-SnapIns /featurename:RemoteServerAdministrationTools-Roles-AD-Powershell /featurename:RemoteServerAdministrationTools-Roles-AD-DS-AdministrativeCenter 

# Other Windows Features
dism /online /enable-feature /featurename:IIS-WindowsAuthentication

# Loopback thing...
reg add HKLM\System\CurrentControlSet\services\LanmanServer\Parameters /v DisableStrictNameChecking /t REG_DWORD /d 1
reg add HKLM\System\CurrentControlSet\Control\Lsa\MSV1_0 /v BackConnectionHostNames /t REG_MULTI_SZ /d springfield.localhost

# Set Chrome as default browser
"C:\Program Files (x86)\Google\Chrome\Application\chrome.exe" --make-default-browser --no-default-browser-check

 # Create and grant access to Fake Mail Queue
 $path = "C:\inetpub\Fake Mail Queue"
 New-Item $path -Type directory  -ErrorAction SilentlyContinue
 $grant = "/grant:r"
 $userAccount1 = "MTOLYMPUS\DSSIWebD_BlueLabel"
 $userAccount2 = "MTOLYMPUS\DSSIWebD_BluLblAdmin"
 $permission = ":(OI)(CI)(M,RD)"
 $rule1 = "$userAccount1$permission"
 $rule2 = "$userAccount2$permission"
 Invoke-Expression -Command ('icacls $path $grant $rule1 $grant $rule2')
 