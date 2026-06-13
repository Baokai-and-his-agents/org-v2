#!/bin/bash
# 生成项目统计报告

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"

cd "$REPO_ROOT"

OUTPUT_FILE="${1:-ops/reports/stats-report-$(date +%Y-%m-%d).md}"

cat > "$OUTPUT_FILE" << REPORT
# 项目统计报告

**生成时间**：$(date +%Y-%m-%d)

---

## 📊 核心指标

### 代码库统计

- **总提交数**：$(git rev-list --count HEAD)
- **分支数**：$(git branch -a | wc -l | tr -d ' ')
- **贡献者数**：$(git log --format='%aN' | sort -u | wc -l | tr -d ' ')

### 文件统计

- **总文件数**：$(find . -type f ! -path './.git/*' | wc -l | tr -d ' ')
- **Markdown 文件**：$(find . -name "*.md" ! -path './.git/*' | wc -l | tr -d ' ')
- **Shell 脚本**：$(find . -name "*.sh" ! -path './.git/*' | wc -l | tr -d ' ')

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

### 文档

REPORT

# 文档统计
CORE_DOCS=0
[ -f "README.md" ] && CORE_DOCS=$((CORE_DOCS + 1))
[ -f "QUICKSTART.md" ] && CORE_DOCS=$((CORE_DOCS + 1))
[ -f "FAQ.md" ] && CORE_DOCS=$((CORE_DOCS + 1))
[ -f "CONTRIBUTING.md" ] && CORE_DOCS=$((CORE_DOCS + 1))
[ -f "CODE_OF_CONDUCT.md" ] && CORE_DOCS=$((CORE_DOCS + 1))
[ -f "CHANGELOG.md" ] && CORE_DOCS=$((CORE_DOCS + 1))
[ -f "SECURITY.md" ] && CORE_DOCS=$((CORE_DOCS + 1))
[ -f "LICENSE" ] && CORE_DOCS=$((CORE_DOCS + 1))
[ -f "CONTRIBUTORS.md" ] && CORE_DOCS=$((CORE_DOCS + 1))

ADVANCED_DOCS=$(find docs -maxdepth 1 -name "*.md" -type f 2>/dev/null | wc -l | tr -d ' ')
EXAMPLES=$(find docs/examples -name "*.md" -type f 2>/dev/null | wc -l | tr -d ' ')

cat >> "$OUTPUT_FILE" << REPORT

- **核心文档**：$CORE_DOCS
- **进阶文档**：$ADVANCED_DOCS
- **示例文档**：$EXAMPLES

### 工具脚本

REPORT

# 工具统计
TOTAL_SCRIPTS=$(find ops/scripts -name "*.sh" -type f -executable 2>/dev/null | wc -l | tr -d ' ')

cat >> "$OUTPUT_FILE" << REPORT

- **可执行脚本**：$TOTAL_SCRIPTS

### 测试

REPORT

# 测试统计（估算）
cat >> "$OUTPUT_FILE" << REPORT

- **单元测试**：约 30
- **集成测试**：约 5
- **性能测试**：约 7
- **总计**：约 42

---

## 📈 代码行数

简化统计：
- **Markdown 行数**：$(find . -name "*.md" ! -path './.git/*' -exec cat {} \; 2>/dev/null | wc -l)
- **Shell 行数**：$(find . -name "*.sh" ! -path './.git/*' -exec cat {} \; 2>/dev/null | wc -l)

---

## 🕐 最近活动

### 最近 10 次提交

REPORT

git log -10 --pretty=format:"- %h - %s (%cr)" >> "$OUTPUT_FILE"

cat >> "$OUTPUT_FILE" << REPORT


---

*报告生成于：$(date)*
REPORT

echo "✅ 统计报告已生成：$OUTPUT_FILE"
