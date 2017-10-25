
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

# VS Code
code --install-extension ms-vscode.powershell
code --install-extension DavidAnson.vscode-markdownlint

# Taskbar pins
Install-ChocolateyPinnedTaskBarItem "$env:programfiles\Internet Explorer\iexplore.exe"
Install-ChocolateyPinnedTaskBarItem "${env:ProgramFiles(x86)}\Google\Chrome\Application\chrome.exe"
Install-ChocolateyPinnedTaskBarItem "${env:ProgramFiles(x86)}\Microsoft Visual Studio 12.0\Common7\IDE\devenv.exe"
Install-ChocolateyPinnedTaskBarItem "${env:ProgramFiles(x86)}\Microsoft VS Code\Code.exe"
Install-ChocolateyPinnedTaskBarItem "C:\tools\cmder\Cmder.exe"
Install-ChocolateyPinnedTaskBarItem "${env:ProgramFiles(x86)}\Evernote\Evernote\evernote.exe"
Install-ChocolateyPinnedTaskBarItem "$env:programfiles\Oracle\VirtualBox\VirtualBox.exe"
Install-ChocolateyPinnedTaskBarItem "$env:ChocolateyInstall\bin\ILSpy.exe"
Install-ChocolateyPinnedTaskBarItem "$env:programfiles\GIMP 2\bin\gimp-2.8.exe"
Install-ChocolateyPinnedTaskBarItem "$env:windir\system32\inetsrv\InetMgr.exe"

# Set up Springfield DNS
CMD /C netsh interface ipv4 add dnsserver "Local Area Connection" address=172.25.106.19 index=1
CMD /C netsh interface ipv4 add dnsserver "Local Area Connection" address=10.0.128.1 index=2
CMD /C netsh interface ipv4 add dnsserver "Local Area Connection" address=10.0.128.2 index=3
CMD /C netsh interface ipv4 add dnsserver "Local Area Connection" address=10.0.128.3 index=4
CMD /C netsh interface ipv4 add dnsserver "Local Area Connection" address=10.0.128.4 index=5
reg add HKLM\System\currentcontrolset\services\tcpip\parameters /v SearchList /d springfield.local,mtolympus.partners.directs.com,partners.directs.com,directs.com /f

# Disable offline files
CMD /C sc config CscService start= disabled

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
&"C:\Program Files (x86)\Google\Chrome\Application\chrome.exe" --make-default-browser --no-default-browser-check

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

# Git repo stuff
setx GITLAB_HOME "C:\git"
git config --global

# Enable SQL Server Browser to get TCP alias to work
CMD /C sc config SQLBrowser start= auto
CMD /C sc start SQLBrowser 

# SQL Alias needed is:
#  - Alias = LocalSQL
#  - Port = <blank>
#  - Server = .\MSSQL2014X64    (depending on instance naming)
#  - Protocol = tcp
