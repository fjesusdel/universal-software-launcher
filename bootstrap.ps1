$ErrorActionPreference = "Stop"

$repo = "https://github.com/TUUSUARIO/universal-software-launcher/archive/refs/heads/main.zip"
$temp = Join-Path $env:TEMP "universal-launcher"

Write-Host "[*] Descargando launcher..."
Invoke-WebRequest $repo -OutFile "$temp.zip"

if (Test-Path $temp) {
    Remove-Item $temp -Recurse -Force
}

Expand-Archive "$temp.zip" $temp -Force

Set-Location "$temp\universal-software-launcher-main"

Set-ExecutionPolicy Bypass -Scope Process -Force
.\launcher.ps1
