function Show-Banner {

    Clear-Host

    Write-Host "######################################################################" -ForegroundColor DarkGray
    Write-Host "#                                                                    #" -ForegroundColor DarkGray
    Write-Host "#   ██████╗ ██╗      █████╗  ██████╗██╗  ██╗                         #" -ForegroundColor Cyan
    Write-Host "#   ██╔══██╗██║     ██╔══██╗██╔════╝██║ ██╔╝                         #" -ForegroundColor Cyan
    Write-Host "#   ██████╔╝██║     ███████║██║     █████╔╝                          #" -ForegroundColor Cyan
    Write-Host "#   ██╔══██╗██║     ██╔══██║██║     ██╔═██╗                          #" -ForegroundColor Cyan
    Write-Host "#   ██████╔╝███████╗██║  ██║╚██████╗██║  ██╗                         #" -ForegroundColor Cyan
    Write-Host "#   ╚═════╝ ╚══════╝╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝                         #" -ForegroundColor Cyan
    Write-Host "#                                                                    #" -ForegroundColor DarkGray
    Write-Host "#                        BLACK CONSOLE                                #" -ForegroundColor White
    Write-Host "#                  Universal Software Launcher                         #" -ForegroundColor DarkGray
    Write-Host "#                                                                    #" -ForegroundColor DarkGray
    Write-Host "######################################################################" -ForegroundColor DarkGray
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
