#!/bin/bash

# 检查是否有参数传入
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 /dev/ttyUSBx"
    exit 1
fi

DEVICE="$1"

# 使用udevadm获取设备信息
INFO=$(udevadm info --name=${DEVICE} --attribute-walk)

# 检查manufacturer是否为Silicon Labs
if echo "$INFO" | grep -q 'ATTRS{manufacturer}=="Silicon Labs"'; then
    # 提取idVendor、idProduct和serial
    ID_VENDOR=$(echo "$INFO" | grep 'ATTRS{idVendor}' | head -n 1 | awk -F\" '{print $2}')
    ID_PRODUCT=$(echo "$INFO" | grep 'ATTRS{idProduct}' | head -n 1 | awk -F\" '{print $2}')
    SERIAL=$(echo "$INFO" | grep 'ATTRS{serial}' | head -n 1 | awk -F\" '{print $2}')
    
    echo "Found Silicon Labs device"
    echo "idVendor: $ID_VENDOR"
    echo "idProduct: $ID_PRODUCT"
    echo "serial: $SERIAL"
else
    echo "No Silicon Labs device found at ${DEVICE}"
fi

