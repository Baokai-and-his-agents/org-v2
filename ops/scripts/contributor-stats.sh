#!/bin/bash
# 生成贡献者统计

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"

cd "$REPO_ROOT"

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "📊 Contributor Statistics"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# 总贡献者
TOTAL_CONTRIBUTORS=$(git log --format='%aN' | sort -u | wc -l | tr -d ' ')
echo "Total Contributors: $TOTAL_CONTRIBUTORS"
echo ""

# 贡献者排行
echo "Top Contributors (by commits):"
echo ""
git log --format='%aN' | sort | uniq -c | sort -rn | head -10 | while read count name; do
    echo "  $count commits - $name"
done

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "📈 Activity Timeline"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# 每月提交
echo "Commits by Month:"
echo ""
git log --date=format:'%Y-%m' --format='%ad' | sort | uniq -c | tail -12 | while read count month; do
    bars=$(printf '█%.0s' $(seq 1 $((count / 5))))
    [ -z "$bars" ] && bars="█"
    echo "  $month: $count $bars"
done

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "📝 Activity Summary"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# 总提交
TOTAL_COMMITS=$(git rev-list --count HEAD)
echo "Total Commits: $TOTAL_COMMITS"

# 文件修改
FILES_CHANGED=$(git log --pretty=format: --name-only | sort -u | wc -l | tr -d ' ')
echo "Total Files Changed: $FILES_CHANGED"

# 最近活跃
LAST_COMMIT_DATE=$(git log -1 --format='%cd' --date=relative)
echo "Last Commit: $LAST_COMMIT_DATE"

# 第一次提交
FIRST_COMMIT_DATE=$(git log --reverse --format='%cd' --date=short | head -1)
echo "First Commit: $FIRST_COMMIT_DATE"

# 项目天数
if [ "$(uname)" = "Darwin" ]; then
    DAYS_SINCE=$(( ($(date +%s) - $(date -j -f "%Y-%m-%d" "$FIRST_COMMIT_DATE" +%s)) / 86400 ))
else
    DAYS_SINCE=$(( ($(date +%s) - $(date -d "$FIRST_COMMIT_DATE" +%s)) / 86400 ))
fi

# 修复除零问题
if [ "$DAYS_SINCE" -eq 0 ]; then
    DAYS_SINCE=1
fi

echo "Project Age: $DAYS_SINCE days"

# 平均每天提交
AVG_COMMITS_PER_DAY=$(awk "BEGIN {printf \"%.1f\", $TOTAL_COMMITS/$DAYS_SINCE}")
echo "Avg Commits/Day: $AVG_COMMITS_PER_DAY"

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🏆 Milestones"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# 提交里程碑
if [ "$TOTAL_COMMITS" -ge 100 ]; then
    echo "✅ 100+ commits achieved!"
fi

if [ "$TOTAL_COMMITS" -ge 50 ]; then
    echo "✅ 50+ commits achieved!"
fi

# 文件里程碑
if [ "$FILES_CHANGED" -ge 100 ]; then
    echo "✅ 100+ files touched!"
fi

# 持续性
if [ "$DAYS_SINCE" -ge 7 ]; then
    echo "✅ Week+ of development!"
fi

echo ""
