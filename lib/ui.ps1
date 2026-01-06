function Show-Banner {

    Clear-Host

    Write-Host "============================================================" -ForegroundColor DarkGray
    Write-Host "||                                                        ||" -ForegroundColor DarkGray
    Write-Host "||   ____  _            _      ____                      ||" -ForegroundColor Cyan
    Write-Host "||  | __ )| | __ _  ___| | __ / ___| ___  _ __            ||" -ForegroundColor Cyan
    Write-Host "||  |  _ \| |/ _` |/ __| |/ /| |    / _ \| '_ \           ||" -ForegroundColor Cyan
    Write-Host "||  | |_) | | (_| | (__|   < | |___| (_) | | | |          ||" -ForegroundColor Cyan
    Write-Host "||  |____/|_|\__,_|\___|_|\_\ \____|\___/|_| |_|          ||" -ForegroundColor Cyan
    Write-Host "||                                                        ||" -ForegroundColor DarkGray
    Write-Host "||                    BLACK CONSOLE                       ||" -ForegroundColor White
    Write-Host "||              Universal Software Launcher               ||" -ForegroundColor DarkGray
    Write-Host "||                                                        ||" -ForegroundColor DarkGray
    Write-Host "============================================================" -ForegroundColor DarkGray
    Write-Host ""
}

function Show-Menu {

    Write-Host " [1] Install Microsoft Office 2024" -ForegroundColor White
    Write-Host " [2] Install Google Chrome"        -ForegroundColor White
    Write-Host " [3] Install WinRAR"               -ForegroundColor White
    Write-Host " [4] Install VirtualBox"           -ForegroundColor White
    Write-Host " [5] Install Discord"              -ForegroundColor White
    Write-Host " [6] Install ALL software"         -ForegroundColor Yellow
    Write-Host " [7] Show installed software"      -ForegroundColor DarkGray
    Write-Host " [0] Exit"                         -ForegroundColor Red
    Write-Host ""
}
