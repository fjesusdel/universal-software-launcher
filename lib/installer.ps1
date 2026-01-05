function Install-Exe {
    param (
        [string]$Name,
        [string]$Check,
        [string]$Url,
        [string]$Args
    )

    if (Is-Installed $Check) {
        Write-Host "[SKIP] $Name ya está instalado`n" -ForegroundColor Yellow
        return
    }

    $Tmp = "$env:TEMP\$($Name.Replace(' ','_')).exe"

    Write-Host "[*] Descargando $Name..."
    Invoke-WebRequest $Url -OutFile $Tmp

    Write-Host "[*] Instalando $Name..."
    Start-Process $Tmp -ArgumentList $Args -Wait -NoNewWindow

    Write-Host "[OK] $Name instalado`n" -ForegroundColor Green
}

function Install-Office2024 {
    param ([string]$Xml)

    if (Is-Installed "Office") {
        Write-Host "[SKIP] Office ya instalado`n" -ForegroundColor Yellow
        return
    }

    $Dir = "$env:TEMP\Office2024"
    New-Item $Dir -ItemType Directory -Force | Out-Null

    Invoke-WebRequest "https://www.microsoft.com/fwlink/?linkid=2156295" `
        -OutFile "$Dir\odt.exe"

    Start-Process "$Dir\odt.exe" "/quiet /extract:$Dir" -Wait
    Start-Process "$Dir\setup.exe" "/configure `"$Xml`"" -Wait

    Write-Host "[OK] Office 2024 instalado`n" -ForegroundColor Green
}
