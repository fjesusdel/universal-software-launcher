# ==================================================
# PREPARE NEW PC - BLACK CONSOLE (FASE 2)
# ==================================================

function Prepare-NewPC {

    Clear-Host
    Write-Host "Prepare New PC" -ForegroundColor Cyan
    Write-Host "--------------"
    Write-Host ""

    if (-not (Run-Prechecks)) {
        return
    }

    Write-Host "Seleccione un preset:"
    Write-Host " [1] Basico"
    Write-Host " [2] Gaming"
    Write-Host " [3] Trabajo"
    Write-Host " [0] Cancelar"
    Write-Host ""

    $choice = Read-Host "Opcion"
    if ($choice -eq "0") { return }

    $presets = Get-PreparePresets
    if (-not $presets.ContainsKey($choice)) {
        Write-Host "Opcion invalida" -ForegroundColor Red
        Start-Sleep 1
        return
    }

    $preset = $presets[$choice]

    Clear-Host
    Write-Host "Preset seleccionado: $($preset.Name)" -ForegroundColor Cyan
    Write-Host ""

    # -------------------------------
    # MOSTRAR INSTALACIONES
    # -------------------------------
    Write-Host "SOFTWARE QUE SE INSTALARA:"
    $preset.Install | ForEach-Object {
        Write-Host " - $_"
    }

    Write-Host ""

    # -------------------------------
    # MOSTRAR DESINSTALACIONES
    # -------------------------------
    Write-Host "APLICACIONES QUE SE DESINSTALARAN:"
    $preset.Remove | ForEach-Object {
        Write-Host " - $_"
    }

    Write-Host ""
    Write-Host "No se eliminaran aplicaciones criticas del sistema."
    Write-Host ""

    $confirm = Read-Host "¿Desea continuar? (S/N)"
    if ($confirm.ToUpper() -ne "S") {
        Write-Host "Operacion cancelada por el usuario."
        Start-Sleep 1
        return
    }

    # -------------------------------
    # SNAPSHOT INICIAL
    # -------------------------------
    Write-Host ""
    Write-Host "Guardando snapshot inicial..."
    $before = Save-SystemSnapshot "before"

    $installed = @()
    $failed    = @()
    $removed   = @()

    # -------------------------------
    # INSTALACIONES
    # -------------------------------
    foreach ($app in $preset.Install) {
        try {
            switch ($app) {
                "Google Chrome"   { Install-Chrome }
                "WinRAR"          { Install-WinRAR }
                "Mozilla Firefox" { Install-Firefox }
                "7-Zip"           { Install-7Zip }
                "Steam"           { Install-Steam }
                "NVIDIA App"      { Install-NvidiaApp }
                "Microsoft Office"{ Install-Office2024 }
            }
            $installed += $app
        } catch {
            $failed += $app
        }
    }

    # -------------------------------
    # DESINSTALACION DE BLOATWARE
    # -------------------------------
    foreach ($pkg in $preset.Remove) {
        try {
            Get-AppxPackage -Name $pkg -AllUsers -ErrorAction SilentlyContinue |
                Remove-AppxPackage -ErrorAction SilentlyContinue
            $removed += $pkg
        } catch {
            # no critico
        }
    }

    # -------------------------------
    # SNAPSHOT FINAL
    # -------------------------------
    Write-Host ""
    Write-Host "Guardando snapshot final..."
    $after = Save-SystemSnapshot "after"

    # -------------------------------
    # RESUMEN FINAL
    # -------------------------------
    Clear-Host
    Write-Host "Resumen final" -ForegroundColor Cyan
    Write-Host "-------------"
    Write-Host ""

    Write-Host "Instalado correctamente:"
    $installed | ForEach-Object { Write-Host " - $_" }

    if ($removed.Count -gt 0) {
        Write-Host ""
        Write-Host "Aplicaciones eliminadas:"
        $removed | ForEach-Object { Write-Host " - $_" }
    }

    if ($failed.Count -gt 0) {
        Write-Host ""
        Write-Host "Errores durante el proceso:" -ForegroundColor Yellow
        $failed | ForEach-Object { Write-Host " - $_" }
    }

    Write-Host ""
    Write-Host "Black Console ha dejado el sistema listo." -ForegroundColor Green
    Write-Host ""
    Write-Host "Snapshots guardados en:"
    Write-Host " $before"
    Write-Host " $after"
}
