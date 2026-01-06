param (
    [switch]$Auto
)

# ==================================================
# AUTO-ELEVACIÓN A ADMINISTRADOR
# ==================================================
$IsAdmin = ([Security.Principal.WindowsPrincipal] `
    [Security.Principal.WindowsIdentity]::GetCurrent()
).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

if (-not $IsAdmin) {
    Write-Host "[!] Se requieren permisos de administrador. Reabriendo..." -ForegroundColor Yellow

    Start-Process powershell `
        -ArgumentList "-ExecutionPolicy Bypass -File `"$PSCommandPath`"" `
        -Verb RunAs

    exit
}

# ==================================================
# CONFIGURACIÓN INICIAL
# ==================================================
Clear-Host
$ErrorActionPreference = "Stop"

$BasePath = Split-Path -Parent $MyInvocation.MyCommand.Path

Import-Module "$BasePath\lib\ui.ps1"
Import-Module "$BasePath\lib\installer.ps1"
Import-Module "$BasePath\lib\detector.ps1"

# ==================================================
# LOGS
# ==================================================
$LogDir = "$BasePath\logs"
if (-not (Test-Path $LogDir)) {
    New-Item -ItemType Directory -Path $LogDir | Out-Null
}

Start-Transcript -Path "$LogDir\launcher.log" -Append

# ==================================================
# LISTA DE MÓDULOS
# ==================================================
$AllModules = @(
    "office2024.ps1",
    "chrome.ps1",
    "winrar.ps1",
    "virtualbox.ps1",
    "discord.ps1"
)

function Install-All {
    $i = 0
    foreach ($mod in $AllModules) {
        $i++
        Write-Progress `
            -Activity "Instalación masiva" `
            -Status "Instalando $mod" `
            -PercentComplete (($i / $AllModules.Count) * 100)

        . "$BasePath\modules\$mod"
    }

    Write-Progress -Activity "Instalación masiva" -Completed
}

# ==================================================
# EJECUCIÓN AUTOMÁTICA
# ==================================================
Show-Banner

if ($Auto) {
    Install-All
    Stop-Transcript
    exit
}

# ==================================================
# MENÚ INTERACTIVO
# ==================================================
do {
    Show-Menu
    $opt = Read-Host "Seleccione una opción"

    switch ($opt) {
        "1" { . "$BasePath\modules\office2024.ps1" }
        "2" { . "$BasePath\modules\chrome.ps1" }
        "3" { . "$BasePath\modules\winrar.ps1" }
        "4" { . "$BasePath\modules\virtualbox.ps1" }
        "5" { . "$BasePath\modules\discord.ps1" }
        "6" { Install-All }
        "7" { Show-Installed }
        "0" { break }
        default { Write-Host "Opción inválida" -ForegroundColor Red }
    }

    Pause
    Clear-Host
    Show-Banner
}
while ($true)

Stop-Transcript
