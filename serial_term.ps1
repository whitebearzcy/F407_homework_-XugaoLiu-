# 简易串口终端：powershell -ExecutionPolicy Bypass -File .\serial_term.ps1 -Port COM12
param([string]$Port = 'COM12', [int]$Baud = 115200)
$sp = New-Object System.IO.Ports.SerialPort($Port, $Baud, 'None', 8, 'One')
$sp.ReadTimeout = 100
$sp.Open()
$buf = ''
Write-Host ('=== ' + $Port + ' @ ' + $Baud + ' 已打开。输入命令回车发送，Ctrl+C 退出 ===') -ForegroundColor Cyan
while ($true) {
  $d = $sp.ReadExisting()
  if ($d.Length -gt 0) { Write-Host $d -NoNewline }
  if ([Console]::KeyAvailable) {
    $k = [Console]::ReadKey($true)
    if ($k.Key -eq 'Enter') {
      $sp.Write($buf + [char]13 + [char]10)
      $buf = ''
      Write-Host ''
    } elseif ($k.Key -eq 'Backspace') {
      if ($buf.Length -gt 0) { $buf = $buf.Substring(0, $buf.Length - 1); Write-Host ([char]8 + ' ' + [char]8) -NoNewline }
    } else {
      $buf += $k.KeyChar
      Write-Host $k.KeyChar -NoNewline
    }
  }
  Start-Sleep -Milliseconds 20
}