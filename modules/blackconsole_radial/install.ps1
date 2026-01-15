Write-Host "=== Black Console :: BlackConsoleRadial Installer ===" -ForegroundColor Cyan

# -------------------------------
# Variables
# -------------------------------
$RainmeterExe64 = "$env:ProgramFiles\Rainmeter\Rainmeter.exe"
$RainmeterExe32 = "$env:ProgramFiles(x86)\Rainmeter\Rainmeter.exe"

$ModuleRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$SkinPackage = Join-Path $ModuleRoot "BlackConsoleRadial.rmskin"

$RainmeterDownload = "https://www.rainmeter.net/releases/Rainmeter-4.5.18.exe"
$TempInstaller = "$env:TEMP\RainmeterInstaller.exe"

# -------------------------------
# Detect Rainmeter
# -------------------------------
$RainmeterExe = $null

if (Test-Path $RainmeterExe64) {
    $RainmeterExe = $RainmeterExe64
}
elseif (Test-Path $RainmeterExe32) {
    $RainmeterExe = $RainmeterExe32
}

# -------------------------------
# Install Rainmeter if missing
# -------------------------------
if (-not $RainmeterExe) {
    Write-Host "[INFO] Rainmeter no encontrado. Instalando..." -ForegroundColor Yellow

    try {
        Invoke-WebRequest -Uri $RainmeterDownload -OutFile $TempInstaller -UseBasicParsing
        Start-Process $TempInstaller -ArgumentList "/S" -Wait
        Start-Sleep -Seconds 2
    }
    catch {
        Write-Host "[ERROR] No se pudo descargar o instalar Rainmeter." -ForegroundColor Red
        exit 1
    }

    if (Test-Path $RainmeterExe64) {
        $RainmeterExe = $RainmeterExe64
    }
    elseif (Test-Path $RainmeterExe32) {
        $RainmeterExe = $RainmeterExe32
    }
    else {
        Write-Host "[ERROR] Rainmeter no se instaló correctamente." -ForegroundColor Red
        exit 1
    }

    Write-Host "[OK] Rainmeter instalado." -ForegroundColor Green
}
else {
    Write-Host "[OK] Rainmeter ya estaba instalado." -ForegroundColor Green
}

# -------------------------------
# Start Rainmeter (if not running)
# -------------------------------
$RainmeterProcess = Get-Process Rainmeter -ErrorAction SilentlyContinue
if (-not $RainmeterProcess) {
    Start-Process $RainmeterExe
    Start-Sleep -Seconds 2
}

# -------------------------------
# Install skin
# -------------------------------
if (-not (Test-Path $SkinPackage)) {
    Write-Host "[ERROR] No se encuentra BlackConsoleRadial.rmskin" -ForegroundColor Red
    exit 1
}

Write-Host "[INFO] Instalando skin BlackConsoleRadial..." -ForegroundColor Yellow
Start-Process $SkinPackage
Start-Sleep -Seconds 3

# -------------------------------
# Activate skin automatically
# -------------------------------
Write-Host "[INFO] Activando skin..." -ForegroundColor Yellow

& $RainmeterExe `
    !ActivateConfig "BlackConsole\Radial" "Radial.ini"

Write-Host "[OK] BlackConsoleRadial instalado y activo." -ForegroundColor Green
Write-Host "=== Instalación completada ===" -ForegroundColor Cyan
