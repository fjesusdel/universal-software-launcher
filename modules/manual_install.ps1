function Show-ManualInstallMenu {

    while ($true) {

        Clear-Host
        Show-Banner
        Show-Signature

        Write-Host ""
        Write-Host "INSTALAR SOFTWARE" -ForegroundColor Cyan
        Write-Host "-----------------" -ForegroundColor Cyan
        Write-Host ""

        Write-Host " 1) Google Chrome"
        Write-Host " 2) WinRAR"
        Write-Host " 3) Discord"
        Write-Host " 4) VirtualBox"
        Write-Host ""
        Write-Host "Aplicaciones avanzadas:"
        Write-Host " 5) Steam"
        Write-Host " 6) Mozilla Firefox"
        Write-Host " 7) 7-Zip"
        Write-Host " 8) NVIDIA App"
        Write-Host " 9) Ultimaker Cura"
        Write-Host ""
        Write-Host " 0) Volver"
        Write-Host ""

        $opt = Read-Host "Seleccione una opcion"

        switch ($opt) {

            "1" { Install-Chrome }
            "2" { Install-WinRAR }
            "3" { Install-Discord }
            "4" { Install-VirtualBox }

            "5" { Install-Steam }
            "6" { Install-Firefox }
            "7" { Install-7Zip }
            "8" { Install-NvidiaApp }
            "9" { Install-UltimakerCura }

            "0" { return }

            default {
                Write-Host "Opcion invalida" -ForegroundColor Red
                Start-Sleep 1
            }
        }

        Pause
    }
}
