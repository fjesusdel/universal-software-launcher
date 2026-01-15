# ==================================================
# INSTALLER CORE - BLACK CONSOLE
# ==================================================

# Utilidades visuales
function Write-Info  { param($m) Write-Host "[*] $m" -ForegroundColor Cyan }
function Write-Ok    { param($m) Write-Host "[OK] $m" -ForegroundColor Green }
function Write-Skip  { param($m) Write-Host "[SKIP] $m" -ForegroundColor Yellow }

# -------------------------------
# DESCARGA
# -------------------------------

function Download-File {
    param (
        [string]$Url,
        [string]$OutFile
    )

    Write-Info "Descargando $Url"
    Invoke-WebRequest $Url -OutFile $OutFile -UseBasicParsing
}

# -------------------------------
# INSTALADORES
# -------------------------------

function Install-Chrome {

    if (Test-ChromeInstalled) {
        Write-Skip "Google Chrome ya esta instalado."
        return
    }

    Write-Info "Instalando Google Chrome..."
    $tmp = "$env:TEMP\chrome_installer.exe"
    Download-File "https://www.google.com/chrome/?standalone=1" $tmp
    Start-Process $tmp -ArgumentList "/silent /install" -Wait
    Write-Ok "Google Chrome instalado."
}

function Install-WinRAR {

    if (Test-WinRARInstalled) {
        Write-Skip "WinRAR ya esta instalado."
        return
    }

    Write-Info "Instalando WinRAR..."
    $tmp = "$env:TEMP\winrar_installer.exe"
    Download-File "https://www.rarlab.com/rar/winrar-x64-621.exe" $tmp
    Start-Process $tmp -ArgumentList "/S" -Wait
    Write-Ok "WinRAR instalado."
}

function Install-Discord {

    if (Test-DiscordInstalled) {
        Write-Skip "Discord ya esta instalado."
        return
    }

    Write-Info "Instalando Discord..."
    $tmp = "$env:TEMP\discord_installer.exe"
    Download-File "https://discord.com/api/download?platform=win" $tmp
    Start-Process $tmp -Wait
    Write-Ok "Discord instalado."
}

function Install-VirtualBox {

    if (Test-VirtualBoxInstalled) {
        Write-Skip "VirtualBox ya esta instalado."
        return
    }

    Write-Info "Instalando VirtualBox..."
    $tmp = "$env:TEMP\virtualbox_installer.exe"
    Download-File "https://download.virtualbox.org/virtualbox/7.1.4/VirtualBox-7.1.4-165100-Win.exe" $tmp
    Start-Process $tmp -ArgumentList "--silent" -Wait
    Write-Ok "VirtualBox instalado."
}

function Install-Steam {

    if (Test-SteamInstalled) {
        Write-Skip "Steam ya esta instalado."
        return
    }

    Write-Info "Instalando Steam..."
    $tmp = "$env:TEMP\steam_installer.exe"
    Download-File "https://cdn.akamai.steamstatic.com/client/installer/SteamSetup.exe" $tmp
    Start-Process $tmp -ArgumentList "/S" -Wait
    Write-Ok "Steam instalado."
}

function Install-Firefox {

    if (Test-FirefoxInstalled) {
        Write-Skip "Mozilla Firefox ya esta instalado."
        return
    }

    Write-Info "Instalando Mozilla Firefox..."
    $tmp = "$env:TEMP\firefox_installer.exe"
    Download-File "https://download.mozilla.org/?product=firefox-latest&os=win64&lang=es-ES" $tmp
    Start-Process $tmp -ArgumentList "-ms" -Wait
    Write-Ok "Firefox instalado."
}

function Install-7Zip {

    if (Test-7ZipInstalled) {
        Write-Skip "7-Zip ya esta instalado."
        return
    }

    Write-Info "Instalando 7-Zip..."
    $tmp = "$env:TEMP\7zip_installer.exe"
    Download-File "https://www.7-zip.org/a/7z2301-x64.exe" $tmp
    Start-Process $tmp -ArgumentList "/S" -Wait
    Write-Ok "7-Zip instalado."
}

function Install-NvidiaApp {

    if (Test-NvidiaAppInstalled) {
        Write-Skip "NVIDIA App ya esta instalada."
        return
    }

    Write-Info "Instalando NVIDIA App..."
    $tmp = "$env:TEMP\nvidia_installer.exe"
    Download-File "https://us.download.nvidia.com/nvapp/client/10.0.0.535/NVIDIA_app_v10.0.0.535.exe" $tmp
    Start-Process $tmp -ArgumentList "/S" -Wait
    Write-Ok "NVIDIA App instalada."
}

function Install-UltimakerCura {

    if (Test-UltimakerCuraInstalled) {
        Write-Skip "Ultimaker Cura ya esta instalado."
        return
    }

    Write-Info "Instalando Ultimaker Cura..."
    $tmp = "$env:TEMP\cura_installer.exe"
    Download-File "https://github.com/Ultimaker/Cura/releases/latest/download/UltiMaker-Cura-Windows.exe" $tmp
    Start-Process $tmp -ArgumentList "/S" -Wait
    Write-Ok "Ultimaker Cura instalado."
}
