#!/bin/bash
# 工具使用频率追踪

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"

cd "$REPO_ROOT"

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "📊 Tool Usage Tracker"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# 分析 Git 提交历史中的工具使用
echo "Analyzing tool usage from Git history..."
echo ""

# 收集所有工具
TOOLS=(
    "export-capability.sh"
    "import-capability.sh"
    "search-capability.sh"
    "check-capabilities.sh"
    "capability-usage-stats.sh"
    "capability-dependencies.sh"
    "capability-heatmap.sh"
    "generate-weekly-report.sh"
    "generate-monthly-report.sh"
    "generate-stats-report.sh"
    "calculate-health-score.sh"
    "duty-check.sh"
    "contributor-stats.sh"
    "check-release-readiness.sh"
    "init-guide.sh"
    "tool-usage-tracker.sh"
)

echo "🔧 Tool Usage Frequency:"
echo ""

# 分析每个工具在提交中被提及的次数
for tool in "${TOOLS[@]}"; do
    count=$(git log --all --oneline --grep="$tool" 2>/dev/null | wc -l | tr -d ' ')
    
    # 生成星级评分
    if [ "$count" -ge 5 ]; then
        stars="⭐⭐⭐"
    elif [ "$count" -ge 3 ]; then
        stars="⭐⭐"
    elif [ "$count" -ge 1 ]; then
        stars="⭐"
    else
        stars="🆕"
    fi
    
    printf "  %-35s %s (%d mentions)\n" "$tool" "$stars" "$count"
done | sort -t'(' -k2 -rn

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "📈 Usage Statistics"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# 统计
TOTAL_TOOLS=${#TOOLS[@]}
MENTIONED=$(git log --all --oneline | grep -E "$(IFS='|'; echo "${TOOLS[*]}")" 2>/dev/null | wc -l | tr -d ' ')

echo "Total Tools: $TOTAL_TOOLS"
echo "Total Mentions: $MENTIONED"

if [ "$MENTIONED" -gt 0 ]; then
    AVG=$(awk "BEGIN {printf \"%.1f\", $MENTIONED/$TOTAL_TOOLS}")
    echo "Avg Mentions/Tool: $AVG"
fi

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "💡 Insights"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

echo "⭐⭐⭐ = Frequently used (≥5 mentions)"
echo "⭐⭐  = Moderately used (3-4 mentions)"
echo "⭐   = Occasionally used (1-2 mentions)"
echo "🆕   = New tool (not yet mentioned)"

echo ""
echo "Note: This tracks tool mentions in commit messages,"
echo "not actual execution frequency."

echo ""
