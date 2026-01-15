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
    "$BasePath\modules\blackconsole_radial.ps1",   # 👈 NUEVO
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

    Show-Menu
    Write-Host ""
    Write-Host "INSTALACIONES MANUALES" -ForegroundColor Cyan
    Write-Host "----------------------"
    Write-Host "R) Instalar Black Console Radial HUD"
    Write-Host ""

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

        "R" { Install-BlackConsoleRadial }

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
