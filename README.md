# MediaTek Performance Booster (KernelSU / Magisk Module)

A lightweight, non-destructive system script module designed to force MediaTek Helio and Dimensity processors into high-performance mode post-boot. Ideal for devices running late-loading root environments (such as LKM / DirtyFrag / KernelSU).

---

## 🚀 Features
- **CPU Governor Override:** Automatically forces the CPU scaling governor to `performance` across all available CPU cores.
- **GPU Boost Integration:** Interfaces with the MediaTek GED (Graphics Energy Dweller) driver (`gx_boost`) to maximize GPU responsiveness.
- **Late-Boot Safe:** Designed to safely execute after the system and root environment have fully initialized (`sys.boot_completed`).
- **Non-Destructive:** Does not permanently modify system partitions (`/system` or `/vendor`), making it fully safe from bootloops.

---

## 📱 Tested Chipsets & Supported Models

This module has been tested and verified to work on various budget and mid-range MediaTek processors running Android 10 up to Android 15:

* **MediaTek Helio G81 / G85 / G88** (e.g., Moto G15 Power, Redmi Note series)
* **MediaTek Helio G99 / G99-Ultra** (e.g., POCO M5, Infinix Note series)
* **MediaTek Dimensity series** (Select devices with standard kernel scaling interfaces)

---

## 📦 Installation Guide

1. Download the latest release `.zip` package from the [Releases](../../releases) page (ensure it is packed with **No Compression / Store** method if you built it yourself).
2. Open your root manager application (**KernelSU** or **Magisk**).
3. Navigate to the **Modules** tab and tap on **Install from storage**.
4. Select the `MTK_Performance_Booster.zip` file and let it flash.
5. **Reboot:** A system reboot is **strongly recommended** after installation to ensure all kernel schedulers and thermal profiles fully adapt to the new performance state.

---

## 🛠️ Manual Usage & Testing (Without Rebooting)

If you want to trigger or test the script immediately in real-time without rebooting your phone:

1. Copy `service.sh` to your phone's internal storage (e.g., `/sdcard/`).
2. Open a terminal emulator app (such as *Termux* or *MT Manager terminal*).
3. Gain root permissions and execute the script manually:
   ```bash
   su
   sh /sdcard/service.sh```
You will see real-time console logs confirming the successful application of the CPU governor and GPU boost.

⚙️ How It Works (Technical Details)
Upon system startup, the script waits for the Android boot sequence to finish (sys.boot_completed = 1). Once stable, it iterates through all core scaling directories:

Bash
/sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
And applies the performance profile. If available, it also triggers the MediaTek GED node:

Bash
echo "1" > /sys/module/ged/parameters/gx_boost
🛡️ Troubleshooting & Safety
Safe from Bootloops: Since this module utilizes post-boot script execution via KernelSU/Magisk, it cannot cause permanent bootloops. If an issue occurs, simply reboot your device into Safe Mode or disable the module inside KernelSU.

Logs: You can check the execution logs at any time via logcat:

Bash
logcat -s MTK_Perf
📄 License
This project is open-source and available under the MIT License.
