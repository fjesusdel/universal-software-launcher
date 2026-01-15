# ==================================================
# UI - BLACK CONSOLE
# ==================================================

function Show-Banner {

    Write-Host "============================================================"
    Write-Host "||                                                        ||"
    Write-Host "||   ____  _            _      ____                      ||"
    Write-Host "||  | __ )| | __ _  ___| | __ / ___| ___  _ __            ||"
    Write-Host "||  |  _ \| |/ _ |/ __| |/ /| |    / _ \| '_ \           ||"
    Write-Host "||  | |_) | | (_| | (__|   < | |___| (_) | | | |          ||"
    Write-Host "||  |____/|_|\__,_|\___|_|\_\ \____|\___/|_| |_|          ||"
    Write-Host "||                                                        ||"
    Write-Host "||                    BLACK CONSOLE                       ||"
    Write-Host "||                                                        ||"
    Write-Host "============================================================"
    Write-Host ""
}

function Show-Signature {

    Write-Host "Autor: $($Global:BlackConsole.Author)"
    Write-Host "Version: $($Global:BlackConsole.Version)"
    Write-Host ""

    if ($Global:StartupPhrases) {
        $phrase = Get-Random -InputObject $Global:StartupPhrases
        Write-Host $phrase
        Write-Host ""
    }
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
    Write-Host " [7] Mozilla Firefox"
    Write-Host " [8] 7-Zip"
    Write-Host " [9] NVIDIA App"
    Write-Host " [10] Ultimaker Cura"
    Write-Host ""

    Write-Host "OTRAS OPCIONES"
    Write-Host " [U] Desinstalar software"
    Write-Host " [A] Acerca de Black Console"
    Write-Host " [0] Salir"
    Write-Host ""
}

# ==================================================
# HELPERS DE UI / UX
# ==================================================

function Confirm-Action {
    param (
        [string]$Message
    )

    Write-Host ""
    $response = Read-Host "$Message (s/n)"
    return ($response.ToLower() -eq "s")
}

function Write-Success {
    param($Message)
    Write-Host "[OK] $Message" -ForegroundColor Green
}

function Write-ErrorMessage {
    param($Message)
    Write-Host "[ERROR] $Message" -ForegroundColor Red
}

function Write-WarningMessage {
    param($Message)
    Write-Host "[WARN] $Message" -ForegroundColor Yellow
}

function Pause {
    Write-Host ""
    Read-Host "Pulsa ENTER para continuar"
}
