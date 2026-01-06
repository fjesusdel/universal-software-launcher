# ==================================================
# PRECHECKS - BLACK CONSOLE
# ==================================================

function Test-IsAdmin {
    $id = [Security.Principal.WindowsIdentity]::GetCurrent()
    $p  = New-Object Security.Principal.WindowsPrincipal($id)
    return $p.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

function Test-Internet {
    try {
        Test-Connection -ComputerName "8.8.8.8" -Count 1 -Quiet
    } catch { $false }
}

function Test-FreeDiskGB {
    param([int]$MinGB = 10)
    $drive = Get-PSDrive -Name C
    return [math]::Round($drive.Free / 1GB) -ge $MinGB
}

function Run-Prechecks {

    Write-Host "Comprobaciones previas del sistema" -ForegroundColor Cyan
    Write-Host "----------------------------------"

    $errors = @()

    if (-not (Test-IsAdmin)) {
        $errors += "No se esta ejecutando como administrador."
    }

    if (-not (Test-Internet)) {
        $errors += "No hay conexion a internet."
    }

    if (-not (Test-FreeDiskGB 10)) {
        $errors += "Espacio insuficiente en disco (minimo 10 GB)."
    }

    if ($errors.Count -gt 0) {
        Write-Host ""
        Write-Host "No se puede continuar:" -ForegroundColor Red
        $errors | ForEach-Object { Write-Host " - $_" }
        Write-Host ""
        Read-Host "Pulse ENTER para volver al menu"
        return $false
    }

    Write-Host "Sistema listo para continuar." -ForegroundColor Green
    Write-Host ""
    return $true
}
