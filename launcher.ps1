param ([switch]$Verbose)

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
    "$BasePath\modules\prechecks.ps1",
    "$BasePath\modules\snapshot.ps1",
    "$BasePath\modules\presets.ps1",
    "$BasePath\modules\prepare_new_pc.ps1",
    "$BasePath\modules\system_diagnostic.ps1"
)

foreach ($m in $modules) { Import-Module $m -ErrorAction Stop }

function Show-MainScreen {
    Clear-Host
    Show-Banner
    Show-Signature
}

Show-MainScreen

while ($true) {
    Show-Menu
    $opt = Read-Host "Seleccione una opcion"

    switch ($opt.ToUpper()) {
        "1" { Prepare-NewPC }
        "2" { Install-Chrome }
        "3" { Install-WinRAR }
        "4" { Install-Discord }
        "5" { Install-VirtualBox }
        "6" { Install-Steam }
        "7" { Install-Firefox }
        "8" { Install-7Zip }
        "9" { Install-NvidiaApp }
        "10" { Install-UltimakerCura }
        "A" { Show-About }
        "0" { exit }
        default { Write-Host "Opcion invalida"; Start-Sleep 1 }
    }

    Write-Host ""
    Read-Host "Pulse ENTER para volver al menu"
    Show-MainScreen
}
