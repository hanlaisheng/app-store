# 应用商店部署指南 - Vercel

基于 Vercel 的个人应用商店，完全免费，国内访问速度快。

## 🚀 快速部署

### 步骤 1: 注册 Vercel 账号

1. 访问 https://vercel.com
2. 点击 "Sign Up"
3. 使用 GitHub 账号登录（推荐）

### 步骤 2: 创建 GitHub 仓库

1. 访问 https://github.com/new
2. 仓库名称: `app-store`
3. 选择 "Private" 或 "Public"
4. 点击 "Create repository"

### 步骤 3: 上传代码到 GitHub

```bash
# 克隆仓库
git clone https://github.com/你的用户名/app-store.git
cd app-store

# 复制项目文件
cp -r /mnt/e/work/app-store-github/* .

# 提交代码
git add .
git commit -m "Initial commit"
git push origin main
```

### 步骤 4: 部署到 Vercel

1. 访问 https://vercel.com/new
2. 点击 "Import Git Repository"
3. 选择你的 `app-store` 仓库
4. 点击 "Deploy"

### 步骤 5: 配置自定义域名（可选）

1. 在 Vercel 项目设置中点击 "Domains"
2. 添加你的域名
3. 按照提示配置 DNS

## 📱 上传应用

### 方法 1: 使用 GitHub Releases

1. 在 GitHub 仓库页面点击 "Releases"
2. 点击 "Create a new release"
3. 填写版本号（如 `v1.0.0`）
4. 上传 APK 文件
5. 点击 "Publish release"

### 方法 2: 使用 GitHub Actions 自动发布

当你推送带有 `v` 前缀的标签时，会自动构建并发布 APK：

```bash
# 创建标签
git tag v1.0.0
git push origin v1.0.0
```

## 🔧 配置应用信息

编辑 `public/index.html` 文件，修改以下内容：

```javascript
// 替换为你的 GitHub 仓库
const GITHUB_REPO = '你的用户名/你的仓库名';

// 修改应用列表
const apps = [
    {
        id: 'my-app',
        name: '我的应用',
        description: '应用描述',
        version: '1.0.0',
        icon: '📱', // 可以使用 emoji 或图片 URL
        size: '10MB',
        category: '工具',
        downloadUrl: `https://github.com/${GITHUB_REPO}/releases/latest/download/app-release.apk`
    }
];
```

## 📲 Android 自动更新集成

在你的 Android 应用中添加以下代码：

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

## 🌐 国内访问优化

### 方案 1: 绑定自定义域名

1. 在 Vercel 中绑定你的域名
2. 配置 CDN（如腾讯云 CDN、阿里云 CDN）

### 方案 2: 使用国内 CDN

1. 将 APK 文件上传到腾讯云 COS 或阿里云 OSS
2. 配置 CDN 加速
3. 修改 `downloadUrl` 为 CDN 地址

## 📊 免费额度

- **Vercel 带宽**: 100GB/月
- **Vercel 请求数**: 无限
- **GitHub Releases**: 无限存储
- **GitHub Actions**: 2000 分钟/月

## 🔍 常见问题

### Q: 如何更新应用？

A: 在 GitHub 创建新的 Release，上传新版本的 APK，然后更新 `public/index.html` 中的版本号。

### Q: 如何查看下载统计？

A: 在 GitHub 仓库的 "Insights" → "Traffic" 中可以查看下载次数。

### Q: 如何添加更多应用？

A: 在 `public/index.html` 的 `apps` 数组中添加新的应用信息。

### Q: 国内访问慢怎么办？

A: 绑定自定义域名并配置 CDN，或者使用腾讯云 COS + CDN 方案。

## 📞 技术支持

如有问题，请查看：
- Vercel 文档: https://vercel.com/docs
- GitHub 文档: https://docs.github.com
