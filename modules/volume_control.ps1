function Install-VolumeControl {

    Clear-Host
    Write-Host "==========================================" -ForegroundColor Cyan
    Write-Host "  BLACK CONSOLE :: CONTROL DE VOLUMEN" -ForegroundColor Cyan
    Write-Host "==========================================" -ForegroundColor Cyan
    Write-Host ""

    $Installer = Join-Path $PSScriptRoot "volume_control\install.ps1"

    if (-not (Test-Path $Installer)) {
        Write-Host "ERROR: No se encuentra el instalador del control de volumen" -ForegroundColor Red
        return
    }

    try {
        & $Installer

        Write-Host ""
        Write-Host "CONTROL DE VOLUMEN RAPIDO ACTIVADO" -ForegroundColor Green
        Write-Host ""
        Write-Host "Atajos de teclado:" -ForegroundColor Cyan
        Write-Host "  Ctrl + Flecha Arriba  -> Subir volumen"
        Write-Host "  Ctrl + Flecha Abajo   -> Bajar volumen"
        Write-Host "  Ctrl + M              -> Silenciar"
        Write-Host ""
        Write-Host "El control se ejecuta automaticamente al iniciar Windows." -ForegroundColor DarkGray
    }
    catch {
        Write-Host ""
        Write-Host "[ERROR] Fallo durante la instalacion del control de volumen" -ForegroundColor Red
        Write-Host $_.Exception.Message -ForegroundColor DarkRed
    }
}
