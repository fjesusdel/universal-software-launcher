# ==================================================
# INSTALLER - BLACK CONSOLE
# ==================================================

# -------------------------------
# SALIDA CONTROLADA
# -------------------------------

function Write-Info {
    param ([string]$Message)
    Write-Host $Message -ForegroundColor Cyan
}

function Write-Skip {
    param ([string]$Message)
    Write-Host $Message -ForegroundColor Yellow
}

function Write-Ok {
    param ([string]$Message)
    Write-Host $Message -ForegroundColor Green
}

function Write-VerboseInfo {
    param ([string]$Message)
    if ($Global:BlackConsole.Verbose) {
        Write-Host "[VERBOSE] $Message" -ForegroundColor DarkGray
    }
}

# -------------------------------
# UTILIDADES
# -------------------------------

function Download-File {
    param (
        [string]$Url,
        [string]$OutFile
    )

    Write-VerboseInfo "Descargando desde: $Url"
    Write-VerboseInfo "Destino: $OutFile"

    Invoke-WebRequest -Uri $Url -OutFile $OutFile -UseBasicParsing
}

function Is-ProgramInstalled {
    param ([string]$Name)

    Write-VerboseInfo "Comprobando si esta instalado: $Name"

    $paths = @(
        "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall",
        "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall",
        "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall"
    )

    foreach ($path in $paths) {
        if (Test-Path $path) {
            $items = Get-ChildItem $path -ErrorAction SilentlyContinue |
                Get-ItemProperty -ErrorAction SilentlyContinue |
                Where-Object { $_.DisplayName -and $_.DisplayName -like "*$Name*" }

            if ($items) {
                Write-VerboseInfo "Detectado en registro: $Name"
                return $true
            }
        }
    }

    return $false
}

# ==================================================
# INSTALADORES
# ==================================================

function Install-Chrome {

    if (Is-ProgramInstalled "Google Chrome") {
        Write-Skip "Google Chrome ya esta instalado."
        return
    }

    Write-Info "Instalando Google Chrome..."

    $url = "https://www.google.com/chrome/install/enterprise?platform=win&standalone=1"
    $installer = "$env:TEMP\chrome_installer.exe"

    Download-File $url $installer
    Start-Process $installer -ArgumentList "/silent /install" -Wait

    Write-Ok "Google Chrome instalado."
}

function Install-WinRAR {

    if (Is-ProgramInstalled "WinRAR") {
        Write-Skip "WinRAR ya esta instalado."
        return
    }

    Write-Info "Instalando WinRAR..."

    $url = "https://www.rarlab.com/rar/winrar-x64-701.exe"
    $installer = "$env:TEMP\winrar_installer.exe"

    Download-File $url $installer
    Start-Process $installer -ArgumentList "/S" -Wait

    Write-Ok "WinRAR instalado."
}

function Install-Discord {

    Write-VerboseInfo "Comprobando ruta local de Discord"

    if (Test-Path "$env:LOCALAPPDATA\Discord") {
        Write-Skip "Discord ya esta instalado."
        return
    }

    Write-Info "Instalando Discord..."

    $url = "https://discord.com/api/download?platform=win"
    $installer = "$env:TEMP\discord_installer.exe"

    Download-File $url $installer
    Start-Process $installer -ArgumentList "/S" -Wait

    Write-Ok "Discord instalado."
}

function Install-VCRedist {

    Write-Info "Instalando Microsoft Visual C++ Redistributables..."

    $packages = @(
        @{ Name = "VC++ x64"; Url = "https://aka.ms/vs/17/release/vc_redist.x64.exe" },
        @{ Name = "VC++ x86"; Url = "https://aka.ms/vs/17/release/vc_redist.x86.exe" }
    )

    foreach ($pkg in $packages) {
        Write-VerboseInfo "Procesando paquete: $($pkg.Name)"

        $installer = "$env:TEMP\$($pkg.Name.Replace(' ', '_')).exe"
        Download-File $pkg.Url $installer
        Start-Process $installer -ArgumentList "/quiet /norestart" -Wait
    }

    Write-Ok "Visual C++ Redistributables instalados."
}

function Install-DotNetDesktop {

    if (Is-ProgramInstalled ".NET Desktop Runtime") {
        Write-Skip ".NET Desktop Runtime ya esta instalado."
        return
    }

    Write-Info "Instalando .NET Desktop Runtime..."

    $url = "https://dotnet.microsoft.com/download/dotnet/thank-you/runtime-desktop-8.0.0-windows-x64-installer"
    $installer = "$env:TEMP\dotnet_desktop.exe"

    Download-File $url $installer
    Start-Process $installer -ArgumentList "/install /quiet /norestart" -Wait

    Write-Ok ".NET Desktop Runtime instalado."
}
