function Prepare-NewPC {

    Clear-Host

    $Installed = @()
    $Failed    = @()
    $Removed   = @()

    Write-Host "Prepare New PC (Recommended)" -ForegroundColor Cyan
    Write-Host "----------------------------------------------"
    Write-Host ""

    Write-VerboseInfo "Mostrando resumen previo al usuario"

    Write-Host "Se va a preparar el equipo con las siguientes acciones:"
    Write-Host ""

    Write-Host "SOFTWARE QUE SE INSTALARA:"
    @(
        "Google Chrome",
        "WinRAR",
        "Discord",
        "Microsoft Visual C++ Redistributables",
        ".NET Desktop Runtime"
    ) | ForEach-Object { Write-Host " - $_" }

    Write-Host ""
    Write-Host "CARPETAS QUE SE CREARAN:"
    Write-Host " - C:\BlackConsole"

    Write-Host ""
    Write-Host "APLICACIONES QUE SE DESINSTALARAN:"
    $bloatware = @(
        "Microsoft.XboxApp",
        "Microsoft.XboxGamingOverlay",
        "Microsoft.XboxGameOverlay",
        "Microsoft.XboxSpeechToTextOverlay",
        "Microsoft.549981C3F5F10",
        "Microsoft.Clipchamp",
        "Microsoft.MicrosoftSolitaireCollection",
        "Microsoft.BingWeather",
        "Microsoft.BingNews",
        "Microsoft.GetHelp",
        "Microsoft.Getstarted",
        "Microsoft.People",
        "Microsoft.SkypeApp",
        "Microsoft.MixedReality.Portal",
        "Microsoft.WindowsMaps"
    )
    $bloatware | ForEach-Object { Write-Host " - $_" }

    Write-Host ""
    $confirm = Read-Host "¿Desea continuar con la preparacion del sistema? (S/N)"
    if ($confirm.ToUpper() -ne "S") {
        Write-Host "Operacion cancelada por el usuario." -ForegroundColor Yellow
        return
    }

    Write-VerboseInfo "Usuario confirmo la ejecucion"

    if (-not (Test-Path "C:\BlackConsole")) {
        Write-VerboseInfo "Creando carpeta C:\BlackConsole"
        New-Item -ItemType Directory -Path "C:\BlackConsole" | Out-Null
    }

    $steps = @(
        @{ Name = "Google Chrome"; Action = { Install-Chrome } },
        @{ Name = "WinRAR"; Action = { Install-WinRAR } },
        @{ Name = "Discord"; Action = { Install-Discord } },
        @{ Name = "Visual C++ Redistributables"; Action = { Install-VCRedist } },
        @{ Name = ".NET Desktop Runtime"; Action = { Install-DotNetDesktop } }
    )

    foreach ($step in $steps) {
        try {
            Write-VerboseInfo "Ejecutando instalador: $($step.Name)"
            & $step.Action
            $Installed += $step.Name
        } catch {
            $Failed += $step.Name
        }
    }

    Write-Host ""
    Write-Host "Eliminando aplicaciones no esenciales..." -ForegroundColor Cyan

    foreach ($app in $bloatware) {
        try {
            Write-VerboseInfo "Procesando app UWP: $app"
            $pkg = Get-AppxPackage -Name $app -AllUsers -ErrorAction SilentlyContinue
            if ($pkg) {
                $pkg | Remove-AppxPackage -ErrorAction SilentlyContinue
                $Removed += $app
            }
        } catch {}
    }

    Start-Process "ms-settings:defaultapps"

    Write-Host ""
    Write-Host "Resumen de la preparacion del sistema" -ForegroundColor Cyan
    Write-Host ""

    $Installed | ForEach-Object { Write-Host " - $_" }
    Write-Host ""
    Write-Host "Aplicaciones eliminadas: $($Removed.Count)"
    if ($Failed.Count -gt 0) {
        Write-Host ""
        Write-Host "Acciones con errores:" -ForegroundColor Yellow
        $Failed | ForEach-Object { Write-Host " - $_" }
    }

    Write-Host ""
    Write-Host "Preparacion finalizada." -ForegroundColor Green
}
