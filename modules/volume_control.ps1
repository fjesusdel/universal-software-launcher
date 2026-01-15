# ==================================================
# BLACK CONSOLE - CONTROL DE VOLUMEN
# ==================================================

function Install-VolumeControl {

    Write-Host "[*] Instalando Control de Volumen rápido..." -ForegroundColor Cyan

    $binPath = "C:\BlackConsole\bin"
    $exe     = Join-Path $binPath "volume.exe"

    if (Test-Path $exe) {
        Write-Host "[SKIP] El control de volumen ya está instalado." -ForegroundColor Yellow
        return
    }

    New-Item -ItemType Directory -Path $binPath -Force | Out-Null

    $source = Join-Path $PSScriptRoot "..\assets\volume\volume.exe"

    if (-not (Test-Path $source)) {
        Write-Host "[ERROR] volume.exe no encontrado." -ForegroundColor Red
        return
    }

    Copy-Item $source $exe -Force

    $startup = "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Startup"
    $lnk = Join-Path $startup "BlackConsole Volume.lnk"

    $wsh = New-Object -ComObject WScript.Shell
    $sc = $wsh.CreateShortcut($lnk)
    $sc.TargetPath = $exe
    $sc.Save()

    Write-Host "[OK] Control de volumen instalado y activado." -ForegroundColor Green
}
