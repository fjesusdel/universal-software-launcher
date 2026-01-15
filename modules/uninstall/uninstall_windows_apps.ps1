function Uninstall-WindowsApps {

    Clear-Host
    Show-Banner
    Show-Signature

    Write-Host ""
    Write-Host "ELIMINANDO APPS DE WINDOWS NO ESENCIALES" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "Se eliminaran aplicaciones como:" -ForegroundColor DarkGray
    Write-Host " - Xbox"
    Write-Host " - Clipchamp"
    Write-Host " - Cortana"
    Write-Host " - Noticias"
    Write-Host " - El Tiempo"
    Write-Host ""

    $Apps = @(
        "*Xbox*",
        "*Clipchamp*",
        "*Cortana*",
        "*BingNews*",
        "*BingWeather*",
        "*GetHelp*",
        "*GetStarted*"
    )

    foreach ($app in $Apps) {
        Get-AppxPackage -Name $app -AllUsers |
            Remove-AppxPackage -AllUsers -ErrorAction SilentlyContinue
    }

    Write-Host ""
    Write-Host "[OK] Apps de Windows eliminadas." -ForegroundColor Green
    Pause
}
