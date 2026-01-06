param (
    [switch]$Auto
)

# ==================================================
# FORZAR UTF-8
# ==================================================
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
chcp 65001 | Out-Null

# ==================================================
# CONFIGURACION INICIAL
# ==================================================
Clear-Host
$ErrorActionPreference = "Stop"
$Host.UI.RawUI.WindowTitle = "Black Console"

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
# MODULOS
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
            -Activity "Instalacion masiva" `
            -Status "Instalando $mod" `
            -PercentComplete (($i / $AllModules.Count) * 100)

        . "$BasePath\modules\$mod"
    }

    Write-Progress -Activity "Instalacion masiva" -Completed
}

# ==================================================
# EJECUCION
# ==================================================
Show-Banner

if ($Auto) {
    Install-All
    Stop-Transcript
    exit
}

do {
    Show-Menu
    $opt = Read-Host "Seleccione una opcion"

    switch ($opt) {
        "1" { . "$BasePath\modules\office2024.ps1" }
        "2" { . "$BasePath\modules\chrome.ps1" }
        "3" { . "$BasePath\modules\winrar.ps1" }
        "4" { . "$BasePath\modules\virtualbox.ps1" }
        "5" { . "$BasePath\modules\discord.ps1" }
        "6" { Install-All }
        "7" { Show-Installed }
        "0" { break }
        default { Write-Host "Opcion invalida" -ForegroundColor Red }
    }

    Pause
    Clear-Host
    Show-Banner
}
while ($true)

Stop-Transcript
