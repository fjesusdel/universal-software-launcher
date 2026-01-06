# ==================================================
# PRESETS - BLACK CONSOLE
# ==================================================

function Get-PreparePresets {

    return @{
        "1" = @{
            Name = "Basico"
            Install = @(
                "Google Chrome",
                "WinRAR",
                "Mozilla Firefox",
                "7-Zip"
            )
            Remove = @(
                "Microsoft.XboxGamingOverlay",
                "Microsoft.XboxGameOverlay",
                "Microsoft.XboxSpeechToTextOverlay",
                "Microsoft.BingWeather",
                "Microsoft.BingNews",
                "Microsoft.GetHelp",
                "Microsoft.Getstarted",
                "Microsoft.MicrosoftSolitaireCollection",
                "Microsoft.People",
                "Microsoft.WindowsMaps",
                "Microsoft.Clipchamp"
            )
        }

        "2" = @{
            Name = "Gaming"
            Install = @(
                "Google Chrome",
                "Steam",
                "NVIDIA App"
            )
            Remove = @(
                "Microsoft.BingWeather",
                "Microsoft.BingNews",
                "Microsoft.GetHelp",
                "Microsoft.Getstarted",
                "Microsoft.MicrosoftSolitaireCollection",
                "Microsoft.People",
                "Microsoft.WindowsMaps",
                "Microsoft.Clipchamp"
            )
        }

        "3" = @{
            Name = "Trabajo"
            Install = @(
                "Google Chrome",
                "Mozilla Firefox",
                "Microsoft Office"
            )
            Remove = @(
                "Microsoft.XboxGamingOverlay",
                "Microsoft.XboxGameOverlay",
                "Microsoft.XboxSpeechToTextOverlay",
                "Microsoft.BingWeather",
                "Microsoft.BingNews",
                "Microsoft.GetHelp",
                "Microsoft.Getstarted",
                "Microsoft.MicrosoftSolitaireCollection",
                "Microsoft.People",
                "Microsoft.WindowsMaps",
                "Microsoft.Clipchamp"
            )
        }
    }
}
