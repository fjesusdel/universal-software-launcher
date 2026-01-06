$ErrorActionPreference = "Stop"

$repoUrl = "https://github.com/fjesusdel/universal-software-launcher/archive/refs/heads/main.zip"
$baseDir = Join-Path $env:TEMP "universal-launcher"
$zipPath = "$baseDir.zip"

Write-Host "[*] Descargando launcher..."

Invoke-WebRequest -Uri $repoUrl -OutFile $zipPath

if (-not (Test-Path $baseDir)) {
    New-Item -ItemType Directory -Path $baseDir | Out-Null
}

Expand-Archive -Path $zipPath -DestinationPath $baseDir -Force

$launcherPath = Join-Path $baseDir "universal-software-launcher-main"

Set-Location $launcherPath
Set-ExecutionPolicy Bypass -Scope Process -Force

.\launcher.ps1
