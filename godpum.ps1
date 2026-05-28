# 1. หา Path ปัจจุบันที่สคริปต์ (godpum.ps1) นี้ตั้งอยู่
$scriptDir = $PSScriptRoot

# 2. กำหนด Path ของไฟล์ exe ที่ต้องการรัน (ต้องอยู่ในโฟลเดอร์เดียวกัน)
$exePath = Join-Path -Path $scriptDir -ChildPath "main2.exe"

# 3. ตรวจสอบว่ามีไฟล์อยู่จริงหรือไม่ แล้วสั่งรัน
if (Test-Path -Path $exePath) {
    Write-Host "กำลังรันไฟล์: $exePath" -ForegroundColor Green
    # สั่งรันโปรแกรม
    Start-Process -FilePath $exePath
} else {
    Write-Host "หาไฟล์ main2.exe ไม่พบในโฟลเดอร์นี้ ($scriptDir)" -ForegroundColor Red
    Pause
}
