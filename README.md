# 📦 我的应用商店

免费下载、自动更新、安全可靠

## 🚀 访问应用商店

**点击下方链接访问应用商店：**

### 👉 [http://lyz.lyz.gt.tc/app.html](http://lyz.lyz.gt.tc/app.html)

---

## 📱 如何下载应用

1. 打开应用商店链接
2. 找到你想要的应用
3. 点击 **"⬇️ 下载 APK"** 按钮
4. APK 文件会自动下载到你的手机
5. 打开下载的 APK 文件安装

---

## ⚙️ 开发者信息

### 上传新应用

```bash
# 使用脚本上传
./scripts/upload.sh -v 1.0.0 -f ./app.apk -c "初始版本"

# 或手动上传到 GitHub Releases
```

### 修改应用信息

编辑 `app.html` 文件中的 `apps` 数组：

```javascript
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

---

## 📊 免费额度

- **GitHub Pages**: 免费托管
- **GitHub Releases**: 无限存储
- **GitHub Actions**: 2000 分钟/月

---

## 📞 联系方式

如有问题，请联系开发者。
