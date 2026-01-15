# ==================================================
# INSTALACIÓN MANUAL - BLACK CONSOLE
# ==================================================

function Show-ManualInstallMenu {

    Clear-Host
    Write-Host "INSTALAR SOFTWARE"
    Write-Host ""

    Write-Host "Aplicaciones:"
    Write-Host " 1) Google Chrome"
    Write-Host " 2) WinRAR"
    Write-Host " 3) Discord"
    Write-Host " 4) VirtualBox"
    Write-Host ""
    Write-Host "Aplicaciones avanzadas:"
    Write-Host " 5) Steam"
    Write-Host " 6) Mozilla Firefox"
    Write-Host " 7) 7-Zip"
    Write-Host " 8) NVIDIA App"
    Write-Host " 9) Ultimaker Cura"
    Write-Host ""
    Write-Host "Herramientas Black Console:"
    Write-Host " R) Black Console Radial HUD"
    Write-Host " V) Control de volumen rápido"
    Write-Host ""
    Write-Host " 0) Volver"
    Write-Host ""

    $opt = Read-Host "Seleccione una opción"

    switch ($opt.ToUpper()) {
        "1" { Install-Chrome }
        "2" { Install-WinRAR }
        "3" { Install-Discord }
        "4" { Install-VirtualBox }
        "5" { Install-Steam }
        "6" { Install-Firefox }
        "7" { Install-7Zip }
        "8" { Install-NvidiaApp }
        "9" { Install-UltimakerCura }
        "R" { Install-BlackConsoleRadial }
        "V" { Install-VolumeControl }
        "0" { return }
        default {
            Write-Host "Opción no válida" -ForegroundColor Red
            Start-Sleep 1
        }
    }
}
