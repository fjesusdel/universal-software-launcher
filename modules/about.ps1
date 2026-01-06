# ==================================================
# ABOUT - BLACK CONSOLE
# ==================================================

function Show-About {

    Clear-Host

    Write-Host "BLACK CONSOLE" -ForegroundColor Cyan
    Write-Host "-------------"
    Write-Host ""

    Write-Host "Autor: $($Global:BlackConsole.Author)"
    Write-Host "Version: $($Global:BlackConsole.Version)"
    Write-Host ""

    Write-Host "Descripcion:"
    Write-Host "Herramienta para preparar, optimizar y configurar sistemas Windows"
    Write-Host "de forma controlada, clara y reproducible."
    Write-Host ""

    Write-Host "Principios:"
    Write-Host " - Transparencia"
    Write-Host " - Control del usuario"
    Write-Host " - Modularidad"
    Write-Host " - Sin acciones ocultas"
    Write-Host ""

    Write-Host "Pulse cualquier tecla para volver al menu..." -ForegroundColor DarkGray
    [void][System.Console]::ReadKey($true)
}
