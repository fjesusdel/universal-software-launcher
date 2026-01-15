Write-Host "=== Desinstalando Control de Volumen ===" -ForegroundColor Cyan
Write-Host ""

$Exe = "C:\BlackConsole\bin\volume.exe"

Get-Process | Where-Object { $_.Path -eq $Exe } -ErrorAction SilentlyContinue |
    Stop-Process -Force

Remove-ItemProperty `
    -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Run" `
    -Name "BlackConsoleVolumeControl" `
    -ErrorAction SilentlyContinue

if (Test-Path $Exe) {
    Remove-Item $Exe -Force
}

Write-Host "[OK] Control de volumen eliminado." -ForegroundColor Green
