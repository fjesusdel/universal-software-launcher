function Confirm-Action($Message) {

    Write-Host ""
    Write-Host $Message -ForegroundColor Yellow
    Write-Host ""
    Write-Host "S) Si"
    Write-Host "N) No"
    Write-Host ""

    do {
        $resp = Read-Host "Confirmar"
    } until ($resp.ToUpper() -in @("S","N"))

    return ($resp.ToUpper() -eq "S")
}
