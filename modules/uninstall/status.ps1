function Test-AppInstalledByName {
    param (
        [string]$Pattern
    )

    $Keys = @(
        "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall",
        "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall",
        "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall"
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

function Test-DiscordInstalled {

    # Metodo 1: registro (por si existe)
    if (Test-AppInstalledByName "*Discord*") {
        return $true
    }

    # Metodo 2: instalacion por usuario (real)
    $discordPath = Join-Path $env:LOCALAPPDATA "Discord\Update.exe"
    if (Test-Path $discordPath) {
        return $true
    }

    return $false
}

function Test-RadialInstalled {
    Test-Path "$env:USERPROFILE\Documents\Rainmeter\Skins\BlackConsole"
}

function Test-VolumeInstalled {
    Test-Path "C:\BlackConsole\bin\volume.exe"
}

function Get-StatusLabel {
    param ($Installed)
    if ($Installed) { "[INSTALADO]" } else { "[NO INSTALADO]" }
}
