param (
    [switch]$Auto
)

Clear-Host
$ErrorActionPreference = "Stop"
$BasePath = Split-Path -Parent $MyInvocation.MyCommand.Path

Import-Module "$BasePath/lib/ui.ps1"
Import-Module "$BasePath/lib/installer.ps1"
Import-Module "$BasePath/lib/detector.ps1"

Start-Transcript -Path "$BasePath/logs/launcher.log" -Append

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

        . "$BasePath/modules/$mod"
    }
    Write-Progress -Activity "Instalación masiva" -Completed
}

Show-Banner

if ($Auto) {
    Install-All
    Stop-Transcript
    exit
}

do {
    Show-Menu
    $opt = Read-Host "Seleccione una opción"

    switch ($opt) {
        "1" { . "$BasePath/modules/office2024.ps1" }
        "2" { . "$BasePath/modules/chrome.ps1" }
        "3" { . "$BasePath/modules/winrar.ps1" }
        "4" { . "$BasePath/modules/virtualbox.ps1" }
        "5" { . "$BasePath/modules/discord.ps1" }
        "6" { Install-All }
        "7" { Show-Installed }
        "0" { break }
        default { Write-Host "Opción inválida" -ForegroundColor Red }
    }

    Pause
    Clear-Host
    Show-Banner
} while ($true)

Stop-Transcript
