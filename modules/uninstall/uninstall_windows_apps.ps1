function Uninstall-WindowsApps {

    # Desactivar progreso para evitar barras azules
    $oldProgress = $ProgressPreference
    $ProgressPreference = 'SilentlyContinue'

    Clear-Host
    Show-Banner
    Show-Signature

    Write-Host ""
    Write-Host "ELIMINAR APPS DE WINDOWS NO ESENCIALES" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "Se intentara eliminar aplicaciones preinstaladas como:" -ForegroundColor DarkGray
    Write-Host " - Xbox"
    Write-Host " - Clipchamp"
    Write-Host " - Cortana"
    Write-Host " - Noticias"
    Write-Host " - El Tiempo"
    Write-Host ""
    Write-Host "Algunas apps del sistema pueden NO eliminarse por seguridad."
    Write-Host ""

    if (-not (Confirm-Action "¿Deseas continuar?")) {
        $ProgressPreference = $oldProgress
        return
    }

    $Apps = @(
        "Microsoft.Xbox*",
        "Microsoft.Clipchamp*",
        "Microsoft.BingNews*",
        "Microsoft.BingWeather*",
        "Microsoft.GetHelp*",
        "Microsoft.Getstarted*",
        "Microsoft.549981C3F5F10*" # Cortana
    )

    $Failed = @()

    foreach ($app in $Apps) {

        # Quitar provisionamiento (nuevos usuarios)
        Get-AppxProvisionedPackage -Online |
            Where-Object { $_.DisplayName -like $app } |
            ForEach-Object {
                try {
                    Remove-AppxProvisionedPackage -Online `
                        -PackageName $_.PackageName `
                        -ErrorAction Stop | Out-Null
                } catch {
                    $Failed += $_.DisplayName
                }
            }

        # Quitar para usuario actual
        Get-AppxPackage -Name $app -ErrorAction SilentlyContinue |
            ForEach-Object {
                try {
                    Remove-AppxPackage `
                        -Package $_.PackageFullName `
                        -ErrorAction Stop | Out-Null
                } catch {
                    $Failed += $_.Name
                }
            }
    }

    # Restaurar progreso
    $ProgressPreference = $oldProgress

    Clear-Host
    Show-Banner
    Show-Signature

    Write-Host ""
    Write-Host "[OK] Proceso de limpieza finalizado." -ForegroundColor Green

    if ($Failed.Count -gt 0) {
        Write-Host ""
        Write-Host "Algunas apps no se pudieron eliminar por restricciones del sistema:" -ForegroundColor Yellow
        $Failed | Sort-Object -Unique | ForEach-Object {
            Write-Host " - $_" -ForegroundColor DarkGray
        }
    }

    Write-Host ""
    Write-Host "Windows permanece estable. No se han eliminado componentes criticos." -ForegroundColor Cyan
    Pause
}
