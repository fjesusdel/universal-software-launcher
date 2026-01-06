# ==================================================
# SYSTEM DIAGNOSTIC - BLACK CONSOLE
# ==================================================

function Show-SystemDiagnostic {

    Clear-Host
    Write-Host "Diagnostico del sistema" -ForegroundColor Cyan
    Write-Host "------------------------"
    Write-Host ""

    $os = Get-CimInstance Win32_OperatingSystem
    $cpu = Get-CimInstance Win32_Processor | Select-Object -First 1
    $ram = [Math]::Round($os.TotalVisibleMemorySize / 1MB, 2)

    Write-Host "Sistema operativo:"
    Write-Host " - $($os.Caption) $($os.Version)"
    Write-Host ""

    Write-Host "Procesador:"
    Write-Host " - $($cpu.Name)"
    Write-Host ""

    Write-Host "Memoria RAM:"
    Write-Host " - $ram GB"
    Write-Host ""

    Write-Host "Tarjeta grafica:"
    Get-CimInstance Win32_VideoController | ForEach-Object {
        Write-Host " - $($_.Name)"
    }

    Write-Host ""
    Write-Host "Software clave instalado:"
    @(
        "Google Chrome",
        "WinRAR",
        "Discord",
        "Steam",
        "Mozilla Firefox"
    ) | ForEach-Object {
        if (Is-ProgramInstalled $_) {
            Write-Host " - $_ : SI" -ForegroundColor Green
        } else {
            Write-Host " - $_ : NO" -ForegroundColor DarkGray
        }
    }

    Write-Host ""
    Write-Host "Pulse cualquier tecla para volver al menu..." -ForegroundColor DarkGray
    [void][System.Console]::ReadKey($true)
}
