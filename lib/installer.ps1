# ==================================================
# INSTALLER CORE - BLACK CONSOLE
# ==================================================

function Write-Info  { param($m) Write-Host "[*] $m" -ForegroundColor Cyan }
function Write-Ok    { param($m) Write-Host "[OK] $m" -ForegroundColor Green }
function Write-Skip  { param($m) Write-Host "[SKIP] $m" -ForegroundColor Yellow }
function Write-Fail  { param($m) Write-Host "[ERROR] $m" -ForegroundColor Red }

# ==================================================
# BLACK CONSOLE TOOLS
# ==================================================

function Install-QuickVolumeControl {

    if (Test-QuickVolumeInstalled) {
        Write-Skip "Control de volumen rapido ya instalado."
        return
    }

    Write-Info "Instalando Control de Volumen rapido..."

    $sourceExe = Join-Path $PSScriptRoot "bin\volume.exe"
    $installDir = "$env:APPDATA\BlackConsole\QuickVolume"
    $targetExe = Join-Path $installDir "volume.exe"

    if (-not (Test-Path $sourceExe)) {
        Write-Fail "volume.exe no encontrado en lib/bin."
        return
    }

    New-Item -ItemType Directory -Path $installDir -Force | Out-Null
    Copy-Item $sourceExe $targetExe -Force

    Write-Ok "Control de Volumen rapido instalado."
    Write-Host ""
    Write-Host "METODO DE USO:" -ForegroundColor Cyan
    Write-Host " CTRL + Flecha ARRIBA  -> Subir volumen"
    Write-Host " CTRL + Flecha ABAJO   -> Bajar volumen"
    Write-Host " CTRL + M              -> Silenciar (MUTE)"
    Write-Host ""
    Write-Host "La aplicacion se ejecuta en segundo plano."
}

function Uninstall-QuickVolumeControl {

    Write-Info "Eliminando Control de Volumen rapido..."

    $installDir = "$env:APPDATA\BlackConsole\QuickVolume"

    if (Test-Path $installDir) {
        Remove-Item $installDir -Recurse -Force
        Write-Ok "Control de Volumen eliminado."
    }
    else {
        Write-Skip "No estaba instalado."
    }
}

function Uninstall-BlackConsoleRadial {

    Write-Info "Eliminando Black Console Radial HUD..."

    $skinPath = "$env:USERPROFILE\Documents\Rainmeter\Skins\BlackConsoleRadial"

    if (Test-Path $skinPath) {
        Remove-Item $skinPath -Recurse -Force
        Write-Ok "Radial HUD eliminado."
    }
    else {
        Write-Skip "Radial HUD no encontrado."
    }
}
