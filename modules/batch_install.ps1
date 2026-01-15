# ==================================================
# INSTALACION POR LOTES - BLACK CONSOLE
# ==================================================

# Cargar instaladores clasicos
$InstallerPath = Join-Path $PSScriptRoot "..\lib\installer.ps1"
. $InstallerPath

function Start-BatchInstall {

    Clear-Host
    Show-Banner
    Show-Signature

    Write-Host ""
    Write-Host "INSTALACION POR LOTES" -ForegroundColor Cyan
    Write-Host "---------------------" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "Seleccione que software desea instalar." -ForegroundColor DarkGray
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

    # ---------- Aplicaciones ----------
    Ask "Google Chrome"      (Is-ProgramInstalled "Google Chrome")      { Install-Chrome }
    Ask "WinRAR"             (Is-ProgramInstalled "WinRAR")             { Install-WinRAR }
    Ask "Discord"            (Test-DiscordInstalled)                     { Install-Discord }
    Ask "VirtualBox"         (Is-ProgramInstalled "Oracle VM VirtualBox"){ Install-VirtualBox }

    # ---------- Avanzadas ----------
    Ask "Steam"              (Is-ProgramInstalled "Steam")               { Install-Steam }
    Ask "Mozilla Firefox"    (Is-ProgramInstalled "Mozilla Firefox")     { Install-Firefox }
    Ask "7-Zip"              (Is-ProgramInstalled "7-Zip")               { Install-7Zip }
    Ask "NVIDIA App"         (Is-ProgramInstalled "NVIDIA App")           { Install-NvidiaApp }
    Ask "Ultimaker Cura"     (Is-ProgramInstalled "Ultimaker Cura")      { Install-UltimakerCura }

    # ---------- Black Console ----------
    Ask "Black Console Radial HUD" (Test-RadialInstalled)  { Install-BlackConsoleRadial }
    Ask "Control de volumen rapido" (Test-VolumeInstalled){ Install-VolumeControl }

    if ($Queue.Count -eq 0) {
        Write-Host ""
        Write-Host "No se ha seleccionado ninguna aplicacion." -ForegroundColor Yellow
        Pause
        return
    }

    Write-Host ""
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
