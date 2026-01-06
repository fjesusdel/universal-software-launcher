# ==================================================
# BLACK CONSOLE - BOOTSTRAP DEFINITIVO
# ==================================================

$ErrorActionPreference = "Stop"

try {

    Write-Host "[*] Preparando Black Console..." -ForegroundColor Cyan

    $base = "$env:TEMP\BlackConsole"
    if (Test-Path $base) {
        Remove-Item $base -Recurse -Force
    }

    New-Item -ItemType Directory -Path $base | Out-Null

    $zip = "$base\repo.zip"
    $repo = "https://github.com/fjesusdel/universal-software-launcher/archive/refs/heads/main.zip"

    Invoke-WebRequest $repo -OutFile $zip -UseBasicParsing
    Expand-Archive $zip -DestinationPath $base -Force

    $launcher = Get-ChildItem $base -Recurse -Filter "launcher.ps1" | Select-Object -First 1
    if (-not $launcher) {
        throw "launcher.ps1 no encontrado"
    }

    # Crear script lanzador local (CMD)
    $cmd = "$base\run_blackconsole.cmd"

    @"
@echo off
mode con cols=100 lines=35
powershell -NoExit -ExecutionPolicy Bypass -File `"$($launcher.FullName)`"
"@ | Set-Content $cmd -Encoding ASCII

    Write-Host "[*] Solicitando permisos de administrador..." -ForegroundColor Yellow

    Start-Process -FilePath "cmd.exe" `
        -ArgumentList "/c `"$cmd`"" `
        -Verb RunAs

}
catch {

    Write-Host ""
    Write-Host "ERROR CRITICO EN BOOTSTRAP" -ForegroundColor Red
    Write-Host $_.Exception.Message -ForegroundColor DarkRed
    Write-Host ""
    Write-Host "Pulse cualquier tecla para salir..." -ForegroundColor DarkGray
    [void][System.Console]::ReadKey($true)
}
