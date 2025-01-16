#!/bin/bash

# 檢查參數
if [ "$#" -ne 2 ]; then
    echo "用法: $0 <USB_DEVICE_PATH> <USB_NAME>"
    echo "例如: $0 /dev/sdb my_usb_rule"
    exit 1
fi

USB_DEVICE="$1"
USB_NAME="$2"
RULE_FILE="/etc/udev/rules.d/${USB_NAME}.rules"

# 獲取 USB 設備的 udev 信息
udevadm info --query=all --name="$USB_DEVICE" > /tmp/usb_info.txt

# 提取 Vendor ID, Product ID, Serial Number
ID_VENDOR=$(grep -oP 'ID_VENDOR_ID=\K.*' /tmp/usb_info.txt)
ID_PRODUCT=$(grep -oP 'ID_MODEL_ID=\K.*' /tmp/usb_info.txt)
ID_SERIAL=$(grep -oP 'ID_SERIAL_SHORT=\K.*' /tmp/usb_info.txt)

# 檢查是否成功獲取資訊
if [ -z "$ID_VENDOR" ] || [ -z "$ID_PRODUCT" ]; then
    echo "無法獲取 USB 設備的 Vendor ID 或 Product ID，請確認設備是否連接正確。"
    exit 1
fi

# 生成 UDEV 規則
echo "SUBSYSTEM==\"usb\", ATTR{idVendor}==\"$ID_VENDOR\", ATTR{idProduct}==\"$ID_PRODUCT\", ATTR{serial}==\"$ID_SERIAL\", SYMLINK+=\"$USB_NAME\"" | sudo tee "$RULE_FILE"

# 重新載入 UDEV 規則
sudo udevadm control --reload-rules
sudo udevadm trigger

echo "UDEV 規則已創建: $RULE_FILE"
echo "請重新插入 USB 設備以應用新規則。"
