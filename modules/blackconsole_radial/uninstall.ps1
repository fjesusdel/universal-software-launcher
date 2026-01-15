Write-Host "=== Desinstalando Black Console Radial ===" -ForegroundColor Cyan
Write-Host ""

$SkinPath = "$env:USERPROFILE\Documents\Rainmeter\Skins\BlackConsole"
$Marker   = "C:\BlackConsole\.rainmeter_installed"

if (Test-Path $SkinPath) {
    Remove-Item $SkinPath -Recurse -Force
    Write-Host "[OK] Skin eliminada."
}

if (Test-Path $Marker) {
    Write-Host "[*] Desinstalando Rainmeter..."
    Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* |
        Where-Object { $_.DisplayName -like "*Rainmeter*" } |
        ForEach-Object {
            Start-Process "cmd.exe" "/c $($_.UninstallString)" -Wait
        }
    Remove-Item $Marker -Force
}

Write-Host ""
Write-Host "[OK] Radial eliminado completamente." -ForegroundColor Green
