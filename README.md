# light_on - STM32F407 GPIO 实操（PH10 蓝灯闪烁）

按 PNX 知识库【基础】GPIO 实操教程完成：C 型开发板 RGB LED 蓝色通道 = PH10，
GPIO 推挽输出、初始高电平，主循环翻转 + 500 ms 延时实现闪烁。

## 硬件
- MCU: STM32F407IGH6 (UFBGA176)
- 时钟: HSE 8 MHz -> PLL -> SYSCLK 168 MHz（CubeMX 时钟树）
- 调试: SWD (PA13=SWDIO, PA14=SWCLK)，下载器 ST-Link
- LED: PH10（蓝），输出高电平点亮

## 软件环境
- VS Code + Cortex-Debug 扩展
- ARM GNU Toolchain 13.3 (arm-none-eabi-gcc)
- CMake 4.4.3 + Ninja
- OpenOCD 0.12.0 (sysprogs) + ST-Link WinUSB 驱动

## 构建
```powershell
cmake --preset debug
cmake --build --preset debug
```
产物: build/Debug/light_on.elf / .hex / .bin
VS Code: Ctrl+Shift+B 运行 cmake-build-debug，或 F5 自动构建并调试。

## 烧录
VS Code: 选择 "STM32 Debug (STLink)" 按 F5。
命令行: powershell -ExecutionPolicy Bypass -File .\flash.ps1

## 已完成
- [x] 程序编写 (Core/Src/main.c)
- [x] GCC/CMake 构建系统
- [x] 编译通过
- [x] ST-Link WinUSB 驱动安装
- [x] 烧录 + 校验通过（Verify OK, device id 0x10076413, flash 1024 KiB）

## 备注
- 原始 CubeMX 工程用 EWARM (IAR) 工具链生成，VS Code + GCC 无法直接编译；
  本目录补充了 GCC/CMake 构建系统，未修改 .ioc 配置。
- 构建时排除 HAL 的 *_template.c。
- 链接器脚本来自 STM32CubeF4 固件包模板 (STM32F407IGHX_FLASH.ld)。
- 之前的外部 ST-Link (VID_0483:PID_3748) 连接 SWD 失败；
  换成 ST-Link/V2-1 (VID_0483:PID_374B) 后一次成功。
