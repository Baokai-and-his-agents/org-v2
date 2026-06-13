#!/bin/bash
# 项目备份工具

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"

cd "$REPO_ROOT"

# 默认备份目录
BACKUP_DIR="${1:-../backups/org-v2}"
TIMESTAMP=$(date +%Y%m%d-%H%M%S)
BACKUP_NAME="org-v2-backup-$TIMESTAMP"

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "💾 Project Backup Tool"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# 创建备份目录
mkdir -p "$BACKUP_DIR"
BACKUP_PATH="$BACKUP_DIR/$BACKUP_NAME"

echo "📦 Creating backup..."
echo "Target: $BACKUP_PATH"
echo ""

# 备份核心内容
echo "Backing up:"

# 1. 能力资产
if [ -d "capabilities" ]; then
    echo "  ✅ Capabilities"
    cp -r capabilities "$BACKUP_PATH-capabilities"
fi

# 2. 文档
echo "  ✅ Documentation"
mkdir -p "$BACKUP_PATH-docs"
for doc in README.md QUICKSTART.md FAQ.md CONTRIBUTING.md CODE_OF_CONDUCT.md \
           CHANGELOG.md SECURITY.md LICENSE CONTRIBUTORS.md NOW.md; do
    [ -f "$doc" ] && cp "$doc" "$BACKUP_PATH-docs/"
done
[ -d "docs" ] && cp -r docs "$BACKUP_PATH-docs/docs"

# 3. 配置文件
echo "  ✅ Configuration"
mkdir -p "$BACKUP_PATH-config"
for config in .gitignore .editorconfig; do
    [ -f "$config" ] && cp "$config" "$BACKUP_PATH-config/"
done
[ -d ".github" ] && cp -r .github "$BACKUP_PATH-config/.github"

# 4. 工具脚本
if [ -d "ops/scripts" ]; then
    echo "  ✅ Tools & Scripts"
    mkdir -p "$BACKUP_PATH-ops"
    cp -r ops/scripts "$BACKUP_PATH-ops/"
fi

# 5. 测试
if [ -d "ops/tests" ]; then
    echo "  ✅ Tests"
    cp -r ops/tests "$BACKUP_PATH-ops/tests" 2>/dev/null || true
fi

# 6. 创建备份清单
echo "  ✅ Manifest"
cat > "$BACKUP_PATH-manifest.txt" << MANIFEST
Backup Created: $(date)
Source: $(pwd)
Backup ID: $BACKUP_NAME

Contents:
- Capabilities: $(find capabilities -name "*.md" 2>/dev/null | wc -l | tr -d ' ') files
- Documentation: $(ls -1 *.md 2>/dev/null | wc -l | tr -d ' ') root docs
- Tools: $(find ops/scripts -name "*.sh" 2>/dev/null | wc -l | tr -d ' ') scripts
- Tests: $(find ops/tests -name "*.sh" 2>/dev/null | wc -l | tr -d ' ') test files

Git Info:
- Commit: $(git rev-parse HEAD 2>/dev/null || echo "N/A")
- Branch: $(git branch --show-current 2>/dev/null || echo "N/A")
- Status: $(git status --short 2>/dev/null | wc -l | tr -d ' ') uncommitted files
MANIFEST

# 7. 压缩备份（可选）
echo ""
echo "📦 Creating archive..."
cd "$BACKUP_DIR"
tar -czf "$BACKUP_NAME.tar.gz" \
    "$BACKUP_NAME-capabilities" \
    "$BACKUP_NAME-docs" \
    "$BACKUP_NAME-config" \
    "$BACKUP_NAME-ops" \
    "$BACKUP_NAME-manifest.txt" 2>/dev/null

# 清理临时目录
rm -rf "$BACKUP_NAME-"*

ARCHIVE_SIZE=$(du -h "$BACKUP_NAME.tar.gz" | cut -f1)

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "✅ Backup Complete!"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "Location: $BACKUP_NAME.tar.gz"
echo "Size: $ARCHIVE_SIZE"
echo ""
echo "To restore:"
echo "  tar -xzf $BACKUP_NAME.tar.gz"
echo ""

