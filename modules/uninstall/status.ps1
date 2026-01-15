function Test-SteamInstalled {
    Test-Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Steam"
}

function Test-RadialInstalled {
    Test-Path "$env:USERPROFILE\Documents\Rainmeter\Skins\BlackConsole"
}

function Test-VolumeInstalled {
    Test-Path "C:\BlackConsole\bin\volume.exe"
}

function Get-StatusLabel($Installed) {
    if ($Installed) {
        return "[INSTALADO]"
    }
    else {
        return "[NO INSTALADO]"
    }
}
