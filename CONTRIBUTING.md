# 🤝 Contributing Guide

Thank you for your interest in contributing to the **Deepcool AK500S Linux Driver**! 

## 🚀 How to Contribute

### **1. Report Bugs**
- Check if the bug has already been reported in [Issues](../../issues)
- Use the bug report template
- Include system information (distribution, kernel version)
- Include relevant logs

### **2. Suggest Enhancements**
- Open an [Issue](../../issues) with the `enhancement` tag
- Clearly describe the proposed functionality
- Explain the use case

### **3. Code Contributions**

#### **Development Setup**
```bash
# Fork and clone the repository
git clone https://github.com/tharks123/deepcool-ak500s-linux.git
cd deepcool-ak500s-linux

# Install dependencies
sudo apt install git build-essential libusb-1.0-0-dev libudev-dev

# Install Rust (if needed)
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source ~/.cargo/env

# Build
cargo build --release
```

#### **Development Process**
1. 🌿 Create a branch: `git checkout -b feature/new-feature`
2. 📝 Make your changes
3. ✅ Test on different systems
4. 📦 Update documentation if needed
5. 🧪 Run tests: `cargo test`
6. 📤 Commit and push: `git push origin feature/new-feature`
7. 🔄 Open a Pull Request

### **4. Documentation Improvements**
- Fix typos and grammar
- Translate to other languages
- Improve examples
- Add use cases

## 🎯 Current Priorities

- [ ] 📱 Graphical User Interface (GUI)
- [ ] 🌡️ Support for more temperature sensors
- [ ] 🎮 RGB system integration
- [ ] 📊 Web dashboard
- [ ] 🔧 Diagnostic tools

## 📋 Guidelines

### **Code Style**
- Use standard Rust formatting: `cargo fmt`
- Run linter: `cargo clippy`
- Maintain compatibility with Rust 1.70+
- Add comments for complex code

### **Commits**
Use conventional commits:
```
feat: add automatic temperature mode
fix: resolve USB device detection issue
docs: update installation instructions
test: add tests for fahrenheit mode
```

### **Pull Requests**
- Clear and descriptive title
- Detailed description of changes
- Reference related issues
- Include screenshots if applicable

## 🐛 Issue Templates

### **Bug Report**
```markdown
**Bug Description**
Brief description of the problem.

**To Reproduce**
1. Run '...'
2. Click on '....'
3. See error

**Expected Behavior**
What should happen.

**System:**
- OS: [e.g. Ubuntu 22.04]
- Kernel: [e.g. 5.15.0]
- Device: [e.g. AK500S Digital]

**Logs**
```
sudo journalctl -u deepcool-digital -n 20
```
```

### **Feature Request**
```markdown
**Feature Request**
Clear description of the functionality.

**Motivation**
Why would this feature be useful?

**Proposed Solution**
How do you imagine this would work?

**Alternatives Considered**
Other approaches you've considered.
```

## 💖 Recognition

Contributors are listed in the README and releases. Major contributions may receive special recognition!

## 📞 Contact

- 📧 Email: guicampos1992@gmail.com
- 💬 Issues: [GitHub Issues](../../issues)
- 🐦 Discussions: [GitHub Discussions](../../discussions)

---

**⭐ Thank you for contributing! ⭐**