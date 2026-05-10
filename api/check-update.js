// Vercel Serverless Function - 检查更新
const https = require('https');

module.exports = async (req, res) => {
    // 设置 CORS
    res.setHeader('Access-Control-Allow-Origin', '*');
    res.setHeader('Access-Control-Allow-Methods', 'GET, OPTIONS');
    res.setHeader('Access-Control-Allow-Headers', 'Content-Type');

    if (req.method === 'OPTIONS') {
        return res.status(200).end();
    }

    const { id, version } = req.query;

    if (!id) {
        return res.status(400).json({ error: 'Missing app id' });
    }

    try {
        // 从 GitHub Releases 获取最新版本
        const repo = '你的用户名/你的仓库名'; // 替换为你的仓库
        const url = `https://api.github.com/repos/${repo}/releases/latest`;

        const response = await fetch(url, {
            headers: {
                'User-Agent': 'App-Store/1.0'
            }
        });

        if (!response.ok) {
            throw new Error('Failed to fetch release info');
        }

        const release = await response.json();
        const latestVersion = release.tag_name.replace('v', '');
        const currentVersion = version || '0.0.0';

        // 比较版本
        const hasUpdate = compareVersions(latestVersion, currentVersion) > 0;

        return res.status(200).json({
            hasUpdate,
            latestVersion,
            currentVersion,
            downloadUrl: release.assets[0]?.browser_download_url || '',
            changelog: release.body || '',
            publishedAt: release.published_at
        });
    } catch (error) {
        console.error('Check update error:', error);
        return res.status(500).json({ error: 'Failed to check update' });
    }
};

// 版本比较函数
function compareVersions(v1, v2) {
    const parts1 = v1.split('.').map(Number);
    const parts2 = v2.split('.').map(Number);

    for (let i = 0; i < Math.max(parts1.length, parts2.length); i++) {
        const num1 = parts1[i] || 0;
        const num2 = parts2[i] || 0;

        if (num1 > num2) return 1;
        if (num1 < num2) return -1;
    }

    return 0;
}
