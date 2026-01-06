# ==================================================
# HARDWARE DETECTION - BLACK CONSOLE
# ==================================================

function Has-NvidiaGPU {

    $gpus = Get-CimInstance Win32_VideoController -ErrorAction SilentlyContinue

    foreach ($gpu in $gpus) {
        if ($gpu.Name -match "NVIDIA") {
            return $true
        }
    }

    return $false
}
