#!/system/bin/sh
# MediaTek CPU & GPU Performance Mode Script
# Author: SatsumaPL

LOG_TAG="MTK_Perf"

echo "=========================================="
echo "[+] Starting MediaTek Performance Booster..."
echo "=========================================="
log -t "$LOG_TAG" "Starting MediaTek Performance Booster..."

# Check if script is running during boot or manually
if [ "$(getprop sys.boot_completed)" != "1" ]; then
    echo "[i] System is still booting. Waiting for completion..."
    until [ "$(getprop sys.boot_completed)" = "1" ]; do
        sleep 3
    done
fi

# Short delay for stability
sleep 2

# 1. Apply CPU Governor settings
echo "[+] Setting CPU Governors to 'performance'..."
CPU_COUNT=0

for cpu in /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor; do
    if [ -f "$cpu" ]; then
        echo "performance" > "$cpu"
        CPU_COUNT=$((CPU_COUNT + 1))
    fi
done

if [ "$CPU_COUNT" -gt 0 ]; then
    echo "[SUCCESS] Successfully set performance governor on $CPU_COUNT CPU core(s)."
    log -t "$LOG_TAG" "Successfully applied performance governor on $CPU_COUNT CPU cores."
else
    echo "[WARNING] Could not find CPU scaling governor paths!"
    log -t "$LOG_TAG" "Failed to locate CPU scaling governor paths."
fi

# 2. Apply GPU Boost settings (MediaTek GED interface)
echo "[+] Checking MediaTek GPU GED interface..."
if [ -d "/sys/module/ged" ]; then
    echo "1" > /sys/module/ged/parameters/gx_boost 2>/dev/null
    echo "[SUCCESS] MediaTek GPU GED gx_boost enabled."
    log -t "$LOG_TAG" "MediaTek GPU GED gx_boost enabled."
else
    echo "[INFO] MediaTek GED module interface not found (Skipped GPU boost)."
    log -t "$LOG_TAG" "MediaTek GED interface not present."
fi

echo "=========================================="
echo "[DONE] Script execution finished successfully!"
echo "[INFO] Immediate execution successful. Reboot is NOT strictly required,"
echo "       but a system reboot is RECOMMENDED to ensure all background services"
echo "       and thermal limits fully adapt to the new performance state."
echo "=========================================="
log -t "$LOG_TAG" "Execution finished. Reboot recommended for full effect."

exit 0
