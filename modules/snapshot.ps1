# ==================================================
# SYSTEM SNAPSHOT - BLACK CONSOLE
# ==================================================

function Save-SystemSnapshot {
    param(
        [string]$Label
    )

    $base = "C:\BlackConsole\logs"
    if (-not (Test-Path $base)) {
        New-Item -ItemType Directory -Path $base | Out-Null
    }

    $ts = Get-Date -Format "yyyyMMdd-HHmmss"
    $file = "$base\snapshot-$Label-$ts.txt"

    $os = Get-CimInstance Win32_OperatingSystem
    $cpu = Get-CimInstance Win32_Processor | Select-Object -First 1
    $ram = [math]::Round($os.TotalVisibleMemorySize / 1MB, 1)

    @"
BLACK CONSOLE - SYSTEM SNAPSHOT ($Label)
---------------------------------------
Date: $(Get-Date)

OS: $($os.Caption) ($($os.Version))
CPU: $($cpu.Name)
RAM: ${ram} GB

INSTALLED SOFTWARE (TOP LEVEL):
"@ | Set-Content $file -Encoding UTF8

    Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* `
    | Select-Object DisplayName `
    | Where-Object { $_.DisplayName } `
    | Sort-Object DisplayName `
    | ForEach-Object { $_.DisplayName } `
    | Add-Content $file -Encoding UTF8

    return $file
}
