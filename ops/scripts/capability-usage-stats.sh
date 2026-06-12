#!/bin/bash
# 能力使用统计工具
# 分析能力文件中的复用次数元数据

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BLUE}Capability Usage Statistics${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"

cd "$REPO_ROOT"

# 临时文件
TMPFILE=$(mktemp)
trap "rm -f $TMPFILE" EXIT

# 收集所有能力的使用次数
echo ""
echo "Analyzing capability usage..."
echo ""

for cap_file in capabilities/*/*.md; do
    if [ -f "$cap_file" ] && [ "$(basename "$cap_file")" != "TEMPLATE.md" ]; then
        # 提取复用次数
        usage=$(grep -E "^复用次数：|^reuse.*:" "$cap_file" | head -1 | grep -oE "[0-9]+" || echo "0")
        cap_name=$(basename "$cap_file" .md)
        cap_type=$(dirname "$cap_file" | xargs basename)
        
        echo "$usage|$cap_type|$cap_name" >> "$TMPFILE"
    fi
done

# 排序并显示
echo -e "${YELLOW}Top 10 Most Used Capabilities:${NC}"
echo ""

sort -t'|' -k1 -rn "$TMPFILE" | head -10 | nl | while read -r line; do
    num=$(echo "$line" | awk '{print $1}')
    usage=$(echo "$line" | cut -d'|' -f1 | awk '{print $2}')
    type=$(echo "$line" | cut -d'|' -f2)
    name=$(echo "$line" | cut -d'|' -f3)
    
    echo -e "${GREEN}$num.${NC} [$type] $name - ${YELLOW}$usage uses${NC}"
done

echo ""
echo -e "${YELLOW}Least Used Capabilities (candidates for archiving):${NC}"
echo ""

sort -t'|' -k1 -n "$TMPFILE" | head -10 | while read -r line; do
    usage=$(echo "$line" | cut -d'|' -f1)
    type=$(echo "$line" | cut -d'|' -f2)
    name=$(echo "$line" | cut -d'|' -f3)
    
    if [ "$usage" -eq 0 ]; then
        echo -e "  [$type] $name - ${YELLOW}never used${NC}"
    fi
done

echo ""
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BLUE}Summary${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"

total=$(wc -l < "$TMPFILE" | tr -d ' ')
used=$(awk -F'|' '$1 > 0' "$TMPFILE" | wc -l | tr -d ' ')
unused=$(awk -F'|' '$1 == 0' "$TMPFILE" | wc -l | tr -d ' ')
avg_usage=$(awk -F'|' '{sum+=$1} END {printf "%.1f", sum/NR}' "$TMPFILE")

echo ""
echo "Total capabilities: $total"
echo "Used at least once: $used"
echo "Never used: $unused"
echo "Average usage: $avg_usage times"
echo ""

if [ "$unused" -gt 0 ]; then
    echo -e "${YELLOW}Tip: Review unused capabilities - consider updating documentation or archiving${NC}"
else
    echo -e "${GREEN}All capabilities have been used! ✓${NC}"
fi

echo ""
