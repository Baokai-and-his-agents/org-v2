#!/bin/bash
# GitHub 统计数据收集脚本
# 使用 GitHub API 收集项目统计信息

set -e

REPO="Baokai-and-his-agents/org-v2"
OUTPUT_DIR="ops/analytics"
DATE=$(date +%Y-%m-%d)

echo "📊 收集 GitHub 统计数据..."

# 创建输出目录
mkdir -p "$OUTPUT_DIR"

# 基础统计（无需 token）
echo "## GitHub Stats - $DATE" > "$OUTPUT_DIR/stats-$DATE.md"
echo "" >> "$OUTPUT_DIR/stats-$DATE.md"

# Stars, Forks, Watchers
echo "### 基础指标" >> "$OUTPUT_DIR/stats-$DATE.md"
echo "" >> "$OUTPUT_DIR/stats-$DATE.md"
echo "| 指标 | 数值 |" >> "$OUTPUT_DIR/stats-$DATE.md"
echo "|------|------|" >> "$OUTPUT_DIR/stats-$DATE.md"

# 使用 gh CLI 获取数据（如果可用）
if command -v gh &> /dev/null; then
    STARS=$(gh api repos/$REPO --jq '.stargazers_count' 2>/dev/null || echo "N/A")
    FORKS=$(gh api repos/$REPO --jq '.forks_count' 2>/dev/null || echo "N/A")
    WATCHERS=$(gh api repos/$REPO --jq '.watchers_count' 2>/dev/null || echo "N/A")
    ISSUES=$(gh api repos/$REPO --jq '.open_issues_count' 2>/dev/null || echo "N/A")
    
    echo "| Stars | $STARS |" >> "$OUTPUT_DIR/stats-$DATE.md"
    echo "| Forks | $FORKS |" >> "$OUTPUT_DIR/stats-$DATE.md"
    echo "| Watchers | $WATCHERS |" >> "$OUTPUT_DIR/stats-$DATE.md"
    echo "| Open Issues | $ISSUES |" >> "$OUTPUT_DIR/stats-$DATE.md"
else
    echo "| Stars | [需要 gh CLI] |" >> "$OUTPUT_DIR/stats-$DATE.md"
    echo "| Forks | [需要 gh CLI] |" >> "$OUTPUT_DIR/stats-$DATE.md"
fi

echo "" >> "$OUTPUT_DIR/stats-$DATE.md"

# 本地统计
echo "### 本地统计" >> "$OUTPUT_DIR/stats-$DATE.md"
echo "" >> "$OUTPUT_DIR/stats-$DATE.md"

COMMITS=$(git rev-list --count HEAD 2>/dev/null || echo "N/A")
CONTRIBUTORS=$(git log --format='%aN' | sort -u | wc -l | xargs)
LAST_COMMIT=$(git log -1 --format=%cd --date=short 2>/dev/null || echo "N/A")

echo "| 指标 | 数值 |" >> "$OUTPUT_DIR/stats-$DATE.md"
echo "|------|------|" >> "$OUTPUT_DIR/stats-$DATE.md"
echo "| Total Commits | $COMMITS |" >> "$OUTPUT_DIR/stats-$DATE.md"
echo "| Contributors | $CONTRIBUTORS |" >> "$OUTPUT_DIR/stats-$DATE.md"
echo "| Last Commit | $LAST_COMMIT |" >> "$OUTPUT_DIR/stats-$DATE.md"

echo "" >> "$OUTPUT_DIR/stats-$DATE.md"
echo "_生成时间: $(date)_" >> "$OUTPUT_DIR/stats-$DATE.md"

echo "✅ 统计数据已保存到 $OUTPUT_DIR/stats-$DATE.md"
cat "$OUTPUT_DIR/stats-$DATE.md"
