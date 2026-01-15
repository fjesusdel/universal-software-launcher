# ==================================================
# BLACK CONSOLE RADIAL HUD - INSTALLER
# ==================================================

function Install-BlackConsoleRadial {

    Write-Host "[*] Instalando Black Console Radial HUD..." -ForegroundColor Cyan

    $skinsPath = "$env:USERPROFILE\Documents\Rainmeter\Skins"
    $target    = Join-Path $skinsPath "BlackConsole"

    if (Test-Path $target) {
        Write-Host "[SKIP] El radial ya está instalado." -ForegroundColor Yellow
        return
    }

    $source = Join-Path $PSScriptRoot "..\assets\radial"

    if (-not (Test-Path $source)) {
        Write-Host "[ERROR] No se encuentra el paquete del radial." -ForegroundColor Red
        return
    }

    Copy-Item $source $target -Recurse -Force

    Start-Process "Rainmeter.exe"

    Write-Host "[OK] Black Console Radial HUD instalado." -ForegroundColor Green
}
