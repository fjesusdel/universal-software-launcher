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

    $url = "https://www.google.com/chrome/?standalone
