function Invoke-UninstallByName($NamePattern) {

    $Keys = @(
        "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall",
        "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall"
    )

    $Found = $false

    foreach ($key in $Keys) {
        Get-ChildItem $key -ErrorAction SilentlyContinue | ForEach-Object {
            $app = Get-ItemProperty $_.PSPath -ErrorAction SilentlyContinue
            if ($app.DisplayName -and $app.DisplayName -like $NamePattern) {
                $Found = $true
                if ($app.UninstallString) {
                    Write-Host "[*] Desinstalando $($app.DisplayName)..."
                    Start-Process "cmd.exe" "/c $($app.UninstallString)" -Wait
                }
            }
        }
    }

    if (-not $Found) {
        Write-Host "No se ha encontrado la aplicacion." -ForegroundColor Yellow
    }
    else {
        Write-Host "[OK] Aplicacion eliminada." -ForegroundColor Green
    }

    Pause
}

function Uninstall-Steam        { Invoke-UninstallByName "*Steam*" }
function Uninstall-Firefox      { Invoke-UninstallByName "*Firefox*" }
function Uninstall-7Zip         { Invoke-UninstallByName "*7-Zip*" }
function Uninstall-Discord      { Invoke-UninstallByName "*Discord*" }
function Uninstall-VirtualBox   { Invoke-UninstallByName "*VirtualBox*" }
function Uninstall-Cura         { Invoke-UninstallByName "*Ultimaker Cura*" }
