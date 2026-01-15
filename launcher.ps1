param (
    [switch]$Verbose
)

[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
chcp 65001 | Out-Null

$ErrorActionPreference = "Stop"

$BasePath = Split-Path -Parent $MyInvocation.MyCommand.Path

$modules = @(
    "$BasePath\lib\config.ps1",
    "$BasePath\lib\ui.ps1",
    "$BasePath\lib\installer.ps1",

    "$BasePath\modules\hardware_detect.ps1",
    "$BasePath\modules\manual_install.ps1",

    "$BasePath\modules\blackconsole_radial.ps1",
    "$BasePath\modules\volume_control.ps1",

    "$BasePath\modules\uninstall\status.ps1",
    "$BasePath\modules\uninstall\confirm.ps1",
    "$BasePath\modules\uninstall\uninstall_apps.ps1",
    "$BasePath\modules\uninstall\uninstall_windows_apps.ps1",
    "$BasePath\modules\uninstall\menu.ps1",

    "$BasePath\modules\prechecks.ps1",
    "$BasePath\modules\snapshot.ps1",
    "$BasePath\modules\presets.ps1",
    "$BasePath\modules\prepare_new_pc.ps1",
    "$BasePath\modules\system_diagnostic.ps1",
    "$BasePath\modules\about.ps1"
)

foreach ($module in $modules) {
    Import-Module $module -ErrorAction Stop
}

$Host.UI.RawUI.WindowTitle = "$($Global:BlackConsole.Name) v$($Global:BlackConsole.Version)"

function Show-MainScreen {
    Clear-Host
    Show-Banner
    Show-Signature
    Write-Host ""
    Write-Host "$($Global:BlackConsole.Name) v$($Global:BlackConsole.Version)" -ForegroundColor DarkGray
}

Show-MainScreen

while ($true) {

    Show-Menu
    Write-Host ""
    Write-Host "3) Eliminar software" -ForegroundColor Cyan
    Write-Host ""

    $opt = Read-Host "Seleccione una opcion"

    switch ($opt.ToUpper()) {

        "1" { Prepare-NewPC }
        "2" { Install-Chrome }
        "3" { Show-UninstallMenu }

        "6" { Install-Steam }

        "R" { Install-BlackConsoleRadial }
        "V" { Install-VolumeControl }

        "A" { Show-About }

        "0" { exit }

        default {
            Write-Host "Opcion invalida" -ForegroundColor Red
            Start-Sleep 1
        }
    }

    Pause
    Show-MainScreen
}
