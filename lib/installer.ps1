function Install-Exe {
    param (
        [string]$Name,
        [string]$Check,
        [string]$Url,
        [string]$Args
    )

    # Comprobación previa
    if (Is-Installed $Check) {
        Write-Host "[SKIP] $Name ya está instalado`n" -ForegroundColor Yellow
        return
    }

    # Ruta temporal del instalador
    $Tmp = "$env:TEMP\$($Name.Replace(' ','_')).exe"

    Write-Host "[*] Descargando $Name..."
    Invoke-WebRequest -Uri $Url -OutFile $Tmp

    Write-Host "[*] Instalando $Name..."

    # IMPORTANTE: solo pasar ArgumentList si existe
    if ([string]::IsNullOrWhiteSpace($Args)) {
        Start-Process -FilePath $Tmp -Wait -NoNewWindow
    }
    else {
        Start-Process -FilePath $Tmp -ArgumentList $Args -Wait -NoNewWindow
    }

    Write-Host "[OK] $Name instalado correctamente`n" -ForegroundColor Green
}

function Install-Office2024 {
    param (
        [string]$Xml
    )

    if (Is-Installed "Office") {
        Write-Host "[SKIP] Office ya instalado`n" -ForegroundColor Yellow
        return
    }

    $Dir = "$env:TEMP\Office2024"

    if (-not (Test-Path $Dir)) {
        New-Item -ItemType Directory -Path $Dir | Out-Null
    }

    Write-Host "[*] Descargando Office Deployment Tool..."
    Invoke-WebRequest `
        -Uri "https://www.microsoft.com/fwlink/?linkid=2156295" `
        -OutFile "$Dir\odt.exe"

    Write-Host "[*] Extrayendo ODT..."
    Start-Process "$Dir\odt.exe" "/quiet /extract:$Dir" -Wait

    Write-Host "[*] Instalando Office 2024..."
    Start-Process "$Dir\setup.exe" "/configure `"$Xml`"" -Wait

    Write-Host "[OK] Office 2024 instalado correctamente`n" -ForegroundColor Green
}
