# ==================================================
# DETECTION CORE - BLACK CONSOLE
# ==================================================

# Utilidad comun
function Test-PathSafe {
    param ($Path)
    return ($Path -and (Test-Path $Path))
}

# --------------------------------------------------
# GOOGLE CHROME
# --------------------------------------------------
function Test-ChromeInstalled {
    return Test-PathSafe "C:\Program Files\Google\Chrome\Application\chrome.exe"
}

# --------------------------------------------------
# WINRAR
# --------------------------------------------------
function Test-WinRARInstalled {
    return Test-PathSafe "C:\Program Files\WinRAR\WinRAR.exe"
}

# --------------------------------------------------
# DISCORD
# --------------------------------------------------
function Test-DiscordInstalled {

    $paths = @(
        "$env:LOCALAPPDATA\Discord\Update.exe",
        "$env:APPDATA\Discord\Update.exe"
    )

    foreach ($p in $paths) {
        if (Test-PathSafe $p) { return $true }
    }

    return $false
}

# --------------------------------------------------
# VIRTUALBOX
# --------------------------------------------------
function Test-VirtualBoxInstalled {
    return Test-PathSafe "C:\Program Files\Oracle\VirtualBox\VirtualBox.exe"
}

# --------------------------------------------------
# STEAM
# --------------------------------------------------
function Test-SteamInstalled {
    return Test-PathSafe "C:\Program Files (x86)\Steam\Steam.exe"
}

# --------------------------------------------------
# FIREFOX
# --------------------------------------------------
function Test-FirefoxInstalled {
    return Test-PathSafe "C:\Program Files\Mozilla Firefox\firefox.exe"
}

# --------------------------------------------------
# 7-ZIP
# --------------------------------------------------
function Test-7ZipInstalled {
    return Test-PathSafe "C:\Program Files\7-Zip\7z.exe"
}

# --------------------------------------------------
# NVIDIA APP
# --------------------------------------------------
function Test-NvidiaAppInstalled {

    $paths = @(
        "C:\Program Files\NVIDIA Corporation\NVIDIA App\NVIDIA App.exe",
        "C:\Program Files\NVIDIA Corporation\NVIDIA GeForce Experience\NVIDIA GeForce Experience.exe"
    )

    foreach ($p in $paths) {
        if (Test-PathSafe $p) { return $true }
    }

    return $false
}

# --------------------------------------------------
# ULTIMAKER CURA
# --------------------------------------------------
function Test-UltimakerCuraInstalled {

    $paths = @(
        "C:\Program Files\UltiMaker Cura\UltiMaker-Cura.exe",
        "C:\Program Files\Ultimaker Cura\Cura.exe"
    )

    foreach ($p in $paths) {
        if (Test-PathSafe $p) { return $true }
    }

    return $false
}
