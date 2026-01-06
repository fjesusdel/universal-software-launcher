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
Import-Module "$BasePath\lib\detector.ps1"

if ($Verbose) {
    $Global:BlackConsole.Verbose = $true
}

Show-Banner
Show-Signature

do {
    Show-Menu
    $opt = Read-Host "Seleccione una opcion"

    switch ($opt.ToUpper()) {
        "1" { Write-Host "Prepare New PC aun no ejecutado (en desarrollo)" -ForegroundColor Yellow }
        "A" { Show-About }
        "0" {
            Write-Host "`nSaliendo de Black Console..." -ForegroundColor Cyan
            exit
        }
        default {
            Write-Host "Opcion invalida" -ForegroundColor Red
        }
    }

    Pause
    Show-Banner
    Show-Signature
}
while ($true)
