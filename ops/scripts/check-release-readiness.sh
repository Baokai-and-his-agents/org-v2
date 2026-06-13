#!/bin/bash
# 检查发布准备就绪度

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"

cd "$REPO_ROOT"

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🚀 Release Readiness Check"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

TOTAL_CHECKS=0
PASSED_CHECKS=0

check_item() {
    local description=$1
    local command=$2
    
    TOTAL_CHECKS=$((TOTAL_CHECKS + 1))
    
    if eval "$command" > /dev/null 2>&1; then
        echo "✅ $description"
        PASSED_CHECKS=$((PASSED_CHECKS + 1))
        return 0
    else
        echo "❌ $description"
        return 1
    fi
}

echo "1. 核心文档"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
check_item "README.md" "[ -f README.md ]"
check_item "QUICKSTART.md" "[ -f QUICKSTART.md ]"
check_item "FAQ.md" "[ -f FAQ.md ]"
check_item "CONTRIBUTING.md" "[ -f CONTRIBUTING.md ]"
check_item "CODE_OF_CONDUCT.md" "[ -f CODE_OF_CONDUCT.md ]"
check_item "LICENSE" "[ -f LICENSE ]"
check_item "CHANGELOG.md" "[ -f CHANGELOG.md ]"
check_item "SECURITY.md" "[ -f SECURITY.md ]"

echo ""
echo "2. GitHub 配置"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
check_item "Issue 模板" "[ -d .github/ISSUE_TEMPLATE ]"
check_item "PR 模板" "[ -f .github/PULL_REQUEST_TEMPLATE.md ]"
check_item "CI 配置" "[ -f .github/workflows/quality-check.yml ]"
check_item ".gitignore" "[ -f .gitignore ]"
check_item ".editorconfig" "[ -f .editorconfig ]"

echo ""
echo "3. 测试"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
check_item "单元测试脚本存在" "[ -f ops/tests/test-capability-quality.sh ]"
check_item "集成测试脚本存在" "[ -f ops/tests/integration/test-workflow-integration.sh ]"
check_item "性能测试脚本存在" "[ -f ops/tests/performance/benchmark-tools.sh ]"

# 运行测试（静默）
if bash ops/tests/test-capability-quality.sh > /dev/null 2>&1; then
    echo "✅ 单元测试通过"
    PASSED_CHECKS=$((PASSED_CHECKS + 1))
else
    echo "❌ 单元测试失败"
fi
TOTAL_CHECKS=$((TOTAL_CHECKS + 1))

echo ""
echo "4. 工具脚本"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
SCRIPT_COUNT=$(find ops/scripts -name "*.sh" -type f -executable 2>/dev/null | wc -l | tr -d ' ')
if [ "$SCRIPT_COUNT" -ge 10 ]; then
    echo "✅ 工具脚本充足（$SCRIPT_COUNT 个）"
    PASSED_CHECKS=$((PASSED_CHECKS + 1))
else
    echo "❌ 工具脚本不足（$SCRIPT_COUNT < 10）"
fi
TOTAL_CHECKS=$((TOTAL_CHECKS + 1))

echo ""
echo "5. 能力资产"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
CAP_COUNT=$(find capabilities -name "*.md" -type f ! -name "TEMPLATE.md" 2>/dev/null | wc -l | tr -d ' ')
if [ "$CAP_COUNT" -ge 35 ]; then
    echo "✅ 能力资产充足（$CAP_COUNT ≥ 35）"
    PASSED_CHECKS=$((PASSED_CHECKS + 1))
else
    echo "❌ 能力资产不足（$CAP_COUNT < 35）"
fi
TOTAL_CHECKS=$((TOTAL_CHECKS + 1))

check_item "能力索引存在" "[ -f capabilities/INDEX.md ]"

echo ""
echo "6. Git 状态"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
UNCOMMITTED=$(git status --porcelain 2>/dev/null | wc -l | tr -d ' ')
if [ "$UNCOMMITTED" -eq 0 ]; then
    echo "✅ 无未提交文件"
    PASSED_CHECKS=$((PASSED_CHECKS + 1))
else
    echo "⚠️  有 $UNCOMMITTED 个未提交文件"
fi
TOTAL_CHECKS=$((TOTAL_CHECKS + 1))

COMMITS=$(git rev-list --count HEAD 2>/dev/null)
if [ "$COMMITS" -ge 100 ]; then
    echo "✅ 提交历史充足（$COMMITS ≥ 100）"
    PASSED_CHECKS=$((PASSED_CHECKS + 1))
else
    echo "⚠️  提交较少（$COMMITS < 100）"
fi
TOTAL_CHECKS=$((TOTAL_CHECKS + 1))

echo ""
echo "7. 健康度"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
if bash ops/scripts/calculate-health-score.sh > /tmp/health-score.txt 2>&1; then
    HEALTH=$(grep "总体健康度" /tmp/health-score.txt | grep -oE "[0-9]+\.[0-9]+" | head -1)
    if [ -n "$HEALTH" ]; then
        if awk "BEGIN {exit !($HEALTH >= 9.0)}"; then
            echo "✅ 健康度优秀（$HEALTH ≥ 9.0）"
            PASSED_CHECKS=$((PASSED_CHECKS + 1))
        else
            echo "⚠️  健康度一般（$HEALTH < 9.0）"
        fi
    else
        echo "⚠️  无法获取健康度"
    fi
    rm -f /tmp/health-score.txt
else
    echo "❌ 健康度检查失败"
fi
TOTAL_CHECKS=$((TOTAL_CHECKS + 1))

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "📊 Summary"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "通过：$PASSED_CHECKS / $TOTAL_CHECKS"

PERCENTAGE=$((PASSED_CHECKS * 100 / TOTAL_CHECKS))
echo "准备度：$PERCENTAGE%"

echo ""
if [ "$PERCENTAGE" -ge 90 ]; then
    echo "🎉 系统已准备好发布！"
    exit 0
elif [ "$PERCENTAGE" -ge 70 ]; then
    echo "⚠️  系统接近就绪，需要少量改进"
    exit 1
else
    echo "❌ 系统未准备好，需要更多工作"
    exit 1
fi
