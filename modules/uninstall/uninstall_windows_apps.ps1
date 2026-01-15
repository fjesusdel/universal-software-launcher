function Uninstall-WindowsApps {

    Clear-Host
    Show-Banner
    Show-Signature

    Write-Host ""
    Write-Host "ELIMINAR APPS DE WINDOWS NO ESENCIALES" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "Se eliminaran aplicaciones preinstaladas como:" -ForegroundColor DarkGray
    Write-Host " - Xbox"
    Write-Host " - Clipchamp"
    Write-Host " - Cortana"
    Write-Host " - Noticias"
    Write-Host " - El Tiempo"
    Write-Host ""
    Write-Host "Esta accion NO elimina drivers ni rompe Windows."
    Write-Host ""

    if (-not (Confirm-Action "¿Deseas continuar?")) {
        return
    }

    $Apps = @(
        "Microsoft.Xbox*",
        "Microsoft.Clipchamp*",
        "Microsoft.BingNews",
        "Microsoft.BingWeather",
        "Microsoft.GetHelp",
        "Microsoft.Getstarted",
        "Microsoft.549981C3F5F10" # Cortana
    )

    foreach ($app in $Apps) {

        Get-AppxProvisionedPackage -Online |
            Where-Object { $_.DisplayName -like $app } |
            ForEach-Object {
                Remove-AppxProvisionedPackage -Online -PackageName $_.PackageName -ErrorAction SilentlyContinue
            }

        Get-AppxPackage -AllUsers -Name $app |
            Remove-AppxPackage -AllUsers -ErrorAction SilentlyContinue
    }

    Write-Host ""
    Write-Host "[OK] Apps de Windows eliminadas." -ForegroundColor Green
    Pause
}
