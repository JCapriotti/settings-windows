# Ninite stuff
# https://ninite.com/?select=7zip-chrome-evernote-filezilla-foxit-gimp-java8-jdkx8-paint.net-vlc-windirstat-winmerge

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
# choco install visualstudio2015enterprise -y

choco install -y visualstudio2017professional --package-parameters "--add Microsoft.VisualStudio.Workload.ManagedDesktop --add Microsoft.VisualStudio.Workload.NetWeb --add Microsoft.VisualStudio.Workload.NetCoreTools --passive --locale en-US"
choco install -y dotnetcore-sdk

choco install -y git 
choco install -y resharper 
choco install -y NugetPackageExplorer 
choco install -y VirtualCloneDrive 
choco install -y vnc-viewer
choco install -y virtualbox 
choco install -y notepad2 
choco install -y ilspy 
choco install -y sysinternals 

choco install -y Powershell 
choco install -y Cygwin
choco install -y cmder 
choco install -y ant
choco install -y nssm 
choco install -y scriptcs 
choco install -y slickrun 
choco install -y rsat.featurepack 
choco install -y octopusdeploy.tentacle OctopusTools
choco install -y nodejs.install
choco install -y terraform
choco install -y nuget.commandline
choco install -y eCommerce-InstallLegacyDependencies
choco install -y activebatchclient
choco install -y HxD
choco install -y agentransack
choco install -y postman
choco install -y gitlab-runner
choco install -y vault
choco install -y project-journal-gui -s https://proget.directsupply.cloud/nuget/prod/
