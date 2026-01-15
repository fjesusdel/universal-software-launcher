function Show-UninstallMenu {

    while ($true) {

        Clear-Host
        Show-Banner
        Show-Signature

        Write-Host ""
        Write-Host "ELIMINAR SOFTWARE" -ForegroundColor Cyan
        Write-Host "-----------------" -ForegroundColor Cyan
        Write-Host ""

        $steamInstalled  = Test-SteamInstalled
        $radialInstalled = Test-RadialInstalled
        $volInstalled    = Test-VolumeInstalled

        Write-Host "Aplicaciones:"
        Write-Host " 1) Steam $(Get-StatusLabel $steamInstalled)"
        Write-Host ""

        Write-Host "Herramientas Black Console:"
        Write-Host " R) Black Console Radial HUD $(Get-StatusLabel $radialInstalled)"
        Write-Host " V) Control de volumen rapido $(Get-StatusLabel $volInstalled)"
        Write-Host ""

        Write-Host "Sistema:"
        Write-Host " W) Apps de Windows (no esenciales)"
        Write-Host ""

        Write-Host " 0) Volver"
        Write-Host ""

        $opt = Read-Host "Seleccione una opcion"

        switch ($opt.ToUpper()) {

            "1" {
                if ($steamInstalled -and (Confirm-Action "¿Seguro que deseas desinstalar Steam?")) {
                    Uninstall-Steam
                }
            }

            "R" {
                if ($radialInstalled -and (Confirm-Action "¿Seguro que deseas eliminar Black Console Radial?")) {
                    & "$PSScriptRoot\..\blackconsole_radial\uninstall.ps1"
                    Pause
                }
            }

            "V" {
                if ($volInstalled -and (Confirm-Action "¿Seguro que deseas eliminar el control de volumen?")) {
                    & "$PSScriptRoot\..\volume_control\uninstall.ps1"
                    Pause
                }
            }

            "W" {
                if (Confirm-Action "Se eliminaran apps de Windows no esenciales. ¿Deseas continuar?") {
                    Uninstall-WindowsApps
                }
            }

            "0" { return }

            default {
                Write-Host "Opcion invalida" -ForegroundColor Red
                Start-Sleep -Seconds 1
            }
        }
    }
}
