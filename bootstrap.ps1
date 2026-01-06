# ==================================================
# BLACK CONSOLE - BOOTSTRAP
# ==================================================

$ErrorActionPreference = "Stop"

try {

    Write-Host "[*] Descargando Black Console..." -ForegroundColor Cyan

    $temp = "$env:TEMP\blackconsole"
    if (Test-Path $temp) {
        Remove-Item $temp -Recurse -Force
    }

    $zip = "$temp.zip"
    $repo = "https://github.com/fjesusdel/universal-software-launcher/archive/refs/heads/main.zip"

    Invoke-WebRequest $repo -OutFile $zip -UseBasicParsing
    Expand-Archive $zip -DestinationPath $temp -Force

    $launcher = Get-ChildItem $temp -Recurse -Filter "launcher.ps1" | Select-Object -First 1

    if (-not $launcher) {
        throw "No se pudo localizar launcher.ps1"
    }

    Write-Host "[*] Iniciando Black Console..." -ForegroundColor Cyan
    Write-Host ""

    powershell -ExecutionPolicy Bypass -NoExit -File $launcher.FullName

}
catch {

    Write-Host ""
    Write-Host "ERROR CRITICO EN BOOTSTRAP" -ForegroundColor Red
    Write-Host ""
    Write-Host $_.Exception.Message -ForegroundColor DarkRed
    Write-Host ""
    Write-Host "Pulse cualquier tecla para cerrar..." -ForegroundColor DarkGray
    [void][System.Console]::ReadKey($true)
}
