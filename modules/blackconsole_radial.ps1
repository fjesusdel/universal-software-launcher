function Install-BlackConsoleRadial {

    Clear-Host
    Write-Host "==========================================" -ForegroundColor Cyan
    Write-Host "  BLACK CONSOLE :: RADIAL HUD INSTALLER" -ForegroundColor Cyan
    Write-Host "==========================================" -ForegroundColor Cyan
    Write-Host ""

    $BasePath = Split-Path -Parent $PSScriptRoot
    $Installer = Join-Path $PSScriptRoot "blackconsole_radial\install.ps1"

    if (-not (Test-Path $Installer)) {
        Write-Host "ERROR: No se encuentra el instalador del Radial HUD" -ForegroundColor Red
        Write-Host $Installer -ForegroundColor DarkRed
        return
    }

    Write-Host "[*] Iniciando instalacion de Black Console Radial..." -ForegroundColor Yellow
    Write-Host ""

    try {
        & $Installer
        Write-Host ""
        Write-Host "[OK] Black Console Radial instalado correctamente." -ForegroundColor Green
    }
    catch {
        Write-Host ""
        Write-Host "[ERROR] Fallo durante la instalacion del Radial HUD" -ForegroundColor Red
        Write-Host $_.Exception.Message -ForegroundColor DarkRed
    }
}
