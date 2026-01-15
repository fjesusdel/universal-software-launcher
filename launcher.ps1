param (
    [switch]$Verbose
)

[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
chcp 65001 | Out-Null
$ErrorActionPreference = "Stop"

$BasePath = Split-Path -Parent $MyInvocation.MyCommand.Path

# =========================
# CARGA DE MODULOS
# =========================

$modules = @(
    "$BasePath\lib\config.ps1",
    "$BasePath\lib\ui.ps1",
    "$BasePath\lib\installer.ps1",

    "$BasePath\modules\hardware_detect.ps1",

    "$BasePath\modules\manual_install.ps1",        # SUBMENU INSTALAR
    "$BasePath\modules\uninstall\menu.ps1",        # SUBMENU ELIMINAR

    "$BasePath\modules\blackconsole_radial.ps1",
    "$BasePath\modules\volume_control.ps1",

    "$BasePath\modules\uninstall\status.ps1",
    "$BasePath\modules\uninstall\confirm.ps1",
    "$BasePath\modules\uninstall\uninstall_apps.ps1",
    "$BasePath\modules\uninstall\uninstall_windows_apps.ps1",

    "$BasePath\modules\prepare_new_pc.ps1",
    "$BasePath\modules\about.ps1"
)

foreach ($module in $modules) {
    Import-Module $module -ErrorAction Stop
}

$Host.UI.RawUI.WindowTitle = "$($Global:BlackConsole.Name) v$($Global:BlackConsole.Version)"

# =========================
# UI PRINCIPAL
# =========================

function Show-MainMenu {

    Clear-Host
    Show-Banner
    Show-Signature

    Write-Host ""
    Write-Host "INSTALACION AUTOMATICA"
    Write-Host "[1] Prepare New PC (Recommended)"
    Write-Host ""

    Write-Host "INSTALACION DE SOFTWARE"
    Write-Host "[2] Instalar software"
    Write-Host ""

    Write-Host "DESINSTALACION DE SOFTWARE"
    Write-Host "[3] Eliminar software"
    Write-Host ""

    Write-Host "OTRAS OPCIONES"
    Write-Host "[A] Acerca de Black Console"
    Write-Host "[0] Salir"
    Write-Host ""
}

# =========================
# BUCLE PRINCIPAL
# =========================

while ($true) {

    Show-MainMenu
    $opt = Read-Host "Seleccione una opcion"

    switch ($opt.ToUpper()) {

        "1" { Prepare-NewPC }
        "2" { Show-ManualInstallMenu }
        "3" { Show-UninstallMenu }

        "A" { Show-About }
        "0" { exit }

        default {
            Write-Host "Opcion invalida" -ForegroundColor Red
            Start-Sleep 1
        }
    }

    Pause
}
