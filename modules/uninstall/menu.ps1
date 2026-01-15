function Show-UninstallMenu {

    while ($true) {

        Clear-Host
        Show-Banner
        Show-Signature

        Write-Host ""
        Write-Host "ELIMINAR SOFTWARE" -ForegroundColor Cyan
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

        Write-Host "Sistema:"
        Write-Host " W) Apps de Windows no esenciales"
        Write-Host ""

        Write-Host " 0) Volver"
        Write-Host ""

        $opt = Read-Host "Seleccione una opcion"

        switch ($opt.ToUpper()) {

            "1" { if (Confirm-Action "¿Desinstalar Google Chrome?") { Invoke-UninstallByName "*Google Chrome*" } }
            "2" { if (Confirm-Action "¿Desinstalar WinRAR?") { Invoke-UninstallByName "*WinRAR*" } }
            "3" { if (Confirm-Action "¿Desinstalar Discord?") { Invoke-UninstallByName "*Discord*" } }
            "4" { if (Confirm-Action "¿Desinstalar VirtualBox?") { Invoke-UninstallByName "*VirtualBox*" } }

            "5" { if (Confirm-Action "¿Desinstalar Steam?") { Uninstall-Steam } }
            "6" { if (Confirm-Action "¿Desinstalar Firefox?") { Invoke-UninstallByName "*Firefox*" } }
            "7" { if (Confirm-Action "¿Desinstalar 7-Zip?") { Invoke-UninstallByName "*7-Zip*" } }
            "8" { if (Confirm-Action "¿Desinstalar NVIDIA App?") { Invoke-UninstallByName "*NVIDIA App*" } }
            "9" { if (Confirm-Action "¿Desinstalar Ultimaker Cura?") { Invoke-UninstallByName "*Ultimaker Cura*" } }

            "R" { if (Confirm-Action "¿Eliminar Black Console Radial?") { & "$PSScriptRoot\..\blackconsole_radial\uninstall.ps1"; Pause } }
            "V" { if (Confirm-Action "¿Eliminar control de volumen?") { & "$PSScriptRoot\..\volume_control\uninstall.ps1"; Pause } }

            "W" { Uninstall-WindowsApps }

            "0" { return }

            default {
                Write-Host "Opcion invalida" -ForegroundColor Red
                Start-Sleep 1
            }
        }
    }
}
