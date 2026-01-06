# ==================================================
# INSTALLER CORE - BLACK CONSOLE
# ==================================================

# -------------------------------
# DETECCION ROBUSTA
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

function Test-PathProgram {
    param ([string[]]$Paths)

    foreach ($p in $Paths) {
        if (Test-Path $p) {
            return $true
        }
    }
    return $false
}

function Is-ProgramInstalled {
    param (
        [string]$Name,
        [string[]]$Paths = @()
    )

    if (Test-RegistryProgram $Name) {
        return $true
    }

    if ($Paths.Count -gt 0 -and (Test-PathProgram $Paths)) {
        return $true
    }

    return $false
}

# -------------------------------
# UTILIDADES
# -------------------------------

function Download-File {
    param (
        [string]$Url,
        [string]$OutFile
    )

    Write-Host "[*] Descargando $Url"
    Invoke-WebRequest $Url -OutFile $OutFile -UseBasicParsing
}

function Write-Info  { param($m) Write-Host "[*] $m" -ForegroundColor Cyan }
function Write-Ok    { param($m) Write-Host "[OK] $m" -ForegroundColor Green }
function Write-Skip  { param($m) Write-Host "[SKIP] $m" -ForegroundColor Yellow }

# -------------------------------
# INSTALADORES
# -------------------------------

function Install-Chrome {

    if (Is-ProgramInstalled "Google Chrome" @(
        "$env:ProgramFiles\Google\Chrome\Application\chrome.exe",
        "$env:ProgramFiles(x86)\Google\Chrome\Application\chrome.exe"
    )) {
        Write-Skip "Google Chrome ya esta instalado."
        return
    }

    Write-Info "Instalando Google Chrome..."

    $url = "https://www.google.com/chrome/?standalone=1"
    $tmp = "$env:TEMP\chrome_installer.exe"

    Download-File $url $tmp
    Start-Process $tmp -ArgumentList "/silent /install" -Wait

    Write-Ok "Google Chrome instalado."
}

function Install-WinRAR {

    if (Is-ProgramInstalled "WinRAR" @(
        "$env:ProgramFiles\WinRAR\WinRAR.exe",
        "$env:ProgramFiles(x86)\WinRAR\WinRAR.exe"
    )) {
        Write-Skip "WinRAR ya esta instalado."
        return
    }

    Write-Info "Instalando WinRAR..."

    $url = "https://www.rarlab.com/rar/winrar-x64-621.exe"
    $tmp = "$env:TEMP\winrar_installer.exe"

    Download-File $url $tmp
    Start-Process $tmp -ArgumentList "/S" -Wait

    Write-Ok "WinRAR instalado."
}

function Install-Discord {

    if (Is-ProgramInstalled "Discord" @(
        "$env:LOCALAPPDATA\Discord\Update.exe"
    )) {
        Write-Skip "Discord ya esta instalado."
        return
    }

    Write-Info "Instalando Discord..."

    $url = "https://discord.com/api/download?platform=win"
    $tmp = "$env:TEMP\discord_installer.exe"

    Download-File $url $tmp
    Start-Process $tmp -Wait

    Write-Ok "Discord instalado."
}

function Install-VirtualBox {

    if (
        Is-ProgramInstalled "Oracle VM VirtualBox" @(
            "$env:ProgramFiles\Oracle\VirtualBox\VirtualBox.exe"
        )
        -or (Get-Service -Name "VBox*" -ErrorAction SilentlyContinue)
    ) {
        Write-Skip "VirtualBox ya esta instalado."
        return
    }

    Write-Info "Instalando VirtualBox..."

    $url = "https://download.virtualbox.org/virtualbox/7.1.4/VirtualBox-7.1.4-165100-Win.exe"
    $tmp = "$env:TEMP\virtualbox_installer.exe"

    Download-File $url $tmp
    Start-Process $tmp -ArgumentList "--silent" -Wait

    Write-Ok "VirtualBox instalado."
}
