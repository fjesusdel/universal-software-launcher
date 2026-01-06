# ==================================================
# MANUAL INSTALLERS - BLACK CONSOLE
# ==================================================

function Install-Steam {

    if (Is-ProgramInstalled "Steam") {
        Write-Skip "Steam ya esta instalado."
        return
    }

    Write-Info "Instalando Steam..."

    $url = "https://cdn.akamai.steamstatic.com/client/installer/SteamSetup.exe"
    $installer = "$env:TEMP\steam_installer.exe"

    Download-File $url $installer
    Start-Process $installer -ArgumentList "/S" -Wait

    Write-Ok "Steam instalado."
}

function Install-Firefox {

    if (Is-ProgramInstalled "Mozilla Firefox") {
        Write-Skip "Mozilla Firefox ya esta instalado."
        return
    }

    Write-Info "Instalando Mozilla Firefox..."

    $url = "https://download.mozilla.org/?product=firefox-latest&os=win64&lang=es-ES"
    $installer = "$env:TEMP\firefox_installer.exe"

    Download-File $url $installer
    Start-Process $installer -ArgumentList "/S" -Wait

    Write-Ok "Mozilla Firefox instalado."
}

function Install-7Zip {

    if (Is-ProgramInstalled "7-Zip") {
        Write-Skip "7-Zip ya esta instalado."
        return
    }

    Write-Info "Instalando 7-Zip..."

    $url = "https://www.7-zip.org/a/7z2301-x64.exe"
    $installer = "$env:TEMP\7zip_installer.exe"

    Download-File $url $installer
    Start-Process $installer -ArgumentList "/S" -Wait

    Write-Ok "7-Zip instalado."
}

function Install-NvidiaApp {

    if (-not (Get-Command Has-NvidiaGPU -ErrorAction SilentlyContinue)) {
        Write-Skip "Deteccion NVIDIA no disponible. Omitiendo NVIDIA App."
        return
    }

    if (-not (Has-NvidiaGPU)) {
        Write-Skip "No se ha detectado GPU NVIDIA."
        return
    }

    if (Is-ProgramInstalled "NVIDIA App") {
        Write-Skip "NVIDIA App ya esta instalada."
        return
    }

    Write-Info "Instalando NVIDIA App..."

    $url = "https://us.download.nvidia.com/nvapp/client/NVIDIA_app_v1.0.exe"
    $installer = "$env:TEMP\nvidia_app.exe"

    Download-File $url $installer
    Start-Process $installer -ArgumentList "/S" -Wait

    Write-Ok "NVIDIA App instalada."
}

function Install-UltimakerCura {

    if (Is-ProgramInstalled "Ultimaker Cura") {
        Write-Skip "Ultimaker Cura ya esta instalado."
        return
    }

    Write-Info "Instalando Ultimaker Cura..."

    $url = "https://github.com/Ultimaker/Cura/releases/latest/download/Ultimaker-Cura-Windows-X64.exe"
    $installer = "$env:TEMP\cura_installer.exe"

    Download-File $url $installer
    Start-Process $installer -ArgumentList "/S" -Wait

    Write-Ok "Ultimaker Cura instalado."
}
