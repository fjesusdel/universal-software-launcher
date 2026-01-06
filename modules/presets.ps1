# ==================================================
# PRESETS - BLACK CONSOLE
# ==================================================

function Get-PreparePresets {

    return @{
        "1" = @{
            Name = "Basico"
            Install = @("Chrome","WinRAR","Firefox","7Zip")
            Remove  = @("Xbox","Bing","Clipchamp")
        }
        "2" = @{
            Name = "Gaming"
            Install = @("Chrome","Steam","Nvidia")
            Remove  = @("Xbox","Bing","Clipchamp")
        }
        "3" = @{
            Name = "Trabajo"
            Install = @("Chrome","Firefox","Office")
            Remove  = @("Xbox","Bing","Clipchamp")
        }
    }
}
