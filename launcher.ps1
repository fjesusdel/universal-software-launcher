param (
    [switch]$Verbose
)

[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
chcp 65001 | Out-Null

$ErrorActionPreference = "Stop"
$Host.UI.RawUI.WindowTitle = "Black Console"

$BasePath = Split-Path -Parent $MyInvocation.MyCommand.Path

Import-Module "$BasePath\lib\config.ps1"
Import-Module "$BasePath\lib\ui.ps1"
Import-Module "$BasePath\lib\installer.ps1"
Import-Module "$BasePath\modules\prepare_new_pc.ps1"

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
    $opt = Read-Host "Seleccione una opcion"

    switch ($opt.ToUpper()) {

        "1" {
            Prepare-NewPC
            Write-Host ""
            Write-Host "Pulse cualquier tecla para volver al menu..." -ForegroundColor DarkGray
            [void][System.Console]::ReadKey($true)
            Show-MainScreen
        }

        "A" {
            Show-About
            Show-MainScreen
        }

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
