# ==================================================
# UNINSTALL MENU - BLACK CONSOLE
# ==================================================

# Cargar dependencias
$LibPath = Join-Path $PSScriptRoot "..\lib"

. (Join-Path $LibPath "config.ps1")
. (Join-Path $LibPath "ui.ps1")
. (Join-Path $LibPath "installer.ps1")

# ==================================================
# MENU DE DESINSTALACION
# ==================================================

function Show-UninstallMenu {

    do {
        Clear-Host
        Show-Banner
        Show-Signature

        Write-Host "ELIMINAR SOFTWARE" -ForegroundColor Cyan
        Write-Host "-----------------" -ForegroundColor DarkGray
        Write-Host ""

        Write-Host "APLICACIONES BLACK CONSOLE"
        Write-Host " R) Black Console Radial HUD"
        Write-Host " V) Control de volumen rapido"
        Write-Host ""
        Write-Host " 0) Volver"
        Write-Host ""

        $option = Read-Host "Seleccione una opcion"

        switch ($option.ToUpper()) {

            "R" {
                if (Confirm-Action "¿Eliminar Black Console Radial HUD?") {
                    try {
                        Uninstall-BlackConsoleRadial
                        Write-Success "Radial HUD eliminado correctamente."
                    }
                    catch {
                        Write-ErrorMessage "Error al eliminar el Radial HUD."
                        Write-Host $_
                    }
                    Pause
                }
            }

            "V" {
                if (Confirm-Action "¿Eliminar el control de volumen rapido?") {
                    try {
                        Uninstall-QuickVolumeControl
                        Write-Success "Control de volumen eliminado correctamente."
                    }
                    catch {
                        Write-ErrorMessage "Error al eliminar el control de volumen."
                        Write-Host $_
                    }
                    Pause
                }
            }

            "0" {
                return
            }

            default {
                Write-WarningMessage "Opcion no valida."
                Start-Sleep -Seconds 1
            }
        }

    } while ($true)
}
