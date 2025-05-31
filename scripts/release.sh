#!/bin/bash

# Flutter 项目版本发布脚本
# 用法: ./scripts/release.sh <version>
# 例如: ./scripts/release.sh 1.0.0

set -e

if [ -z "$1" ]; then
    echo "❌ 错误: 请提供版本号"
    echo "用法: $0 <version>"
    echo "例如: $0 1.0.0"
    exit 1
fi

VERSION=$1
TAG="v$VERSION"

echo "🚀 准备发布版本 $VERSION"

# 检查是否在正确的分支
CURRENT_BRANCH=$(git branch --show-current)
if [ "$CURRENT_BRANCH" != "main" ]; then
    echo "⚠️  警告: 当前不在 main 分支 (当前分支: $CURRENT_BRANCH)"
    read -p "是否继续? (y/N): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "❌ 已取消发布"
        exit 1
    fi
fi

# 检查工作区是否干净
if [ -n "$(git status --porcelain)" ]; then
    echo "❌ 错误: 工作区有未提交的更改"
    git status
    exit 1
fi

# 更新 pubspec.yaml 中的版本号
echo "📝 更新 pubspec.yaml 版本号为 $VERSION"
if command -v sed >/dev/null 2>&1; then
    if [[ "$OSTYPE" == "darwin"* ]]; then
        # macOS - 使用更精确的匹配模式
        sed -i '' "s/^version: [0-9]*\.[0-9]*\.[0-9]*+[0-9]*/version: $VERSION+1/" pubspec.yaml
    else
        # Linux
        sed -i "s/^version: [0-9]*\.[0-9]*\.[0-9]*+[0-9]*/version: $VERSION+1/" pubspec.yaml
    fi
else
    echo "⚠️  请手动更新 pubspec.yaml 中的版本号为: $VERSION+1"
    echo "然后按任意键继续..."
    read -n 1
fi

# 检查 pubspec.yaml 是否成功更新
if grep -q "version: $VERSION+1" pubspec.yaml; then
    echo "✅ 版本号已更新"
else
    echo "❌ 版本号更新失败，请检查 pubspec.yaml"
    exit 1
fi

# 提交版本更新
echo "💾 提交版本更新"
git add pubspec.yaml
git commit -m "chore: bump version to $VERSION"

# 创建并推送标签
echo "🏷️  创建标签 $TAG"
git tag -a "$TAG" -m "Release $VERSION"

echo "📤 推送更改和标签到远程仓库"
git push origin main
git push origin "$TAG"

echo "🎉 版本 $VERSION 发布完成!"
echo "📋 GitHub Actions 将自动开始构建和发布流程"
echo "🔗 查看进度: https://github.com/difyz9/hello_flutter/actions"
echo "📦 发布完成后可在此查看: https://github.com/difyz9/hello_flutter/releases"
