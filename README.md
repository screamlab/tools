# tools
# extract_usb_info.sh
## 介紹
快速列出特定 usb 裝置的 idVendor, idProduct, manufacturer, serial 屬性
## 使用方法
後面/dev/ttyUSB0是要查詢的值
```
./extract_usb_info.sh /dev/ttyUSB0
```
## 輸出解釋
- idVendor : 設備的廠商 ID
- idProduct : 設備的產品 ID
- manufacturer : 設備製造商名稱
- serial : 設備的序列號
# device_rule_generate.sh
## 介紹
用於自動創建 usb rule 的腳本
## 使用
於腳本以下區域新增自己的 rule

```
# 以下開放新增---------------------

# LiDAR 設備規則
SUBSYSTEM=="tty", ATTRS{idVendor}=="10c4", ATTRS{idProduct}=="ea60", ATTRS{manufacturer}=="Silicon Labs", SYMLINK+="usb_ydlidar", MODE="0666"

# Arduino 設備規則
SUBSYSTEM=="tty", ATTRS{idVendor}=="1d6b", ATTRS{idProduct}=="0002", SYMLINK+="usb_rear_wheel", MODE="0666"

#--------------------------------
```
新增完後須使用 sudo 執行, 腳本內建自動更新 rule
