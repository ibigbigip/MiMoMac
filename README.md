# MiMo AI macOS Client

小米 MIMO 大模型 macOS 桌面客户端

## 🖥️ 下载安装

**[📦 下载 MiMo_AI_v1.0.dmg](https://github.com/ibigbigip/MiMoMac/releases/download/v1.0.0/MiMo_AI_v1.0.dmg)**

双击 DMG 文件，将 MiMo AI 拖入 Applications 文件夹即可使用。

## 功能特点

- 🧠 支持深度思考过程展示
- 🌐 联网搜索功能
- 💬 多轮对话
- ⚡ 快速响应
- 🖥️ 原生 macOS 体验
- 🔙 支持浏览器导航（前进/后退/刷新）

## 系统要求

- macOS 13.0 (Ventura) 或更高版本

## 从源码编译

```bash
# 克隆仓库
git clone https://github.com/ibigbigip/MiMoMac.git
cd MiMoMac

# 安装 XcodeGen（如果没有）
brew install xcodegen

# 生成项目
xcodegen generate

# 打开项目
open MiMoMac.xcodeproj
```

在 Xcode 中按 Cmd+R 运行。

## 项目结构

```
MiMoMac/
├── MiMoMac/
│   ├── MiMoMacApp.swift      # App 入口
│   ├── ContentView.swift      # WebView 主视图
│   ├── Info.plist
│   └── Assets.xcassets/       # 资源文件
└── project.yml                # XcodeGen 配置
```

## 截图

应用启动后会直接加载小米 MiMo Studio 网页版，享受完整的 AI 对话体验。

## 技术栈

- SwiftUI
- WKWebView
- XcodeGen

## 许可证

MIT License

## 相关项目

- [MiMoAI (iOS版)](https://github.com/ibigbigip/MiMoAI) - iOS 客户端

## 致谢

- 小米 MIMO 团队提供的 AI 服务
