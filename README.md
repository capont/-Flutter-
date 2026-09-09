# Market Quote App — 贵金属/原油行情·资讯聚合监控台

Flutter 跨平台应用，支持 iOS / Android 同时运行。

---

## 项目结构


market_quote_app/
├── README.md
├── pubspec.yaml
├── lib/
│   ├── main.dart                          # 入口文件，底部 Tab 导航
│   ├── models/
│   │   ├── quote_model.dart               # 行情数据模型
│   │   ├── calendar_event.dart            # 财经日历数据模型
│   │   └── news_item.dart                 # 新闻数据模型
│   ├── viewmodels/
│   │   ├── quote_viewmodel.dart           # 行情 ViewModel（1秒轮询）
│   │   ├── calendar_viewmodel.dart        # 财经日历 ViewModel
│   │   └── news_viewmodel.dart            # 要闻 ViewModel
│   ├── views/
│   │   ├── quote_overview_page.dart       # 行情总览页
│   │   ├── calendar_page.dart             # 财经日历页
│   │   └── news_page.dart                 # 要闻页
│   └── widgets/
│       ├── quote_card.dart                # 行情卡片组件
│       ├── calendar_cell.dart             # 日历条目组件
│       └── news_cell.dart                 # 新闻条目组件
├── android/                               # Android 原生工程
├── ios/                                   # iOS 原生工程
└── test/                                  # 测试


---

## 环境要求

| 工具 | 版本 |
|------|------|
| Flutter SDK | >= 3.0.0 |
| Dart SDK | >= 3.0.0 |
| Android Studio | 推荐最新版（Android 构建） |
| Xcode | 15+（iOS 构建，仅 macOS） |

---

## 快速开始

### 1. 创建项目

bash
flutter create market_quote_app
cd market_quote_app


### 2. 替换文件

将本仓库中的文件按以下方式放置：

- 用本项目的 `pubspec.yaml` **替换** 项目根目录下的 `pubspec.yaml`
- 将 `lib/` 目录下的所有文件 **按结构复制** 到项目的 `lib/` 目录中（覆盖同名文件）

最终 `lib/` 目录结构应与上方项目结构一致。

### 3. 安装依赖

bash
flutter pub get


### 4. 运行

#### Android（USB 连接设备或模拟器）

bash
查看已连接设备

flutter devices

运行到设备

flutter run

或构建 APK

flutter build apk

构建完成后 APK 位于：

build/app/outputs/flutter-apk/app-release.apk



#### iOS（仅 macOS）

bash
cd ios
pod install
cd ..
flutter run


---

## 接口说明

| 接口 | URL | 刷新频率 |
|------|-----|----------|
| 行情聚合 | `https://sina-quote.npcdp.de5.net/aggregate` | 1 秒 |
| 财经日历 | `https://news.npcdp.de5.net/api/calendar` | 手动下拉刷新 |
| 要闻 | `https://news.npcdp.de5.net/api/news` | 手动下拉刷新 |

---

## 功能说明

- **行情总览页**：实时显示现货黄金、现货白银、WTI美油、布伦特原油的报价，1 秒自动刷新，支持下拉刷新
- **财经日历页**：展示经济数据发布时间、预测值、前值、实际值，支持下拉刷新
- **要闻页**：展示最新财经新闻，点击可跳转原文链接，支持下拉刷新

---

## 架构


┌──────────────────────────────────────────┐
│  View (views/ + widgets/)                 │
│  - 页面 UI + 组件                        │
│  - 监听 ViewModel 通知刷新               │
├──────────────────────────────────────────┤
│  ViewModel (viewmodels/)                  │
│  - 网络请求 + 数据解析                   │
│  - 行情 1 秒轮询                         │
│  - ChangeNotifier 驱动 UI 更新           │
├──────────────────────────────────────────┤
│  Model (models/)                          │
│  - 纯数据模型                            │
│  - JSON → Dart Object                    │
└──────────────────────────────────────────┘


---

## 常见问题

**Q: 运行报错 "MissingPluginException"？**
bash
flutter clean
flutter pub get
cd ios && pod install && cd ..
flutter run


**Q: Android 真机无法访问接口？**
确认设备网络可访问 `https://sina-quote.npcdp.de5.net` 和 `https://news.npcdp.de5.net`，或配置 VPN。

**Q: 如何修改轮询间隔？**
编辑 `lib/viewmodels/quote_viewmodel.dart`，修改 `Duration(seconds: 1)` 为所需间隔。

---

## License

MIT


