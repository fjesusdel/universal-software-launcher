# ==================================================
# INSTALACION POR LOTES - BLACK CONSOLE
# ==================================================

function Start-BatchInstall {

    Clear-Host
    Show-Banner
    Show-Signature

    Write-Host ""
    Write-Host "INSTALACION POR LOTES" -ForegroundColor Cyan
    Write-Host "---------------------" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "Seleccione que software desea instalar."
    Write-Host "Las aplicaciones ya instaladas se omitiran automaticamente."
    Write-Host ""

    $Queue = @()

    function Ask($Name, $Installed, $Action) {
        Write-Host ""
        Write-Host "$Name $(Get-StatusLabel $Installed)"
        if ($Installed) { return }
        $ans = Read-Host "¿Instalar? (s/n)"
        if ($ans.ToLower() -eq "s") {
            $Queue += $Action
        }
    }

    Ask "Google Chrome"       (Test-ChromeInstalled)          { Install-Chrome }
    Ask "WinRAR"              (Test-WinRARInstalled)          { Install-WinRAR }
    Ask "Discord"             (Test-DiscordInstalled)         { Install-Discord }
    Ask "VirtualBox"          (Test-VirtualBoxInstalled)      { Install-VirtualBox }

    Ask "Steam"               (Test-SteamInstalled)           { Install-Steam }
    Ask "Mozilla Firefox"     (Test-FirefoxInstalled)         { Install-Firefox }
    Ask "7-Zip"               (Test-7ZipInstalled)            { Install-7Zip }
    Ask "NVIDIA App"          (Test-NvidiaAppInstalled)       { Install-NvidiaApp }
    Ask "Ultimaker Cura"      (Test-UltimakerCuraInstalled)   { Install-UltimakerCura }

    Ask "Black Console Radial HUD" (Test-RadialInstalled)      { Install-BlackConsoleRadial }
    Ask "Control de volumen rapido" (Test-VolumeInstalled)    { Install-VolumeControl }

    if ($Queue.Count -eq 0) {
        Write-Host ""
        Write-Host "No se ha seleccionado ninguna aplicacion." -ForegroundColor Yellow
        Pause
        return
    }

    if (-not (Confirm-Action "¿Confirmar instalacion del lote seleccionado?")) {
        return
    }

    Clear-Host
    Show-Banner
    Show-Signature
    Write-Host ""
    Write-Host "Iniciando instalacion por lotes..." -ForegroundColor Cyan
    Write-Host ""

    foreach ($job in $Queue) {
        try {
            & $job
        } catch {
            Write-Host "[ERROR] Fallo en una instalacion, continuando..." -ForegroundColor Red
        }
        Write-Host ""
    }

    Write-Host "[OK] Instalacion por lotes finalizada." -ForegroundColor Green
    Pause
}
