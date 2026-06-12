#!/bin/bash
# 集成测试：完整工作流测试
# 测试从创建任务到能力沉淀的完整流程

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../../.." && pwd)"
TEST_DIR="$REPO_ROOT/.test-tmp"

# 颜色
GREEN='\033[0;32m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m'

# 测试计数器
TESTS_RUN=0
TESTS_PASSED=0
TESTS_FAILED=0

echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BLUE}Integration Test: Complete Workflow${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"

# 清理测试环境
cleanup() {
    if [[ -d "$TEST_DIR" ]]; then
        rm -rf "$TEST_DIR"
    fi
}

trap cleanup EXIT

# 设置测试环境
setup() {
    echo -e "\n${BLUE}Setting up test environment...${NC}"
    mkdir -p "$TEST_DIR"
    cd "$REPO_ROOT"
}

# 测试 1: 能力导出
test_capability_export() {
    echo -e "\n${BLUE}Test 1: Capability Export${NC}"
    TESTS_RUN=$((TESTS_RUN + 1))
    
    local output="$TEST_DIR/exported.yaml"
    
    if bash ops/scripts/export-capability.sh -t skill -n problem-driven-development -o "$output" > /dev/null 2>&1; then
        if [[ -f "$output" ]] && [[ -s "$output" ]]; then
            TESTS_PASSED=$((TESTS_PASSED + 1))
            echo -e "${GREEN}✓${NC} Capability export works"
        else
            TESTS_FAILED=$((TESTS_FAILED + 1))
            echo -e "${RED}✗${NC} Export file is empty"
        fi
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo -e "${RED}✗${NC} Capability export failed"
    fi
}

# 测试 2: 能力搜索
test_capability_search() {
    echo -e "\n${BLUE}Test 2: Capability Search${NC}"
    TESTS_RUN=$((TESTS_RUN + 1))
    
    if bash ops/scripts/search-capability.sh "problem" > /dev/null 2>&1; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo -e "${GREEN}✓${NC} Capability search works"
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo -e "${RED}✗${NC} Capability search failed"
    fi
}

# 测试 3: 健康度计算
test_health_calculation() {
    echo -e "\n${BLUE}Test 3: Health Score Calculation${NC}"
    TESTS_RUN=$((TESTS_RUN + 1))
    
    if bash ops/scripts/calculate-health-score.sh > /dev/null 2>&1; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo -e "${GREEN}✓${NC} Health score calculation works"
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo -e "${RED}✗${NC} Health score calculation failed"
    fi
}

# 测试 4: 周报生成
test_weekly_report() {
    echo -e "\n${BLUE}Test 4: Weekly Report Generation${NC}"
    TESTS_RUN=$((TESTS_RUN + 1))
    
    local output="$TEST_DIR/weekly-report.md"
    
    if bash ops/scripts/generate-weekly-report.sh -o "$output" > /dev/null 2>&1; then
        if [[ -f "$output" ]] && [[ -s "$output" ]]; then
            TESTS_PASSED=$((TESTS_PASSED + 1))
            echo -e "${GREEN}✓${NC} Weekly report generation works"
        else
            TESTS_FAILED=$((TESTS_FAILED + 1))
            echo -e "${RED}✗${NC} Report file is empty"
        fi
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo -e "${RED}✗${NC} Weekly report generation failed"
    fi
}

# 测试 5: 能力质量检查
test_capability_check() {
    echo -e "\n${BLUE}Test 5: Capability Quality Check${NC}"
    TESTS_RUN=$((TESTS_RUN + 1))
    
    if bash ops/scripts/check-capabilities.sh > /dev/null 2>&1; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo -e "${GREEN}✓${NC} Capability quality check works"
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo -e "${RED}✗${NC} Capability quality check failed"
    fi
}

# 主测试流程
main() {
    setup
    
    test_capability_export
    test_capability_search
    test_health_calculation
    test_weekly_report
    test_capability_check
    
    # 总结
    echo ""
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${BLUE}Integration Test Summary${NC}"
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo "Total tests: $TESTS_RUN"
    echo -e "${GREEN}Passed: $TESTS_PASSED${NC}"
    
    if [[ $TESTS_FAILED -gt 0 ]]; then
        echo -e "${RED}Failed: $TESTS_FAILED${NC}"
        exit 1
    else
        echo -e "${GREEN}All integration tests passed! ✓${NC}"
        exit 0
    fi
}

main
