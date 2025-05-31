# 📦 自动化发布使用指南

本项目配置了GitHub Actions自动化构建和发布系统，支持Mac、Windows、Linux三个平台的自动打包。

## 🚀 如何发布新版本

### 方法一：使用发布脚本（推荐）

1. 确保你在 `main` 分支且工作区干净
2. 运行发布脚本：
   ```bash
   ./scripts/release.sh 1.0.0
   ```
   （将 `1.0.0` 替换为你想要的版本号）

### 方法二：手动发布

1. 更新 `pubspec.yaml` 中的版本号
2. 提交更改：
   ```bash
   git add pubspec.yaml
   git commit -m "chore: bump version to 1.0.0"
   ```
3. 创建并推送标签：
   ```bash
   git tag -a v1.0.0 -m "Release 1.0.0"
   git push origin main
   git push origin v1.0.0
   ```

## 📋 自动化流程说明

当你推送以 `v` 开头的标签时（如 `v1.0.0`），GitHub Actions 会自动：

1. **并行构建三个平台**：
   - 🐧 **Linux**: 构建 `.tar.gz` 包
   - 🪟 **Windows**: 构建 `.zip` 包  
   - 🍎 **macOS**: 构建 `.tar.gz` 包

2. **自动创建GitHub Release**：
   - 包含所有平台的可执行文件
   - 自动生成发布说明
   - 提供下载链接和安装说明

## 🔗 相关链接

- **Actions页面**: https://github.com/difyz9/hello_flutter/actions
- **Releases页面**: https://github.com/difyz9/hello_flutter/releases

## 📁 构建输出

构建完成后，各平台的文件位置：

- **Linux**: `build/linux/x64/release/bundle/`
- **Windows**: `build/windows/x64/runner/Release/`
- **macOS**: `build/macos/Build/Products/Release/`

## ⚙️ 工作流配置

工作流文件位于：`.github/workflows/release.yml`

支持的触发方式：
- 🏷️ 推送版本标签（`v*`）
- 🖱️ 手动触发（在GitHub Actions页面）

## 📝 版本号约定

建议使用语义化版本号：`主版本.次版本.修订号`

- **主版本**：不兼容的API修改
- **次版本**：向后兼容的功能增加
- **修订号**：向后兼容的bug修复

例如：`1.0.0`、`1.1.0`、`1.1.1`
