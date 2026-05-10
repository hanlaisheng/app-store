# 📦 我的应用商店

基于 Vercel 的个人应用商店，完全免费，国内访问速度快。

## ✨ 特性

- ✅ **完全免费** - 无需任何费用
- ✅ **国内访问快** - Vercel 国内 CDN 加速
- ✅ **自动更新** - 支持 Android 应用自动更新
- ✅ **版本管理** - GitHub Releases 天然支持
- ✅ **一键部署** - Vercel 自动部署
- ✅ **响应式设计** - 支持手机和电脑

## 🚀 快速开始

### 1. 克隆项目

```bash
git clone https://github.com/你的用户名/app-store.git
cd app-store
```

### 2. 部署到 Vercel

1. 访问 https://vercel.com/new
2. 导入你的 GitHub 仓库
3. 点击 "Deploy"

### 3. 上传应用

```bash
# 使用脚本上传
./scripts/upload.sh -v 1.0.0 -f ./app.apk -c "初始版本"

# 或手动上传到 GitHub Releases
```

## 📁 项目结构

```
app-store/
├── public/
│   └── index.html          # 商店首页
├── api/
│   └── check-update.js     # 检查更新 API
├── scripts/
│   └── upload.sh           # 上传脚本
├── .github/
│   └── workflows/
│       └── release.yml     # 自动发布工作流
├── vercel.json             # Vercel 配置
└── package.json
```

## 🔧 配置

### 修改应用信息

编辑 `public/index.html` 文件：

```javascript
const GITHUB_REPO = '你的用户名/你的仓库名';

const apps = [
    {
        id: 'my-app',
        name: '我的应用',
        description: '应用描述',
        version: '1.0.0',
        icon: '📱',
        size: '10MB',
        category: '工具',
        downloadUrl: `https://github.com/${GITHUB_REPO}/releases/latest/download/app-release.apk`
    }
];
```

### 绑定自定义域名

1. 在 Vercel 项目设置中点击 "Domains"
2. 添加你的域名
3. 配置 DNS 记录

## 📲 Android 自动更新

在你的 Android 应用中集成：

```kotlin
// 检查更新
suspend fun checkUpdate(currentVersion: String): UpdateInfo? {
    val url = "https://你的域名/api/check-update?id=my-app&version=$currentVersion"
    val response = httpClient.get(url)
    return if (response.hasUpdate) response else null
}

// 下载更新
fun downloadUpdate(downloadUrl: String) {
    val intent = Intent(Intent.ACTION_VIEW, Uri.parse(downloadUrl))
    startActivity(intent)
}
```

## 📊 免费额度

- **Vercel 带宽**: 100GB/月
- **GitHub Releases**: 无限存储
- **GitHub Actions**: 2000 分钟/月

## 🌐 国内访问优化

### 方案 1: 绑定自定义域名

在 Vercel 中绑定你的域名，访问速度更快。

### 方案 2: 使用国内 CDN

将 APK 上传到腾讯云 COS 或阿里云 OSS，配置 CDN 加速。

## 🔍 常见问题

### Q: 如何更新应用？

A: 在 GitHub 创建新的 Release，上传新版本的 APK。

### Q: 如何查看下载统计？

A: 在 GitHub 仓库的 "Insights" → "Traffic" 中查看。

### Q: 国内访问慢怎么办？

A: 绑定自定义域名或使用国内 CDN。

## 📚 文档

- [部署指南](DEPLOY.md)
- [Vercel 文档](https://vercel.com/docs)
- [GitHub 文档](https://docs.github.com)

## 📄 许可证

MIT License

## 🙏 致谢

- [Vercel](https://vercel.com) - 免费托管
- [GitHub](https://github.com) - 代码托管和 Releases
