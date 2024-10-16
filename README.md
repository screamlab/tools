# USB Device Management Tools

This repository contains tools for identifying and managing USB devices on your main system.

## 🚀 Getting Started

Clone this repository to your system where you need to connect and identify specific USB devices:

```bash
git clone https://github.com/your-username/tools.git
cd tools
```

## 🛠 Tools

### 1. extract_usb_info.sh

#### Description
Quickly extracts and lists key attributes of specific USB devices.

#### Usage
```bash
./extract_usb_info.sh /dev/ttyUSB0
```
Replace `/dev/ttyUSB0` with the device you want to query.

#### Output
- `idVendor`: Device's vendor ID
- `idProduct`: Device's product ID
- `manufacturer`: Device manufacturer name
- `serial`: Device's serial number

### 2. device_rule_generate.sh

#### Description
Generates specific udev rules based on USB device characteristics, allowing the main system to recognize and assign fixed names to these USB devices.

#### Usage
1. Modify the `device_rule_generate.sh` script:
   - Add USB device characteristics (obtained from `extract_usb_info.sh`) to the designated area.
2. Execute the script with sudo:
   ```bash
   sudo ./device_rule_generate.sh
   ```
   This will assign fixed names to the USB devices and take effect immediately.

#### Example Rules
```bash
# LiDAR device rule
SUBSYSTEM=="tty", ATTRS{idVendor}=="10c4", ATTRS{idProduct}=="ea60", ATTRS{manufacturer}=="Silicon Labs", SYMLINK+="usb_ydlidar", MODE="0666"

# Arduino device rule
SUBSYSTEM=="tty", ATTRS{idVendor}=="1d6b", ATTRS{idProduct}=="0002", SYMLINK+="usb_rear_wheel", MODE="0666"
```

#### Result
![Console Output](https://github.com/alianlbj23/tools/blob/main/pic/console.png?raw=true)

### 3. rule_generator.py

#### Description
This Python script automates the process of generating udev rules for USB devices. It communicates with connected devices, retrieves their custom IDs, and creates appropriate udev rules.

#### Prerequisites
- Python 3.x
- `pyserial` library (install with `pip install pyserial`)
- Arduino or ESP32 devices with proper firmware (see Arduino/ESP32 Code Requirements below)

#### Arduino/ESP32 Code Requirements
For this script to work correctly, the Arduino or ESP32 devices must include their own CUSTOM_ID and be able to respond to JSON commands. Add the following to your Arduino/ESP32 code:

```cpp
// Replace with your device's unique identifier
#define CUSTOM_ID "usb_rear_wheel" 

// In your main loop or command processing function:
if (doc.containsKey("command") && doc["command"] == "I") {
    Serial.println(CUSTOM_ID);
} 
```

This code allows the device to respond with its CUSTOM_ID when queried by the rule_generator.py script. The CUSTOM_ID will be used as the device's rule name in the generated udev rules.

#### Usage
1. Ensure you have the necessary permissions to write to `/etc/udev/rules.d/` and execute udev commands.
2. Make sure your Arduino/ESP32 devices are programmed with the required code (as described above).
3. Connect your devices to the system.
4. Run the script with sudo:

```bash
sudo python3 rule_generator.py
```

#### Functionality
- Automatically detects all `/dev/ttyUSB*` and `/dev/ttyACM*` devices.
- Communicates with each device to retrieve its custom ID.
- Generates udev rules based on the device's kernel information and custom ID.
- Reloads udev rules to apply changes immediately.

#### Output
- Displays the custom ID received from each device.
- Shows the matching KERNELS information.
- Confirms the creation of udev rules for each device.
- Reports any errors encountered during the process.

## 📝 License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details.

## 🤝 Contributing

Contributions, issues, and feature requests are welcome! Feel free to check [issues page](https://github.com/your-username/tools/issues).
