# ==================================================
# BOOTSTRAP BLACK CONSOLE
# - Solicita permisos de administrador
# - Descarga el repositorio
# - Ejecuta el launcher
# ==================================================

$ErrorActionPreference = "Stop"

# ------------------------------
# COMPROBAR ADMIN
# ------------------------------
$IsAdmin = ([Security.Principal.WindowsPrincipal] `
    [Security.Principal.WindowsIdentity]::GetCurrent()
).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

if (-not $IsAdmin) {
    Write-Host "[!] Se requieren permisos de administrador. Solicitando UAC..."

    Start-Process powershell `
        -Verb RunAs `
        -ArgumentList "-ExecutionPolicy Bypass -Command `"irm https://raw.githubusercontent.com/fjesusdel/universal-software-launcher/main/bootstrap.ps1 | iex`""

    exit
}

# ------------------------------
# DESCARGA DEL REPO
# ------------------------------
$RepoUrl = "https://github.com/fjesusdel/universal-software-launcher/archive/refs/heads/main.zip"
$BaseDir = Join-Path $env:TEMP "universal-launcher"
$ZipPath = "$BaseDir.zip"

Write-Host "[*] Descargando Black Console..."

if (Test-Path $BaseDir) {
    Remove-Item $BaseDir -Recurse -Force
}
if (Test-Path $ZipPath) {
    Remove-Item $ZipPath -Force
}

Invoke-WebRequest -Uri $RepoUrl -OutFile $ZipPath
Expand-Archive -Path $ZipPath -DestinationPath $BaseDir -Force

$LauncherPath = Join-Path $BaseDir "universal-software-launcher-main"

# ------------------------------
# EJECUTAR LAUNCHER (SIN -NoExit)
# ------------------------------
Set-Location $LauncherPath
Set-ExecutionPolicy Bypass -Scope Process -Force

powershell -ExecutionPolicy Bypass -File ".\launcher.ps1"
