function Show-UninstallMenu {

    while ($true) {

        Clear-Host
        Show-Banner
        Show-Signature

        Write-Host ""
        Write-Host "ELIMINAR SOFTWARE" -ForegroundColor Cyan
        Write-Host "-----------------" -ForegroundColor Cyan
        Write-Host ""

        # Deteccion de estado
        $chromeInstalled     = Test-AppInstalledByName "*Google Chrome*"
        $winrarInstalled     = Test-AppInstalledByName "*WinRAR*"
        $discordInstalled    = Test-AppInstalledByName "*Discord*"
        $virtualBoxInstalled = Test-AppInstalledByName "*VirtualBox*"

        $steamInstalled      = Test-AppInstalledByName "*Steam*"
        $firefoxInstalled    = Test-AppInstalledByName "*Firefox*"
        $zipInstalled        = Test-AppInstalledByName "*7-Zip*"
        $nvidiaInstalled     = Test-AppInstalledByName "*NVIDIA App*"
        $curaInstalled       = Test-AppInstalledByName "*Ultimaker Cura*"

        $radialInstalled     = Test-RadialInstalled
        $volumeInstalled     = Test-VolumeInstalled

        Write-Host "Aplicaciones:"
        Write-Host " 1) Google Chrome $(Get-StatusLabel $chromeInstalled)"
        Write-Host " 2) WinRAR $(Get-StatusLabel $winrarInstalled)"
        Write-Host " 3) Discord $(Get-StatusLabel $discordInstalled)"
        Write-Host " 4) VirtualBox $(Get-StatusLabel $virtualBoxInstalled)"
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

        Write-Host "Sistema:"
        Write-Host " W) Apps de Windows no esenciales"
        Write-Host ""

        Write-Host " 0) Volver"
        Write-Host ""

        $opt = Read-Host "Seleccione una opcion"

        switch ($opt.ToUpper()) {

            "1" { if ($chromeInstalled -and (Confirm-Action "¿Desinstalar Google Chrome?")) { Invoke-UninstallByName "*Google Chrome*" } }
            "2" { if ($winrarInstalled -and (Confirm-Action "¿Desinstalar WinRAR?")) { Invoke-UninstallByName "*WinRAR*" } }
            "3" { if ($discordInstalled -and (Confirm-Action "¿Desinstalar Discord?")) { Invoke-UninstallByName "*Discord*" } }
            "4" { if ($virtualBoxInstalled -and (Confirm-Action "¿Desinstalar VirtualBox?")) { Invoke-UninstallByName "*VirtualBox*" } }

            "5" { if ($steamInstalled -and (Confirm-Action "¿Desinstalar Steam?")) { Uninstall-Steam } }
            "6" { if ($firefoxInstalled -and (Confirm-Action "¿Desinstalar Firefox?")) { Invoke-UninstallByName "*Firefox*" } }
            "7" { if ($zipInstalled -and (Confirm-Action "¿Desinstalar 7-Zip?")) { Invoke-UninstallByName "*7-Zip*" } }
            "8" { if ($nvidiaInstalled -and (Confirm-Action "¿Desinstalar NVIDIA App?")) { Invoke-UninstallByName "*NVIDIA App*" } }
            "9" { if ($curaInstalled -and (Confirm-Action "¿Desinstalar Ultimaker Cura?")) { Invoke-UninstallByName "*Ultimaker Cura*" } }

            "R" { if ($radialInstalled -and (Confirm-Action "¿Eliminar Black Console Radial?")) { & "$PSScriptRoot\..\blackconsole_radial\uninstall.ps1"; Pause } }
            "V" { if ($volumeInstalled -and (Confirm-Action "¿Eliminar control de volumen?")) { & "$PSScriptRoot\..\volume_control\uninstall.ps1"; Pause } }

            "W" { Uninstall-WindowsApps }

            "0" { return }

            default {
                Write-Host "Opcion invalida" -ForegroundColor Red
                Start-Sleep 1
            }
        }
    }
}
