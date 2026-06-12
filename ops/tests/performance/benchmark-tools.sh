#!/bin/bash
# 性能基准测试：工具执行速度

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../../.." && pwd)"

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BLUE}Performance Benchmark: Tools${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"

cd "$REPO_ROOT"

time_command() {
    local description=$1
    shift
    
    local start=$(date +%s%N)
    "$@" > /dev/null 2>&1
    local end=$(date +%s%N)
    
    local duration=$((($end - $start) / 1000000))
    
    if [ $duration -lt 100 ]; then
        echo -e "${GREEN}✓${NC} $description: ${duration}ms ${GREEN}(excellent)${NC}" >&2
    elif [ $duration -lt 500 ]; then
        echo -e "${GREEN}✓${NC} $description: ${duration}ms ${YELLOW}(good)${NC}" >&2
    else
        echo -e "${YELLOW}⚠${NC} $description: ${duration}ms (needs optimization)" >&2
    fi
    
    echo "$duration"
}

echo ""
echo "Test 1: Capability Search"
t1=$(time_command "Search: problem" bash ops/scripts/search-capability.sh "problem")
t2=$(time_command "Search: skill/test" bash ops/scripts/search-capability.sh -t skill "test")

echo ""
echo "Test 2: Capability Export"
t3=$(time_command "Export: single" bash ops/scripts/export-capability.sh -t skill -n problem-driven-development -o /tmp/t1.yaml)
t4=$(time_command "Export: category" bash ops/scripts/export-capability.sh -c skill -o /tmp/t2.yaml)

echo ""
echo "Test 3: Health & Reports"
t5=$(time_command "Health score" bash ops/scripts/calculate-health-score.sh)
t6=$(time_command "Weekly report" bash ops/scripts/generate-weekly-report.sh -o /tmp/t3.md)

echo ""
echo "Test 4: Quality Check"
t7=$(time_command "Quality check" bash ops/scripts/check-capabilities.sh)

rm -f /tmp/t1.yaml /tmp/t2.yaml /tmp/t3.md

echo ""
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BLUE}Summary${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"

total=$((t1 + t2 + t3 + t4 + t5 + t6 + t7))
avg=$((total / 7))

echo "Total: ${total}ms"
echo "Average: ${avg}ms"

if [ $avg -lt 200 ]; then
    echo -e "${GREEN}Performance: EXCELLENT ✓${NC}"
    exit 0
else
    echo -e "${YELLOW}Performance: GOOD${NC}"
    exit 0
fi
