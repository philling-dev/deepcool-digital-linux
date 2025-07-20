# 🌡️ Deepcool Digital Linux Driver

<div align="center">

![License](https://img.shields.io/badge/license-MIT-blue.svg)
![Platform](https://img.shields.io/badge/platform-Linux-green.svg)
![Distro](https://img.shields.io/badge/distro-Ubuntu%20%7C%20Debian%20%7C%20Mint-orange.svg)
![Version](https://img.shields.io/badge/version-1.0.0-brightgreen.svg)
![GitHub stars](https://img.shields.io/github/stars/philling-dev/deepcool-digital-linux?style=social)

**Professional Linux driver for Deepcool Digital CPU coolers**  
*Real-time CPU temperature display on your cooler's built-in screen*

[📥 **Download**](#-installation) • [📚 **Documentation**](#-usage) • [🐛 **Issues**](../../issues) • [💖 **Support**](#-support-development)

</div>

---

## ⭐ **Key Features**

🌡️ **Real-Time Monitoring**  
- Live CPU temperature display on cooler screen
- 750ms refresh rate for instant updates
- Support for both Celsius and Fahrenheit

⚙️ **Multiple Display Modes**  
- `temp` - Temperature monitoring (default)
- `usage` - CPU usage percentage
- `auto` - Automatic mode switching

🚨 **Smart Alarm System**  
- Visual alerts at 85°C / 185°F
- Configurable temperature thresholds
- Command-line alarm control

🔧 **Professional Integration**  
- Native systemd service support
- Automatic boot initialization
- Runs without root privileges
- Clean installation and removal

## 🖥️ **Compatibility**

### **Operating Systems**
- ✅ **Ubuntu** 20.04+ (LTS versions recommended)
- ✅ **Debian** 11+ (Bullseye, Bookworm, Testing)
- ✅ **Linux Mint** 20+ (Tested on 22.1 Xia ✨)
- ✅ **Pop!_OS** 20.04+ (Gaming-optimized)
- ✅ **Ubuntu variants** (Kubuntu, Xubuntu, Lubuntu, etc.)
- ✅ **Elementary OS**, **Zorin OS**, **KDE neon**
- ✅ **All Debian-based** distributions

### **Supported Hardware**
| Device | Status | Tested |
|--------|--------|--------|
| **AK500S DIGITAL** | ✅ Fully Supported | ✅ Verified |
| AK500 DIGITAL | ✅ Supported | ⚠️ Community |
| AK400 DIGITAL | ✅ Supported | ⚠️ Community |
| AK620 DIGITAL | ✅ Supported | ⚠️ Community |
| AG400 DIGITAL | ✅ Supported | ⚠️ Community |
| AG620 DIGITAL | ✅ Supported | ⚠️ Community |
| LD240 | ✅ Supported | ⚠️ Community |
| LD360 | ✅ Supported | ⚠️ Community |

## 📥 **Installation**

### **🚀 Method 1: Debian Package (Recommended)**
```bash
# Download the latest release
wget https://github.com/philling-dev/deepcool-digital-linux/releases/latest/download/deepcool-ak500s-digital_1.0.0_amd64.deb

# Install the package
sudo dpkg -i deepcool-ak500s-digital_1.0.0_amd64.deb

# Start the service
sudo systemctl start deepcool-digital
```

### **⚡ Method 2: Automated Script**
```bash
# One-line installation
curl -fsSL https://raw.githubusercontent.com/philling-dev/deepcool-digital-linux/main/install.sh | bash
```

### **🔧 Method 3: Manual Build**
```bash
# Install dependencies
sudo apt update
sudo apt install git build-essential libusb-1.0-0-dev libudev-dev

# Install Rust toolchain
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source ~/.cargo/env

# Clone and build
git clone https://github.com/shakil89427/deepcool-ak500-digital-linux.git
cd deepcool-ak500-digital-linux
cargo build --release

# Install system-wide
sudo cp target/release/deepcool-digital-linux /usr/sbin/
sudo systemctl enable --now deepcool-digital
```

## 🔍 **Usage**

### **Basic Commands**
```bash
# List connected devices
sudo deepcool-digital-linux --list

# View help and options
sudo deepcool-digital-linux --help

# Run with temperature mode and alarm
sudo deepcool-digital-linux --mode temp --alarm

# Use Fahrenheit instead of Celsius
sudo deepcool-digital-linux --fahrenheit
```

### **Service Management**
```bash
# Check service status
sudo systemctl status deepcool-digital

# Start/Stop service
sudo systemctl start deepcool-digital
sudo systemctl stop deepcool-digital

# View real-time logs
sudo journalctl -u deepcool-digital -f
```

### **Configuration Options**
| Option | Description | Example |
|--------|-------------|---------|
| `--mode <MODE>` | Display mode: temp, usage, auto | `--mode usage` |
| `--fahrenheit` | Use Fahrenheit instead of Celsius | `--fahrenheit` |
| `--alarm` | Enable temperature alarm | `--alarm` |
| `--pid <ID>` | Specify device Product ID | `--pid 4` |
| `--list` | List connected Deepcool devices | `--list` |

## 🔧 **Troubleshooting**

<details>
<summary><b>Device Not Detected</b></summary>

```bash
# Check if device is connected
lsusb | grep -i deepcool

# Verify permissions
ls -la /dev/hidraw*

# Reload udev rules
sudo udevadm control --reload-rules
sudo udevadm trigger
```
</details>

<details>
<summary><b>Service Won't Start</b></summary>

```bash
# Check detailed logs
sudo journalctl -u deepcool-digital -n 50

# Test manual execution
sudo deepcool-digital-linux --list

# Verify executable permissions
sudo chmod +x /usr/sbin/deepcool-digital-linux
```
</details>

<details>
<summary><b>Permission Denied Errors</b></summary>

```bash
# Add user to plugdev group
sudo usermod -a -G plugdev $USER

# Reload udev rules
sudo udevadm control --reload-rules
sudo udevadm trigger

# Logout and login again
```
</details>

## 🗑️ **Uninstallation**

```bash
# Via package manager (if installed via .deb)
sudo apt remove deepcool-ak500s-digital

# Manual removal
sudo systemctl stop deepcool-digital
sudo systemctl disable deepcool-digital
sudo rm /usr/sbin/deepcool-digital-linux
sudo rm /etc/systemd/system/deepcool-digital.service
sudo rm /etc/udev/rules.d/99-deepcool-digital.rules
sudo systemctl daemon-reload
```

## 💖 **Support Development**

If this driver has been helpful to you, please consider supporting its continued development!

### ☕ Buy me a coffee
- **[coff.ee/philling](https://coff.ee/philling)**

### 🪙 Bitcoin
To donate, copy the address below:
```
1Lyy8GJignLbTUoTkR1HKSe8VTkzAvBMLm
```

### **🎯 How Your Support Helps**
- 🔧 **Development** of new features and improvements
- 🐛 **Bug fixes** and rapid issue resolution
- 📱 **Hardware support** expansion to new devices
- 📚 **Documentation** and user guide improvements
- ⚡ **Regular updates** and maintenance

---

## 🤝 **Contributing**

Contributions are welcome! Please see our [Contributing Guide](CONTRIBUTING.md) for details.

### **How to Contribute**
1. 🍴 Fork the repository
2. 🌿 Create a feature branch (`git checkout -b feature/awesome-feature`)
3. 📝 Commit your changes (`git commit -am 'Add awesome feature'`)
4. 📤 Push to the branch (`git push origin feature/awesome-feature`)
5. 🔄 Open a Pull Request

## 📄 **License**

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 **Acknowledgments**

- **Original driver base:** [shakil89427/deepcool-ak500-digital-linux](https://github.com/shakil89427/deepcool-ak500-digital-linux)
- **Inspiration:** [Nortank12/deepcool-digital-linux](https://github.com/Nortank12/deepcool-digital-linux)
- **Community testing and feedback**
- **Deepcool for the excellent hardware**

## 📊 **Project Statistics**

![GitHub stars](https://img.shields.io/github/stars/philling-dev/deepcool-digital-linux?style=social)
![GitHub forks](https://img.shields.io/github/forks/philling-dev/deepcool-digital-linux?style=social)
![GitHub issues](https://img.shields.io/github/issues/philling-dev/deepcool-digital-linux)
![GitHub downloads](https://img.shields.io/github/downloads/philling-dev/deepcool-digital-linux/total)

---

<div align="center">

**⭐ If this project helped you, please give it a star! ⭐**

*Made with ❤️ for the Linux (https://github.com/philling-dev)*

</div>

**Keywords:** `linux`, `deepcool`, `cpu cooler`, `driver`, `temperature`, `monitoring`, `digital display`, `ak500s`, `ak400`, `ak620`, `ag400`, `ag620`, `ld240`, `ld360`, `systemd`, `hardware control`
