Write-Host "=== Black Console :: Control de Volumen Rapido ===" -ForegroundColor Cyan

$InstallDir = "C:\BlackConsole\bin"
$ExeName = "volume.exe"
$TargetExe = Join-Path $InstallDir $ExeName
$SourceExe = Join-Path $PSScriptRoot $ExeName

# Crear carpeta si no existe
if (-not (Test-Path $InstallDir)) {
    New-Item -ItemType Directory -Path $InstallDir | Out-Null
}

# Copiar exe
if (-not (Test-Path $SourceExe)) {
    Write-Host "ERROR: volume.exe no encontrado" -ForegroundColor Red
    exit 1
}

Copy-Item $SourceExe $TargetExe -Force

# Registro de inicio automático
$RegPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Run"
Set-ItemProperty `
    -Path $RegPath `
    -Name "BlackConsoleVolumeControl" `
    -Value "`"$TargetExe`""

# Lanzar ahora
Start-Process $TargetExe

Write-Host "[OK] Control de volumen rapido instalado y activo." -ForegroundColor Green
