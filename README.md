# MiMo AI macOS Client

小米 MIMO 大模型 macOS 桌面客户端

## 🖥️ 下载安装

**[📦 下载 MiMo_AI_v1.0.dmg](https://github.com/ibigbigip/MiMoMac/releases/download/v1.0.0/MiMo_AI_v1.0.dmg)**

### 安装步骤：
1. 下载上面的 DMG 文件
2. 双击打开 DMG
3. 将 **MiMo AI** 拖入 **Applications** 文件夹
4. 在启动台中找到 MiMo AI 打开即可使用

> ⚠️ 首次打开如果提示"无法验证开发者"，请到 **系统设置 → 隐私与安全性** 中点击"仍要打开"

## 功能特点

- 🧠 支持深度思考过程展示
- 🌐 联网搜索功能
- 💬 多轮对话
- ⚡ 快速响应
- 🖥️ 原生 macOS 体验
- 🔙 支持浏览器导航（前进/后退/刷新）

## 系统要求

- macOS 13.0 (Ventura) 或更高版本

## 截图

应用启动后会直接加载小米 MiMo Studio，享受完整的 AI 对话体验。

---

## 开发者：从源码编译

如果您想自己编译或修改代码：

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

在 Xcode 中按 Cmd+R 编译运行。

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
