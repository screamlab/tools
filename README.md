# tools
## 使用地點
於需要連接這些 USB 裝置並辨識出該 USB 裝置的系統上將此專案 clone 下來，並依照以下使用教學做設定
# extract_usb_info.sh
## 介紹
快速列出特定 USB 裝置的 idVendor, idProduct, manufacturer, serial number...等等屬性
## 使用方法
後面/dev/ttyUSB0是要查詢的值
```
./extract_usb_info.sh /dev/ttyUSB0
```
## 輸出解釋
- idVendor : 設備的廠商 ID
- idProduct : 設備的產品 ID
- manufacturer : 設備製造商名稱
- serial number: 設備的序列號
# device_rule_generate.sh
## 介紹
此腳本負責根據 USB 裝置的特徵生成特定的 udev 規則，讓系統能夠辨識並指派固定的名稱給該 USB 裝置
## 使用
- 修改 `device_rule_generate.sh` 該腳本的以下區域，可根據 `extract_usb_info.sh` 所查詢到的 USB 裝置特徵新增至以下區域，讓設備辨識出該 usb 裝置名稱
- 修改完後須使用 `sudo` 執行，系統將會指派固定名稱給該 USB 裝置並立即生效

```
# 以下開放新增---------------------

# LiDAR 設備規則
SUBSYSTEM=="tty", ATTRS{idVendor}=="10c4", ATTRS{idProduct}=="ea60", ATTRS{manufacturer}=="Silicon Labs", SYMLINK+="usb_ydlidar", MODE="0666"

# Arduino 設備規則
SUBSYSTEM=="tty", ATTRS{idVendor}=="1d6b", ATTRS{idProduct}=="0002", SYMLINK+="usb_rear_wheel", MODE="0666"

#--------------------------------
```
