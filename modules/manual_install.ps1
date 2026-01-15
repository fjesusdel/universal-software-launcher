# ==================================================
# SUBMENU - INSTALAR SOFTWARE
# ==================================================

function Show-ManualInstallMenu {

    while ($true) {

        Clear-Host
        Show-Banner
        Show-Signature

        Write-Host ""
        Write-Host "INSTALAR SOFTWARE" -ForegroundColor Cyan
        Write-Host "-----------------" -ForegroundColor Cyan
        Write-Host ""

        Write-Host "Aplicaciones:"
        Write-Host " 1) Google Chrome $(Get-StatusLabel (Test-ChromeInstalled))"
        Write-Host " 2) WinRAR $(Get-StatusLabel (Test-WinRARInstalled))"
        Write-Host " 3) Discord $(Get-StatusLabel (Test-DiscordInstalled))"
        Write-Host " 4) VirtualBox $(Get-StatusLabel (Test-VirtualBoxInstalled))"
        Write-Host ""

        Write-Host "Aplicaciones avanzadas:"
        Write-Host " 5) Steam $(Get-StatusLabel (Test-SteamInstalled))"
        Write-Host " 6) Mozilla Firefox $(Get-StatusLabel (Test-FirefoxInstalled))"
        Write-Host " 7) 7-Zip $(Get-StatusLabel (Test-7ZipInstalled))"
        Write-Host " 8) NVIDIA App $(Get-StatusLabel (Test-NvidiaAppInstalled))"
        Write-Host " 9) Ultimaker Cura $(Get-StatusLabel (Test-UltimakerCuraInstalled))"
        Write-Host ""

        Write-Host "Herramientas Black Console:"
        Write-Host " R) Black Console Radial HUD $(Get-StatusLabel (Test-RadialInstalled))"
        Write-Host " V) Control de volumen rapido $(Get-StatusLabel (Test-VolumeInstalled))"
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
