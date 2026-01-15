# ==================================================
# DETECTION CORE - BLACK CONSOLE
# ==================================================

function Test-PathSafe {
    param ($Path)
    return ($Path -and (Test-Path $Path))
}

# -------------------------------
# BLACK CONSOLE TOOLS
# -------------------------------

function Test-QuickVolumeInstalled {
    Test-PathSafe "$env:APPDATA\BlackConsole\QuickVolume\volume.exe"
}

function Test-BlackConsoleRadialInstalled {
    Test-PathSafe "$env:USERPROFILE\Documents\Rainmeter\Skins\BlackConsoleRadial"
}

# -------------------------------
# SOFTWARE
# -------------------------------

function Test-ChromeInstalled {
    Test-PathSafe "C:\Program Files\Google\Chrome\Application\chrome.exe"
}

function Test-WinRARInstalled {
    Test-PathSafe "C:\Program Files\WinRAR\WinRAR.exe"
}

function Test-DiscordInstalled {
    Test-PathSafe "$env:LOCALAPPDATA\Discord\Update.exe"
}

function Test-VirtualBoxInstalled {
    Test-PathSafe "C:\Program Files\Oracle\VirtualBox\VirtualBox.exe"
}

function Test-SteamInstalled {
    Test-PathSafe "C:\Program Files (x86)\Steam\Steam.exe"
}

function Test-FirefoxInstalled {
    Test-PathSafe "C:\Program Files\Mozilla Firefox\firefox.exe"
}

function Test-7ZipInstalled {
    Test-PathSafe "C:\Program Files\7-Zip\7z.exe"
}

function Test-NvidiaAppInstalled {
    Test-PathSafe "C:\Program Files\NVIDIA Corporation\NVIDIA App\NVIDIA App.exe"
}

function Test-UltimakerCuraInstalled {
    Test-PathSafe "C:\Program Files\UltiMaker Cura\UltiMaker-Cura.exe"
}
