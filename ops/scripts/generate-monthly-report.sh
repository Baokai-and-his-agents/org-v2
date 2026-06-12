#!/bin/bash
# 月度报告生成器
# 自动生成月度进展报告

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"

# 默认参数
DAYS=30
OUTPUT_FILE="ops/reports/monthly-report-$(date +%Y-%m).md"

# 解析参数
while [[ $# -gt 0 ]]; do
    case $1 in
        -d|--days)
            DAYS="$2"
            shift 2
            ;;
        -o|--output)
            OUTPUT_FILE="$2"
            shift 2
            ;;
        -h|--help)
            echo "Usage: $0 [-d days] [-o output]"
            echo "  -d, --days    Number of days to report (default: 30)"
            echo "  -o, --output  Output file path"
            exit 0
            ;;
        *)
            echo "Unknown option: $1"
            exit 1
            ;;
    esac
done

cd "$REPO_ROOT"

# 确保输出目录存在
mkdir -p "$(dirname "$OUTPUT_FILE")"

# 生成报告
cat > "$OUTPUT_FILE" << REPORT
# 月度报告

**生成时间**：$(date +"%Y-%m-%d %H:%M")  
**报告周期**：最近 $DAYS 天

---

## 📊 整体概览

### Git 活动

REPORT

# Git 统计
if [[ "$OSTYPE" == "darwin"* ]]; then
    SINCE_DATE=$(date -v-${DAYS}d +"%Y-%m-%d")
else
    SINCE_DATE=$(date -d "-${DAYS} days" +"%Y-%m-%d")
fi

COMMITS=$(git log --since="$SINCE_DATE" --oneline | wc -l | tr -d ' ')
AUTHORS=$(git log --since="$SINCE_DATE" --format='%an' | sort -u | wc -l | tr -d ' ')
FILES_CHANGED=$(git log --since="$SINCE_DATE" --numstat --pretty="%H" | awk 'NF==3 {plus+=$1; minus+=$2} END {print plus+minus}')

cat >> "$OUTPUT_FILE" << REPORT
- **提交次数**：$COMMITS
- **活跃贡献者**：$AUTHORS
- **文件变更**：$FILES_CHANGED 行

### 任务完成

REPORT

# 任务统计
TASKS_DIR="$REPO_ROOT/ops/tasks"
if [ -d "$TASKS_DIR" ]; then
    TOTAL_TASKS=$(find "$TASKS_DIR" -name "*.md" -type f | wc -l | tr -d ' ')
    COMPLETED_TASKS=$(grep -l "状态.*已完成\|Status.*completed" "$TASKS_DIR"/*.md 2>/dev/null | wc -l | tr -d ' ')
    
    cat >> "$OUTPUT_FILE" << REPORT
- **总任务数**：$TOTAL_TASKS
- **已完成**：$COMPLETED_TASKS
- **完成率**：$(awk "BEGIN {printf \"%.1f\", ($COMPLETED_TASKS/$TOTAL_TASKS)*100}")%

REPORT
fi

cat >> "$OUTPUT_FILE" << REPORT

### 能力资产

REPORT

# 能力统计
SKILL_COUNT=$(find capabilities/skill -name "*.md" -type f 2>/dev/null | wc -l | tr -d ' ')
DATA_COUNT=$(find capabilities/data -name "*.md" -type f 2>/dev/null | wc -l | tr -d ' ')
KNOWLEDGE_COUNT=$(find capabilities/knowledge -name "*.md" -type f 2>/dev/null | wc -l | tr -d ' ')
SYSTEM_COUNT=$(find capabilities/system -name "*.md" -type f 2>/dev/null | wc -l | tr -d ' ')
TOTAL_CAP=$((SKILL_COUNT + DATA_COUNT + KNOWLEDGE_COUNT + SYSTEM_COUNT))

cat >> "$OUTPUT_FILE" << REPORT
- **Skills**：$SKILL_COUNT
- **Data**：$DATA_COUNT
- **Knowledge**：$KNOWLEDGE_COUNT
- **System**：$SYSTEM_COUNT
- **总计**：$TOTAL_CAP

---

## 📈 关键指标

### 系统健康度

（请运行 \`bash ops/scripts/calculate-health-score.sh\` 获取最新评分）

### 测试覆盖

REPORT

# 测试统计
UNIT_TESTS=$(grep -c "^test_" ops/tests/test-capability-quality.sh 2>/dev/null || echo "0")
INTEGRATION_TESTS=$(grep -c "^test_" ops/tests/integration/*.sh 2>/dev/null || echo "0")
PERF_TESTS=$(grep -c "^time_command" ops/tests/performance/*.sh 2>/dev/null || echo "0")
TOTAL_TESTS=$((UNIT_TESTS + INTEGRATION_TESTS + PERF_TESTS))

cat >> "$OUTPUT_FILE" << REPORT
- **单元测试**：$UNIT_TESTS
- **集成测试**：$INTEGRATION_TESTS
- **性能测试**：$PERF_TESTS
- **总计**：$TOTAL_TESTS

---

## 🎯 主要成就

### 本月完成的任务

REPORT

# 最近完成的任务
git log --since="$SINCE_DATE" --oneline | grep -i "complete task\|完成任务" | head -10 | while read -r line; do
    echo "- $line" >> "$OUTPUT_FILE"
done

cat >> "$OUTPUT_FILE" << REPORT

### 新增能力

REPORT

# 最近新增的能力
git log --since="$SINCE_DATE" --name-only --diff-filter=A | grep "^capabilities/.*\.md$" | while read -r file; do
    if [ -f "$file" ]; then
        CAP_NAME=$(basename "$file" .md)
        CAP_TYPE=$(dirname "$file" | xargs basename)
        echo "- [$CAP_TYPE] $CAP_NAME" >> "$OUTPUT_FILE"
    fi
done

cat >> "$OUTPUT_FILE" << REPORT

---

## 💡 改进建议

基于本月数据，建议：

1. **保持沉淀率**：继续每个任务后评估能力沉淀
2. **测试覆盖**：保持 100% 通过率
3. **文档更新**：随功能同步更新
4. **健康度监控**：定期运行健康检查

---

## 📅 下月计划

（根据当前进展填写）

---

_报告生成：$(date +"%Y-%m-%d %H:%M")_  
_生成工具：ops/scripts/generate-monthly-report.sh_
REPORT

echo "✅ 月度报告已生成：$OUTPUT_FILE"
