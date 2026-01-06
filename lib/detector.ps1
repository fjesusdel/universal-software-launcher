function Is-Installed {
    param (
        [string]$Name
    )

    $registryPaths = @(
        "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall",
        "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall",
        "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall"
    )

    foreach ($path in $registryPaths) {
        if (Test-Path $path) {
            $apps = Get-ChildItem $path -ErrorAction SilentlyContinue |
                Get-ItemProperty -ErrorAction SilentlyContinue |
                Where-Object { $_.DisplayName -and $_.DisplayName -like "*$Name*" }

            if ($apps) {
                return $true
            }
        }
    }

    return $false
}

function Test-Discord {
    # Metodo 1: registro por usuario
    if (Is-Installed "Discord") {
        return $true
    }

    # Metodo 2: carpeta AppData
    $discordPath = Join-Path $env:LOCALAPPDATA "Discord"
    if (Test-Path $discordPath) {
        return $true
    }

    # Metodo 3: proceso en ejecucion
    if (Get-Process -Name "Discord" -ErrorAction SilentlyContinue) {
        return $true
    }

    return $false
}

function Show-Installed {

    Write-Host ""
    Write-Host "Installed software status:" -ForegroundColor Cyan
    Write-Host "---------------------------------------------"

    # Office
    if (Is-Installed "Office") {
        Write-Host "[OK] Microsoft Office" -ForegroundColor Green
    } else {
        Write-Host "[  ] Microsoft Office" -ForegroundColor Yellow
    }

    # Chrome
    if (Is-Installed "Chrome") {
        Write-Host "[OK] Google Chrome" -ForegroundColor Green
    } else {
        Write-Host "[  ] Google Chrome" -ForegroundColor Yellow
    }

    # WinRAR
    if (Is-Installed "WinRAR") {
        Write-Host "[OK] WinRAR" -ForegroundColor Green
    } else {
        Write-Host "[  ] WinRAR" -ForegroundColor Yellow
    }

    # VirtualBox
    if (Is-Installed "VirtualBox") {
        Write-Host "[OK] VirtualBox" -ForegroundColor Green
    } else {
        Write-Host "[  ] VirtualBox" -ForegroundColor Yellow
    }

    # Discord (deteccion especial)
    if (Test-Discord) {
        Write-Host "[OK] Discord" -ForegroundColor Green
    } else {
        Write-Host "[  ] Discord" -ForegroundColor Yellow
    }

    Write-Host ""
}
