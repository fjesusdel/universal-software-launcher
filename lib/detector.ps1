function Is-Installed {
    param ([string]$Name)

    $keys = @(
        "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall",
        "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall"
    )

    foreach ($key in $keys) {
        if (Get-ChildItem $key -ErrorAction SilentlyContinue |
            Get-ItemProperty |
            Where-Object { $_.DisplayName -like "*$Name*" }) {
            return $true
        }
    }
    return $false
}

function Show-Installed {
    Write-Host "`nSoftware detectado:`n" -ForegroundColor Cyan
    @{
        "Office"     = "Microsoft Office"
        "Chrome"     = "Google Chrome"
        "WinRAR"     = "WinRAR"
        "VirtualBox" = "VirtualBox"
        "Discord"    = "Discord"
    }.GetEnumerator() | ForEach-Object {
        if (Is-Installed $_.Value) {
            Write-Host "[OK] $($_.Key)" -ForegroundColor Green
        } else {
            Write-Host "[ ] $($_.Key)" -ForegroundColor Yellow
        }
    }
}
