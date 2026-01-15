param (
    [switch]$Verbose
)

[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
chcp 65001 | Out-Null

$ErrorActionPreference = "Stop"
$Host.UI.RawUI.WindowTitle = "Black Console"

$BasePath = Split-Path -Parent $MyInvocation.MyCommand.Path

$modules = @(
    "$BasePath\lib\config.ps1",
    "$BasePath\lib\ui.ps1",
    "$BasePath\lib\installer.ps1",

    "$BasePath\modules\hardware_detect.ps1",
    "$BasePath\modules\manual_install.ps1",
    "$BasePath\modules\batch_install.ps1",
    "$BasePath\modules\uninstall\menu.ps1",
    "$BasePath\modules\uninstall\status.ps1",
    "$BasePath\modules\uninstall\uninstall_windows_apps.ps1",

    "$BasePath\modules\prechecks.ps1",
    "$BasePath\modules\snapshot.ps1",
    "$BasePath\modules\presets.ps1",
    "$BasePath\modules\prepare_new_pc.ps1",
    "$BasePath\modules\system_diagnostic.ps1",
    "$BasePath\modules\about.ps1"
)

foreach ($module in $modules) {
    try {
        Import-Module $module -ErrorAction Stop
    } catch {
        Clear-Host
        Write-Host "ERROR CRITICO AL INICIAR BLACK CONSOLE" -ForegroundColor Red
        Write-Host ""
        Write-Host "No se pudo cargar el modulo:"
        Write-Host " $module" -ForegroundColor Yellow
        Write-Host ""
        Write-Host $_.Exception.Message -ForegroundColor DarkRed
        Write-Host ""
        Read-Host "Pulse ENTER para salir"
        exit 1
    }
}

if ($Verbose) {
    $Global:BlackConsole.Verbose = $true
}

function Show-MainScreen {
    Clear-Host
    Show-Banner
    Show-Signature
}

Show-MainScreen

while ($true) {

    Write-Host ""
    Write-Host "INSTALACION AUTOMATICA"
    Write-Host "[1] Prepare New PC (Recommended)"
    Write-Host ""
    Write-Host "INSTALACION DE SOFTWARE"
    Write-Host "[2] Instalar software (individual)"
    Write-Host "[3] Instalacion por lotes"
    Write-Host ""
    Write-Host "ELIMINAR SOFTWARE"
    Write-Host "[4] Eliminar software"
    Write-Host ""
    Write-Host "OTRAS OPCIONES"
    Write-Host "[A] Acerca de Black Console"
    Write-Host "[0] Salir"
    Write-Host ""

    $opt = Read-Host "Seleccione una opcion"

    switch ($opt.ToUpper()) {

        "1" { Prepare-NewPC }
        "2" { Show-ManualInstallMenu }
        "3" { Start-BatchInstall }
        "4" { Show-UninstallMenu }

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

    Show-MainScreen
}
