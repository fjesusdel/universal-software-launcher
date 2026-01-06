function Show-Banner {

    Clear-Host

    Write-Host "============================================================" -ForegroundColor DarkGray
    Write-Host "||                                                        ||" -ForegroundColor DarkGray
    Write-Host "||   ____  _            _      ____                      ||" -ForegroundColor Cyan
    Write-Host "||  | __ )| | __ _  ___| | __ / ___| ___  _ __            ||" -ForegroundColor Cyan
    Write-Host "||  |  _ \| |/ _ |/ __| |/ /| |    / _ \| '_ \           ||" -ForegroundColor Cyan
    Write-Host "||  | |_) | | (_| | (__|   < | |___| (_) | | | |          ||" -ForegroundColor Cyan
    Write-Host "||  |____/|_|\__,_|\___|_|\_\ \____|\___/|_| |_|          ||" -ForegroundColor Cyan
    Write-Host "||                                                        ||" -ForegroundColor DarkGray
    Write-Host "||                    BLACK CONSOLE                       ||" -ForegroundColor White
    Write-Host "||                                                        ||" -ForegroundColor DarkGray
    Write-Host "============================================================" -ForegroundColor DarkGray
    Write-Host ""
}

function Show-Signature {

    $phrase = Get-Random -InputObject $Global:StartupPhrases

    Write-Host "$($Global:BlackConsole.Name)" -ForegroundColor White
    Write-Host "Autor: $($Global:BlackConsole.Author)" -ForegroundColor DarkGray
    Write-Host "Version: $($Global:BlackConsole.Version)" -ForegroundColor DarkGray
    Write-Host ""
    Write-Host $phrase -ForegroundColor Cyan
    Write-Host ""
}

function Show-Menu {

    Write-Host "INSTALACION AUTOMATICA"
    Write-Host " [1] Prepare New PC (Recommended)"
    Write-Host ""
    Write-Host "INSTALACION MANUAL"
    Write-Host " [2] Google Chrome"
    Write-Host " [3] WinRAR"
    Write-Host " [4] Discord"
    Write-Host " [5] VirtualBox"
    Write-Host ""
    Write-Host "APLICACIONES AVANZADAS"
    Write-Host " [6] Steam"
    Write-Host " [7] WhatsApp Desktop"
    Write-Host " [8] Mozilla Firefox"
    Write-Host " [9] 7-Zip"
    Write-Host " [10] NVIDIA App"
    Write-Host " [11] Ultimaker Cura"
    Write-Host ""
    Write-Host "OTRAS OPCIONES"
    Write-Host " [A] Acerca de Black Console"
    Write-Host " [0] Salir"
    Write-Host ""
}

function Show-About {

    Clear-Host

    Write-Host "Acerca de Black Console" -ForegroundColor Cyan
    Write-Host "--------------------------------------------"
    Write-Host ""
    Write-Host "Black Console es una herramienta de preparacion"
    Write-Host "y despliegue para sistemas Windows."
    Write-Host ""
    Write-Host "Principios:"
    Write-Host " - No modifica el sistema sin avisar."
    Write-Host " - No fuerza decisiones al usuario."
    Write-Host " - No utiliza software no oficial."
    Write-Host " - No aplica cambios irreversibles."
    Write-Host " - Automatiza tareas comunes de forma segura."
    Write-Host ""
    Write-Host "Objetivo:"
    Write-Host " Reducir el tiempo necesario para dejar un"
    Write-Host " sistema listo para su uso manteniendo el"
    Write-Host " control en manos del usuario."
    Write-Host ""
    Pause
}
