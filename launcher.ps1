param (
    [switch]$Verbose
)

# ==================================================
# BLACK CONSOLE - LAUNCHER PRINCIPAL
# ==================================================

[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
chcp 65001 | Out-Null

$ErrorActionPreference = "Stop"
$Host.UI.RawUI.WindowTitle = "Black Console"

# --------------------------------------------------
# AJUSTE DE TAMANO DE VENTANA (IMPORTANTE)
# --------------------------------------------------
try {
    $rawUI = $Host.UI.RawUI

    # Buffer primero
    $bufferSize = $rawUI.BufferSize
    $bufferSize.Width  = 120
    $bufferSize.Height = 300
    $rawUI.BufferSize = $bufferSize

    # Ventana despues
    $windowSize = $rawUI.WindowSize
    $windowSize.Width  = 100
    $windowSize.Height = 35
    $rawUI.WindowSize = $windowSize
}
catch {
    # Si falla (PowerShell antiguo, permisos, etc.), no rompemos nada
}

# --------------------------------------------------
# RUTA BASE
# --------------------------------------------------
$BasePath = Split-Path -Parent $MyInvocation.MyCommand.Path

# --------------------------------------------------
# CARGA SEGURA DE MODULOS
# --------------------------------------------------
$modules = @(
    "$BasePath\lib\config.ps1",
    "$BasePath\lib\ui.ps1",
    "$BasePath\lib\installer.ps1",
    "$BasePath\modules\hardware_detect.ps1",
    "$BasePath\modules\manual_install.ps1",
    "$BasePath\modules\prepare_new_pc.ps1",
    "$BasePath\modules\system_diagnostic.ps1"
)

foreach ($module in $modules) {
    try {
        Import-Module $module -ErrorAction Stop
    } catch {
        Clear-Host
        Write-Host "ERROR CRITICO AL INICIAR BLACK CONSOLE" -ForegroundColor Red
        Write-Host ""
        Write-Host "No se pudo cargar el modulo:" -ForegroundColor Yellow
        Write-Host " $module"
        Write-Host ""
        Write-Host $_.Exception.Message -ForegroundColor DarkRed
        Write-Host ""
        Write-Host "Pulse cualquier tecla para salir..." -ForegroundColor DarkGray
        [void][System.Console]::ReadKey($true)
        exit 1
    }
}

# --------------------------------------------------
# MODO VERBOSE
# --------------------------------------------------
if ($Verbose) {
    $Global:BlackConsole.Verbose = $true
}

# --------------------------------------------------
# FUNCIONES DE UI
# --------------------------------------------------
function Show-MainScreen {
    Clear-Host
    Show-Banner
    Show-Signature
}

# --------------------------------------------------
# ARRANQUE
# --------------------------------------------------
Show-MainScreen

while ($true) {

    Show-Menu
    $opt = Read-Host "Seleccione una opcion"

    switch ($opt.ToUpper()) {

        "1" { Prepare-NewPC }

        "6" { Install-Steam }
        "8" { Install-Firefox }
        "9" { Install-7Zip }
        "10" { Install-NvidiaApp }
        "11" { Install-UltimakerCura }

        "D" { Show-SystemDiagnostic }

        "A" { Show-About }

        "0" {
            Write-Host ""
            Write-Host "Saliendo de Black Console..." -ForegroundColor Cyan
            exit
        }

        default {
            Write-Host "Opcion invalida" -ForegroundColor Red
            Start-Sleep -Seconds 1
        }
    }

    Write-Host ""
    Write-Host "Pulse cualquier tecla para volver al menu..." -ForegroundColor DarkGray
    [void][System.Console]::ReadKey($true)
    Show-MainScreen
}
