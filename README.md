# light_on - STM32F407 综合实验（GPIO / 中断 / PWM / 串口）

硬件：STM32F407IGH6 (C型开发板)，ST-Link V2.1，HSE 12MHz -> 168MHz

## 功能
1. 两灯同步/交替闪烁（PH11/PH12，500ms）
2. PH10 呼吸灯（TIM5_CH1 PWM，4kHz，for 循环调占空比）
3. 按键 PA0 中断：进入/退出『中断模式』（交替闪烁 + 呼吸灯）
4. 串口 USART6 (PG14=TX, PG9=RX, 115200 8N1)：
   - 上电发送 `I'm already`
   - 收到 `start` -> 回复 `OK`（调试用）
   - 收到 `change` -> 与按 PA0 等效，进入/退出中断模式，回复 `OK`

## 串口接线（重要）
| ST-Link | 板子 | 说明 |
|---|---|---|
| VCP RX | PG14 (USART6_TX) | 单片机发、电脑收 |
| VCP TX | PG9  (USART6_RX) | 电脑发、单片机收（必须交叉！） |
| GND | GND | 共地 |

> 踩坑记录：TX/RX 接反时，现象是『能收到上电消息，但发命令无回复』。
> 用 ST-Link TX/RX 短接做回环测试，可快速确认 ST-Link 与电脑侧是否正常。

## 电脑端终端
```powershell
powershell -ExecutionPolicy Bypass -File .\serial_term.ps1 -Port COM10
```
打开后输入 `start` 或 `change` 回车发送。

## 构建 / 烧录
```powershell
cmake --preset debug
cmake --build --preset debug
powershell -ExecutionPolicy Bypass -File .\flash.ps1
```
VS Code：Ctrl+Shift+B 编译，F5 烧录调试（STM32 Debug (STLink)）。
