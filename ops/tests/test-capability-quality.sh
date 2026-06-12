#!/bin/bash
# 能力质量单元测试框架
# 自动化测试能力文件的质量标准

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
CAPABILITIES_DIR="$REPO_ROOT/capabilities"

# 颜色
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

# 测试计数器
TESTS_RUN=0
TESTS_PASSED=0
TESTS_FAILED=0

# 测试结果数组
declare -a FAILED_TESTS

# 测试辅助函数
assert_file_exists() {
    local file=$1
    local test_name=$2
    
    TESTS_RUN=$((TESTS_RUN + 1))
    
    if [[ -f "$file" ]]; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo -e "${GREEN}✓${NC} $test_name"
        return 0
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        FAILED_TESTS+=("$test_name: File not found: $file")
        echo -e "${RED}✗${NC} $test_name"
        return 1
    fi
}

assert_contains() {
    local file=$1
    local pattern=$2
    local test_name=$3
    
    TESTS_RUN=$((TESTS_RUN + 1))
    
    if grep -q "$pattern" "$file" 2>/dev/null; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo -e "${GREEN}✓${NC} $test_name"
        return 0
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        FAILED_TESTS+=("$test_name: Pattern not found in $(basename $file)")
        echo -e "${RED}✗${NC} $test_name"
        return 1
    fi
}

assert_not_empty() {
    local file=$1
    local test_name=$2
    
    TESTS_RUN=$((TESTS_RUN + 1))
    
    if [[ -s "$file" ]]; then
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo -e "${GREEN}✓${NC} $test_name"
        return 0
    else
        TESTS_FAILED=$((TESTS_FAILED + 1))
        FAILED_TESTS+=("$test_name: File is empty: $file")
        echo -e "${RED}✗${NC} $test_name"
        return 1
    fi
}

# 测试套件 1: 能力文件结构
test_capability_structure() {
    echo ""
    echo "Testing: Capability file structure"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    
    local capability_file="$CAPABILITIES_DIR/skill/problem-driven-development.md"
    
    assert_file_exists "$capability_file" "Capability file exists"
    assert_not_empty "$capability_file" "Capability file is not empty"
    assert_contains "$capability_file" "^# " "Has title"
    assert_contains "$capability_file" "^\*\*类型\*\*" "Has type field"
    assert_contains "$capability_file" "^\*\*创建\*\*" "Has created date"
    assert_contains "$capability_file" "## 🎯 用途" "Has purpose section"
}

# 测试套件 2: 工具脚本
test_tool_scripts() {
    echo ""
    echo "Testing: Tool scripts"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    
    local scripts=(
        "ops/scripts/export-capability.sh"
        "ops/scripts/import-capability.sh"
        "ops/scripts/search-capability.sh"
        "ops/scripts/generate-weekly-report.sh"
        "ops/scripts/calculate-health-score.sh"
    )
    
    for script in "${scripts[@]}"; do
        local full_path="$REPO_ROOT/$script"
        assert_file_exists "$full_path" "$(basename $script) exists"
        
        TESTS_RUN=$((TESTS_RUN + 1))
        if [[ -x "$full_path" ]]; then
            TESTS_PASSED=$((TESTS_PASSED + 1))
            echo -e "${GREEN}✓${NC} $(basename $script) is executable"
        else
            TESTS_FAILED=$((TESTS_FAILED + 1))
            FAILED_TESTS+=("$(basename $script) is not executable")
            echo -e "${RED}✗${NC} $(basename $script) is executable"
        fi
    done
}

# 测试套件 3: 文档完整性
test_documentation() {
    echo ""
    echo "Testing: Documentation completeness"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    
    local docs=(
        "README.md"
        "QUICKSTART.md"
        "FAQ.md"
        "CONTRIBUTING.md"
        "docs/BEST_PRACTICES.md"
        "docs/TROUBLESHOOTING.md"
        "docs/ADVANCED.md"
    )
    
    for doc in "${docs[@]}"; do
        assert_file_exists "$REPO_ROOT/$doc" "$(basename $doc) exists"
        assert_not_empty "$REPO_ROOT/$doc" "$(basename $doc) not empty"
    done
}

# 主测试运行器
main() {
    cd "$REPO_ROOT"
    
    echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${GREEN}Running Capability Quality Tests${NC}"
    echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    
    # 运行所有测试套件
    test_capability_structure
    test_tool_scripts
    test_documentation
    
    # 总结
    echo ""
    echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${GREEN}Test Summary${NC}"
    echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo "Total tests run: $TESTS_RUN"
    echo -e "${GREEN}Passed: $TESTS_PASSED${NC}"
    
    if [[ $TESTS_FAILED -gt 0 ]]; then
        echo -e "${RED}Failed: $TESTS_FAILED${NC}"
        echo ""
        echo "Failed tests:"
        for failure in "${FAILED_TESTS[@]}"; do
            echo -e "${RED}  - $failure${NC}"
        done
        exit 1
    else
        echo -e "${GREEN}All tests passed! ✓${NC}"
        exit 0
    fi
}

main
