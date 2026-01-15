# ==================================================
# DETECCION CENTRALIZADA - BLACK CONSOLE
# ==================================================

# -------------------------------
# DETECCION POR REGISTRO
# -------------------------------

function Test-RegistryProgram {
    param ([string]$Name)

    $paths = @(
        "HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*",
        "HKLM:\Software\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*",
        "HKCU:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*"
    )

    foreach ($path in $paths) {
        try {
            if (Get-ItemProperty $path -ErrorAction SilentlyContinue |
                Where-Object { $_.DisplayName -like "*$Name*" }) {
                return $true
            }
        } catch {}
    }
    return $false
}

# -------------------------------
# DETECCION POR RUTA
# -------------------------------

function Test-PathProgram {
    param ([string[]]$Paths)

    foreach ($p in $Paths) {
        if (Test-Path $p) {
            return $true
        }
    }
    return $false
}

# -------------------------------
# APPS CLASICAS
# -------------------------------

function Test-ChromeInstalled {
    Test-RegistryProgram "Google Chrome" -or
    Test-PathProgram @(
        "$env:ProgramFiles\Google\Chrome\Application\chrome.exe",
        "$env:ProgramFiles(x86)\Google\Chrome\Application\chrome.exe"
    )
}

function Test-WinRARInstalled {
    Test-RegistryProgram "WinRAR" -or
    Test-PathProgram @(
        "$env:ProgramFiles\WinRAR\WinRAR.exe",
        "$env:ProgramFiles(x86)\WinRAR\WinRAR.exe"
    )
}

function Test-FirefoxInstalled {
    Test-RegistryProgram "Mozilla Firefox"
}

function Test-7ZipInstalled {
    Test-RegistryProgram "7-Zip"
}

function Test-NvidiaAppInstalled {
    Test-RegistryProgram "NVIDIA App"
}

function Test-UltimakerCuraInstalled {
    Test-RegistryProgram "Ultimaker Cura"
}

# -------------------------------
# DISCORD (INSTALACION POR USUARIO)
# -------------------------------

function Test-DiscordInstalled {

    if (Test-RegistryProgram "Discord") {
        return $true
    }

    $discordPath = Join-Path $env:LOCALAPPDATA "Discord\Update.exe"
    if (Test-Path $discordPath) {
        return $true
    }

    return $false
}

# -------------------------------
# STEAM
# -------------------------------

function Test-SteamInstalled {
    Test-RegistryProgram "Steam" -or
    Test-PathProgram @(
        "$env:ProgramFiles(x86)\Steam\Steam.exe",
        "$env:ProgramFiles\Steam\Steam.exe"
    )
}

# -------------------------------
# VIRTUALBOX (SERVICIOS + REGISTRO)
# -------------------------------

function Test-VirtualBoxInstalled {

    if (Test-RegistryProgram "Oracle VM VirtualBox") {
        return $true
    }

    if (Get-Service -Name "VBox*" -ErrorAction SilentlyContinue) {
        return $true
    }

    return $false
}

# -------------------------------
# HERRAMIENTAS BLACK CONSOLE
# -------------------------------

function Test-RadialInstalled {
    Test-Path "$env:USERPROFILE\Documents\Rainmeter\Skins\BlackConsole"
}

function Test-VolumeInstalled {
    Test-Path "C:\BlackConsole\bin\volume.exe"
}

# -------------------------------
# UTILIDAD VISUAL
# -------------------------------

function Get-StatusLabel {
    param ($Installed)
    if ($Installed) { "[INSTALADO]" } else { "[NO INSTALADO]" }
}
