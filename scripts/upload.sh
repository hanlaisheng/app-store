#!/bin/bash
# 应用上传脚本

set -e

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# 打印带颜色的消息
print_info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# 检查依赖
check_dependencies() {
    if ! command -v git &> /dev/null; then
        print_error "git 未安装，请先安装 git"
        exit 1
    fi
    
    if ! command -v gh &> /dev/null; then
        print_warn "gh CLI 未安装，将使用手动上传方式"
        USE_GH_CLI=false
    else
        USE_GH_CLI=true
    fi
}

# 显示帮助
show_help() {
    echo "应用上传脚本"
    echo ""
    echo "用法: $0 [选项]"
    echo ""
    echo "选项:"
    echo "  -v, --version VERSION    版本号 (如 1.0.0)"
    echo "  -f, --file FILE          APK 文件路径"
    echo "  -c, --changelog MESSAGE  更新日志"
    echo "  -h, --help               显示帮助"
    echo ""
    echo "示例:"
    echo "  $0 -v 1.0.0 -f ./app.apk -c '初始版本'"
}

# 解析参数
VERSION=""
APK_FILE=""
CHANGELOG=""

while [[ $# -gt 0 ]]; do
    case $1 in
        -v|--version)
            VERSION="$2"
            shift 2
            ;;
        -f|--file)
            APK_FILE="$2"
            shift 2
            ;;
        -c|--changelog)
            CHANGELOG="$2"
            shift 2
            ;;
        -h|--help)
            show_help
            exit 0
            ;;
        *)
            print_error "未知参数: $1"
            show_help
            exit 1
            ;;
    esac
done

# 验证参数
if [ -z "$VERSION" ]; then
    print_error "版本号不能为空"
    show_help
    exit 1
fi

if [ -z "$APK_FILE" ]; then
    print_error "APK 文件路径不能为空"
    show_help
    exit 1
fi

if [ ! -f "$APK_FILE" ]; then
    print_error "APK 文件不存在: $APK_FILE"
    exit 1
fi

# 检查依赖
check_dependencies

# 创建标签
print_info "创建标签 v$VERSION..."
git tag -a "v$VERSION" -m "Release v$VERSION"
git push origin "v$VERSION"

if [ "$USE_GH_CLI" = true ]; then
    # 使用 gh CLI 创建 Release
    print_info "使用 gh CLI 创建 Release..."
    gh release create "v$VERSION" "$APK_FILE" \
        --title "Release v$VERSION" \
        --notes "$CHANGELOG"
else
    # 手动上传提示
    print_warn "请手动上传 APK 文件到 GitHub Releases:"
    echo ""
    echo "1. 访问 https://github.com/你的用户名/你的仓库/releases"
    echo "2. 点击 'Create a new release'"
    echo "3. 选择标签: v$VERSION"
    echo "4. 填写标题: Release v$VERSION"
    echo "5. 填写更新日志: $CHANGELOG"
    echo "6. 上传 APK 文件: $APK_FILE"
    echo "7. 点击 'Publish release'"
    echo ""
fi

print_info "上传完成！"
print_info "下载链接: https://github.com/你的用户名/你的仓库/releases/latest/download/app-release.apk"
