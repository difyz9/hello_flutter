# Hello Flutter 🚀

一个支持跨平台自动化构建和发布的Flutter桌面应用程序。

## ✨ 特性

- 🖥️ **跨平台支持**: Windows、macOS、Linux
- 🤖 **自动化构建**: GitHub Actions自动构建和发布
- 📦 **一键发布**: 简单的脚本实现版本发布
- 🔄 **持续集成**: 自动化测试和构建流程

## 🛠️ 开发环境

- Flutter 3.24.3+
- Dart 3.7.2+

## 🚀 快速开始

### 克隆仓库
```bash
git clone https://github.com/difyz9/hello_flutter.git
cd hello_flutter
```

### 安装依赖
```bash
flutter pub get
```

### 运行应用
```bash
# macOS
flutter run -d macos

# Windows  
flutter run -d windows

# Linux
flutter run -d linux
```

## 📦 自动化发布

本项目配置了完整的GitHub Actions自动化构建和发布流程。

### 发布新版本

使用发布脚本（推荐）：
```bash
./scripts/release.sh 1.0.1
```

或手动创建标签：
```bash
git tag -a v1.0.1 -m "Release 1.0.1"
git push origin v1.0.1
```

### 构建流程

当推送版本标签时，GitHub Actions会自动：

1. **并行构建三个平台**
   - 🐧 Linux (Ubuntu): `.tar.gz`
   - 🪟 Windows: `.zip`
   - 🍎 macOS: `.tar.gz`

2. **运行测试** 确保代码质量

3. **创建Release** 自动生成GitHub Release

4. **上传构建产物** 用户可直接下载

## 🔗 相关链接

- [📋 GitHub Actions](https://github.com/difyz9/hello_flutter/actions)
- [📦 Releases](https://github.com/difyz9/hello_flutter/releases)
- [📖 发布指南](./RELEASE.md)

## 🏗️ 项目结构

```
hello_flutter/
├── lib/                    # Flutter应用源码
├── .github/workflows/      # GitHub Actions配置
├── scripts/               # 发布脚本
├── android/               # Android平台代码
├── ios/                   # iOS平台代码
├── linux/                 # Linux平台代码
├── macos/                 # macOS平台代码
├── windows/               # Windows平台代码
└── web/                   # Web平台代码
```

## 🤝 贡献

欢迎提交Issue和Pull Request！

## 📄 许可证

本项目采用MIT许可证。
