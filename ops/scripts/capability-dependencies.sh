#!/bin/bash
# 能力依赖关系可视化
# 分析能力之间的关联（通过 [[name]] 链接）

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BLUE}Capability Dependency Analysis${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"

cd "$REPO_ROOT"

TMPFILE=$(mktemp)
TMPLINKS=$(mktemp)
trap "rm -f $TMPFILE $TMPLINKS" EXIT

echo ""
echo "Analyzing capability relationships..."
echo ""

# 扫描所有能力文件，查找 [[name]] 链接
for cap_file in capabilities/*/*.md; do
    if [ -f "$cap_file" ] && [ "$(basename "$cap_file")" != "TEMPLATE.md" ]; then
        cap_name=$(basename "$cap_file" .md)
        cap_type=$(dirname "$cap_file" | xargs basename)
        
        # 查找所有 [[target]] 链接
        grep -oE '\[\[[a-zA-Z0-9_-]+\]\]' "$cap_file" 2>/dev/null | \
        sed 's/\[\[\(.*\)\]\]/\1/' | \
        while read -r target; do
            echo "$cap_name -> $target" >> "$TMPLINKS"
        done
        
        # 记录能力信息
        echo "$cap_type|$cap_name" >> "$TMPFILE"
    fi
done

# 统计
total_caps=$(wc -l < "$TMPFILE" | tr -d ' ')
total_links=0
if [ -f "$TMPLINKS" ] && [ -s "$TMPLINKS" ]; then
    total_links=$(wc -l < "$TMPLINKS" | tr -d ' ')
fi

echo -e "${YELLOW}Capabilities with dependencies:${NC}"
echo ""

if [ "$total_links" -gt 0 ]; then
    # 显示有依赖的能力
    awk '{print $1}' "$TMPLINKS" | sort -u | while read -r cap; do
        count=$(grep -c "^$cap ->" "$TMPLINKS")
        targets=$(grep "^$cap ->" "$TMPLINKS" | awk '{print $3}' | tr '\n' ', ' | sed 's/,$//')
        echo -e "  ${GREEN}$cap${NC} → $count dependencies: $targets"
    done
else
    echo "  (No dependencies found - capabilities are independent)"
fi

echo ""
echo -e "${YELLOW}Most referenced capabilities:${NC}"
echo ""

if [ "$total_links" -gt 0 ]; then
    awk '{print $3}' "$TMPLINKS" | sort | uniq -c | sort -rn | head -5 | while read -r count name; do
        echo -e "  ${GREEN}$name${NC} - referenced $count times"
    done
else
    echo "  (No references found)"
fi

echo ""
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BLUE}Summary${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo "Total capabilities: $total_caps"
echo "Total dependencies: $total_links"

if [ "$total_links" -gt 0 ]; then
    avg=$(awk "BEGIN {printf \"%.1f\", $total_links/$total_caps}")
    echo "Average links per capability: $avg"
    
    caps_with_deps=$(awk '{print $1}' "$TMPLINKS" 2>/dev/null | sort -u | wc -l | tr -d ' ')
    echo "Capabilities with dependencies: $caps_with_deps"
    echo ""
    echo -e "${GREEN}Capabilities are interconnected ✓${NC}"
else
    echo "Average links per capability: 0.0"
    echo ""
    echo -e "${YELLOW}Tip: Add [[capability-name]] links in 'Related Capabilities' sections${NC}"
    echo -e "${YELLOW}to build knowledge graph connections${NC}"
fi

echo ""
