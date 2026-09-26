# Flash light_on.elf to STM32F407 via OpenOCD + ST-Link
# Run from project root:  powershell -ExecutionPolicy Bypass -File .\flash.ps1
$ErrorActionPreference = "Stop"
Set-Location $PSScriptRoot
$rel = "build\Debug\light_on.elf"
if (-not (Test-Path $rel)) { throw "ELF not found: $rel  (build first: cmake --preset debug; cmake --build --preset debug)" }
Write-Host "Flashing $rel ..." -ForegroundColor Cyan
& openocd -f interface/stlink.cfg -f target/stm32f4x.cfg -c "program build/Debug/light_on.elf verify reset exit"
if ($LASTEXITCODE -eq 0) { Write-Host "Done. PH10 (blue LED) should blink every 500 ms." -ForegroundColor Green }
exit $LASTEXITCODE
