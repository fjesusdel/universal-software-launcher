# ==================================================
# SUBMENU - INSTALAR SOFTWARE
# ==================================================

# Cargar instaladores clasicos
$InstallerPath = Join-Path (Split-Path $PSScriptRoot -Parent) "lib\installer.ps1"
. $InstallerPath

function Show-ManualInstallMenu {

    while ($true) {

        Clear-Host
        Show-Banner
        Show-Signature

        Write-Host ""
        Write-Host "INSTALAR SOFTWARE" -ForegroundColor Cyan
        Write-Host "-----------------" -ForegroundColor Cyan
        Write-Host ""

        # Deteccion de estado
        $chromeInstalled   = Is-ProgramInstalled "Google Chrome"
        $winrarInstalled   = Is-ProgramInstalled "WinRAR"
        $discordInstalled  = Test-DiscordInstalled
        $virtualInstalled  = Is-ProgramInstalled "Oracle VM VirtualBox"

        $steamInstalled    = Is-ProgramInstalled "Steam"
        $firefoxInstalled  = Is-ProgramInstalled "Mozilla Firefox"
        $zipInstalled      = Is-ProgramInstalled "7-Zip"
        $nvidiaInstalled   = Is-ProgramInstalled "NVIDIA App"
        $curaInstalled     = Is-ProgramInstalled "Ultimaker Cura"

        $radialInstalled   = Test-RadialInstalled
        $volumeInstalled   = Test-VolumeInstalled

        Write-Host "Aplicaciones:"
        Write-Host " 1) Google Chrome $(Get-StatusLabel $chromeInstalled)"
        Write-Host " 2) WinRAR $(Get-StatusLabel $winrarInstalled)"
        Write-Host " 3) Discord $(Get-StatusLabel $discordInstalled)"
        Write-Host " 4) VirtualBox $(Get-StatusLabel $virtualInstalled)"
        Write-Host ""

        Write-Host "Aplicaciones avanzadas:"
        Write-Host " 5) Steam $(Get-StatusLabel $steamInstalled)"
        Write-Host " 6) Mozilla Firefox $(Get-StatusLabel $firefoxInstalled)"
        Write-Host " 7) 7-Zip $(Get-StatusLabel $zipInstalled)"
        Write-Host " 8) NVIDIA App $(Get-StatusLabel $nvidiaInstalled)"
        Write-Host " 9) Ultimaker Cura $(Get-StatusLabel $curaInstalled)"
        Write-Host ""

        Write-Host "Herramientas Black Console:"
        Write-Host " R) Black Console Radial HUD $(Get-StatusLabel $radialInstalled)"
        Write-Host " V) Control de volumen rapido $(Get-StatusLabel $volumeInstalled)"
        Write-Host ""

        Write-Host " 0) Volver"
        Write-Host ""

        $opt = Read-Host "Seleccione una opcion"

        switch ($opt.ToUpper()) {

            "1" { Install-Chrome }
            "2" { Install-WinRAR }
            "3" { Install-Discord }
            "4" { Install-VirtualBox }

            "5" { Install-Steam }
            "6" { Install-Firefox }
            "7" { Install-7Zip }
            "8" { Install-NvidiaApp }
            "9" { Install-UltimakerCura }

            "R" { Install-BlackConsoleRadial }
            "V" { Install-VolumeControl }

            "0" { return }

            default {
                Write-Host "Opcion invalida" -ForegroundColor Red
                Start-Sleep 1
            }
        }

        Pause
    }
}
