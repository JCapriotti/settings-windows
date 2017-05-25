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

choco install git -y
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
