
# Deletes settings files, and recreates them as hard links to those in the Git repo

$files = @(
    @{
        name="settings.json";
        source=".\code";
        dest="$env:USERPROFILE\AppData\Roaming\Code\User"
    }, @{
        name="ConEmu.xml";
        source=".\cmder";
        dest="$env:ChocolateyToolsLocation\cmder\vendor\conemu-maximus5"
    }, @{
        name="user-profile.ps1";
        source=".\cmder";
        dest="$env:ChocolateyToolsLocation\cmder\config"
    }, @{
        name="dataSources.local.xml";
        source=".\DataGrip";
        dest="$env:USERPROFILE\.DataGrip2017.2\config\options"
    }, @{
        name="dataSources.xml";
        source=".\DataGrip";
        dest="$env:USERPROFILE\.DataGrip2017.2\config\options"
    }
)

foreach ($f in $files) {
    $source = Join-Path "$env:JCAP_CONFIG\linked-config" $f.source | Join-Path -ChildPath $f.name
    $destination = Join-Path $f.dest $f.name

    Remove-Item $destination -ErrorAction SilentlyContinue
    cmd /c mklink /H $($destination) $($source)
}
