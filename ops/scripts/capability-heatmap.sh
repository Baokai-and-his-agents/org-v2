#!/bin/bash
# 生成能力使用热力图

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"

cd "$REPO_ROOT"

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🔥 Capability Usage Heatmap"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# 检查能力引用
analyze_usage() {
    local cap_name=$1
    local cap_file=$2
    
    # 在所有文件中搜索引用（排除自己）
    local count=$(grep -r "\[\[$cap_name\]\]" capabilities/ docs/ --exclude="$cap_file" 2>/dev/null | wc -l | tr -d ' ')
    
    echo "$count:$cap_name"
}

echo "📊 Skills Usage"
echo ""

# 收集所有 skills 的使用数据
SKILLS_DATA=()
for skill in capabilities/skill/*.md; do
    [ -f "$skill" ] || continue
    name=$(basename "$skill" .md)
    usage=$(analyze_usage "$name" "$(basename "$skill")")
    SKILLS_DATA+=("$usage")
done

# 排序并显示
printf '%s\n' "${SKILLS_DATA[@]}" | sort -rn -t: | head -10 | while IFS=: read count name; do
    # 生成热力图
    if [ "$count" -ge 3 ]; then
        heat="🔥🔥🔥"
    elif [ "$count" -ge 2 ]; then
        heat="🔥🔥"
    elif [ "$count" -ge 1 ]; then
        heat="🔥"
    else
        heat="❄️"
    fi
    
    # 生成进度条
    bars=$(printf '█%.0s' $(seq 1 $count))
    
    printf "  %-40s %s %s (%d)\n" "$name" "$heat" "$bars" "$count"
done

echo ""
echo "📊 Knowledge Usage"
echo ""

# 收集所有 knowledge 的使用数据
KNOWLEDGE_DATA=()
for knowledge in capabilities/knowledge/*.md; do
    [ -f "$knowledge" ] || continue
    name=$(basename "$knowledge" .md)
    usage=$(analyze_usage "$name" "$(basename "$knowledge")")
    KNOWLEDGE_DATA+=("$usage")
done

# 排序并显示
printf '%s\n' "${KNOWLEDGE_DATA[@]}" | sort -rn -t: | head -10 | while IFS=: read count name; do
    # 生成热力图
    if [ "$count" -ge 3 ]; then
        heat="🔥🔥🔥"
    elif [ "$count" -ge 2 ]; then
        heat="🔥🔥"
    elif [ "$count" -ge 1 ]; then
        heat="🔥"
    else
        heat="❄️"
    fi
    
    # 生成进度条
    bars=$(printf '█%.0s' $(seq 1 $count))
    
    printf "  %-40s %s %s (%d)\n" "$name" "$heat" "$bars" "$count"
done

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🎯 Usage Categories"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# 统计不同使用频率
HOT=$(printf '%s\n' "${SKILLS_DATA[@]}" "${KNOWLEDGE_DATA[@]}" | awk -F: '$1 >= 3' | wc -l | tr -d ' ')
WARM=$(printf '%s\n' "${SKILLS_DATA[@]}" "${KNOWLEDGE_DATA[@]}" | awk -F: '$1 >= 2 && $1 < 3' | wc -l | tr -d ' ')
COOL=$(printf '%s\n' "${SKILLS_DATA[@]}" "${KNOWLEDGE_DATA[@]}" | awk -F: '$1 == 1' | wc -l | tr -d ' ')
COLD=$(printf '%s\n' "${SKILLS_DATA[@]}" "${KNOWLEDGE_DATA[@]}" | awk -F: '$1 == 0' | wc -l | tr -d ' ')

TOTAL=$((HOT + WARM + COOL + COLD))

echo "🔥🔥🔥 Hot (≥3 refs):   $HOT capabilities"
echo "🔥🔥  Warm (2 refs):    $WARM capabilities"
echo "🔥   Cool (1 ref):     $COOL capabilities"
echo "❄️    Cold (0 refs):    $COLD capabilities"
echo ""
echo "Total analyzed: $TOTAL capabilities"

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "💡 Insights"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

if [ "$HOT" -gt 0 ]; then
    echo "✅ You have $HOT highly-connected capabilities"
    echo "   These are core to your knowledge graph"
fi

if [ "$COLD" -gt 0 ]; then
    echo "💡 $COLD capabilities have no references yet"
    echo "   Consider linking them or archiving if unused"
fi

HOTNESS_RATIO=$((HOT * 100 / TOTAL))
echo ""
echo "Knowledge graph density: $HOTNESS_RATIO%"

if [ "$HOTNESS_RATIO" -ge 20 ]; then
    echo "🔥 Excellent interconnection!"
elif [ "$HOTNESS_RATIO" -ge 10 ]; then
    echo "✅ Good interconnection"
else
    echo "💡 Consider adding more cross-references"
fi

echo ""
