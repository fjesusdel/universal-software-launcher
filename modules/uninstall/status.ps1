function Test-AppInstalledByName($Pattern) {

    $Keys = @(
        "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall",
        "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall"
    )

    foreach ($key in $Keys) {
        Get-ChildItem $key -ErrorAction SilentlyContinue | ForEach-Object {
            $app = Get-ItemProperty $_.PSPath -ErrorAction SilentlyContinue
            if ($app.DisplayName -and $app.DisplayName -like $Pattern) {
                return $true
            }
        }
    }
    return $false
}

function Test-SteamInstalled {
    Test-AppInstalledByName "*Steam*"
}

function Test-RadialInstalled {
    Test-Path "$env:USERPROFILE\Documents\Rainmeter\Skins\BlackConsole"
}

function Test-VolumeInstalled {
    Test-Path "C:\BlackConsole\bin\volume.exe"
}

function Get-StatusLabel($Installed) {
    if ($Installed) { "[INSTALADO]" } else { "[NO INSTALADO]" }
}
