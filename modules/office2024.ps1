$BasePath = Split-Path -Parent $MyInvocation.MyCommand.Path
Install-Office2024 "$BasePath\..\config\office2024.xml"
