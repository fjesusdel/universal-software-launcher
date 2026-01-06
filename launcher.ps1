param (
    [switch]$Verbose
)

# ----------------------------------------------
# CONFIGURACION INICIAL
# ----------------------------------------------
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
chcp 65001 | Out-Null

$ErrorActionPreference = "Stop"
$Host.UI.RawUI.WindowTitle = "Black Console"

$BasePath = Split-Path -Parent $MyInvocation.MyCommand.Path

# ----------------------------------------------
# CARGA SEGURA DE MODULOS
# ----------------------------------------------
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

# ----------------------------------------------
# MODO VERBOSE
# ----------------------------------------------
if ($Verbose) {
    $Global:BlackConsole.Verbose = $true
}

# ----------------------------------------------
# FUNCIONES DE UI
# ----------------------------------------------
function Show-MainScreen {
    Clear-Host
    Show-Banner
    Show-Signature
}

# ----------------------------------------------
# ARRANQUE
# ----------------------------------------------
Show-MainScreen

while ($true) {

    Show-Menu
    $opt = Read-Host "Seleccione una opcion"

    switch ($opt.ToUpper()) {

        # ------------------------------------------
        # OPCION 1 - PREPARE NEW PC
        # ------------------------------------------
        "1" {
            Prepare-NewPC
            Write-Host ""
            Write-Host "Pulse cualquier tecla para volver al menu..." -ForegroundColor DarkGray
            [void][System.Console]::ReadKey($true)
            Show-MainScreen
        }

        # ------------------------------------------
        # INSTALACION MANUAL
        # ------------------------------------------
        "6" { Install-Steam }
        "7" { Install-WhatsApp }
        "8" { Install-Firefox }
        "9" { Install-7Zip }
        "10" { Install-NvidiaApp }
        "11" { Install-UltimakerCura }

        # ------------------------------------------
        # DIAGNOSTICO
        # ------------------------------------------
        "D" {
            Show-SystemDiagnostic
            Show-MainScreen
        }

        # ------------------------------------------
        # ACERCA DE
        # ------------------------------------------
        "A" {
            Show-About
            Show-MainScreen
        }

        # ------------------------------------------
        # SALIR
        # ------------------------------------------
        "0" {
            Write-Host ""
            Write-Host "Saliendo de Black Console..." -ForegroundColor Cyan
            exit
        }

        default {
            Write-Host "Opcion invalida" -ForegroundColor Red
            Start-Sleep -Seconds 1
            Show-MainScreen
        }
    }
}
