
# Deletes settings files, and recreates them as hard links to those in the Git repo

$files = @(
    @{
        source="code\settings.json";
        dest="$env:USERPROFILE\AppData\Roaming\Code\User\settings.json"
    }, @{
        source="cmder\ConEmu.xml";
        dest="$env:ChocolateyToolsLocation\cmder\vendor\conemu-maximus5\ConEmu.xml"
    }, @{
        source="cmder\user-profile.ps1";
        dest="$env:ChocolateyToolsLocation\cmder\config\user-profile.ps1"
    }
)

foreach ($f in $files) {
    Remove-Item $f.dest -ErrorAction SilentlyContinue
    cmd /c mklink /H $($f.dest) $env:JCAP_CONFIG\linked-config\$($f.source)
}
