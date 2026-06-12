#!/bin/bash
# 能力资产质量检查脚本
# 检查 capabilities/ 目录的健康度和一致性

set -e

REPORT_FILE="ops/reports/capability-quality-$(date +%Y-%m-%d).md"

echo "🔍 开始能力资产质量检查..."
echo ""

# 初始化报告
cat > "$REPORT_FILE" << EOF
# 能力资产质量报告

**检查时间**：$(date +"%Y-%m-%d %H:%M")

---

## 📊 统计数据

EOF

# 统计实际文件数
ACTUAL_SKILLS=$(find capabilities/skill/ -name "*.md" -not -name "README.md" 2>/dev/null | wc -l | xargs)
ACTUAL_DATA=$(find capabilities/data/ -name "*.md" -not -name "README.md" 2>/dev/null | wc -l | xargs)
ACTUAL_KNOWLEDGE=$(find capabilities/knowledge/ -name "*.md" -not -name "README.md" 2>/dev/null | wc -l | xargs)

# 从 INDEX.md 提取声明的数量
DECLARED_SKILLS=$(grep "^- Skills:" capabilities/INDEX.md | grep -oE "[0-9]+" || echo "0")
DECLARED_DATA=$(grep "^- Data:" capabilities/INDEX.md | grep -oE "[0-9]+" || echo "0")
DECLARED_KNOWLEDGE=$(grep "^- Knowledge:" capabilities/INDEX.md | grep -oE "[0-9]+" || echo "0")

echo "### 数量对比" >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE"
echo "| 类型 | 实际 | 声明 | 状态 |" >> "$REPORT_FILE"
echo "|------|------|------|------|" >> "$REPORT_FILE"

# 检查 Skills
if [ "$ACTUAL_SKILLS" -eq "$DECLARED_SKILLS" ]; then
    echo "| Skills | $ACTUAL_SKILLS | $DECLARED_SKILLS | ✅ |" >> "$REPORT_FILE"
else
    echo "| Skills | $ACTUAL_SKILLS | $DECLARED_SKILLS | ⚠️ 不一致 |" >> "$REPORT_FILE"
fi

# 检查 Data
if [ "$ACTUAL_DATA" -eq "$DECLARED_DATA" ]; then
    echo "| Data | $ACTUAL_DATA | $DECLARED_DATA | ✅ |" >> "$REPORT_FILE"
else
    echo "| Data | $ACTUAL_DATA | $DECLARED_DATA | ⚠️ 不一致 |" >> "$REPORT_FILE"
fi

# 检查 Knowledge
if [ "$ACTUAL_KNOWLEDGE" -eq "$DECLARED_KNOWLEDGE" ]; then
    echo "| Knowledge | $ACTUAL_KNOWLEDGE | $DECLARED_KNOWLEDGE | ✅ |" >> "$REPORT_FILE"
else
    echo "| Knowledge | $ACTUAL_KNOWLEDGE | $DECLARED_KNOWLEDGE | ⚠️ 不一致 |" >> "$REPORT_FILE"
fi

echo "" >> "$REPORT_FILE"
echo "**总计**：$((ACTUAL_SKILLS + ACTUAL_DATA + ACTUAL_KNOWLEDGE)) 个能力资产" >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE"

# 检查文件格式
echo "---" >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE"
echo "## 🔍 格式检查" >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE"

FORMAT_ISSUES=0

for file in capabilities/{skill,data,knowledge}/*.md; do
    if [ -f "$file" ] && [[ ! "$file" =~ README\.md$ ]]; then
        # 检查必需字段
        if ! grep -q "^## 🎯 用途" "$file"; then
            echo "- ⚠️ \`$file\`: 缺少"用途"部分" >> "$REPORT_FILE"
            FORMAT_ISSUES=$((FORMAT_ISSUES + 1))
        fi

        if ! grep -q "^## 📝 示例" "$file" && ! grep -q "^## 📊 使用记录" "$file"; then
            echo "- ⚠️ \`$file\`: 缺少示例或使用记录" >> "$REPORT_FILE"
            FORMAT_ISSUES=$((FORMAT_ISSUES + 1))
        fi
    fi
done

if [ "$FORMAT_ISSUES" -eq 0 ]; then
    echo "✅ 所有能力文档格式完整" >> "$REPORT_FILE"
fi

echo "" >> "$REPORT_FILE"

# 检查过期能力（简化版：检查文件修改时间）
echo "---" >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE"
echo "## ⏰ 过期检测" >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE"

# 查找 90 天未更新的文件
OLD_FILES=$(find capabilities/{skill,data,knowledge}/ -name "*.md" -not -name "README.md" -mtime +90 2>/dev/null)

if [ -z "$OLD_FILES" ]; then
    echo "✅ 无过期能力（90 天内全部有更新）" >> "$REPORT_FILE"
else
    echo "以下能力超过 90 天未更新，建议审查：" >> "$REPORT_FILE"
    echo "" >> "$REPORT_FILE"
    for file in $OLD_FILES; do
        DAYS=$(( ($(date +%s) - $(stat -f %m "$file" 2>/dev/null || stat -c %Y "$file")) / 86400 ))
        echo "- \`$file\` - $DAYS 天未更新" >> "$REPORT_FILE"
    done
fi

echo "" >> "$REPORT_FILE"

# 总结
echo "---" >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE"
echo "## 📋 总结" >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE"

SYNC_ISSUES=0
if [ "$ACTUAL_SKILLS" -ne "$DECLARED_SKILLS" ]; then SYNC_ISSUES=$((SYNC_ISSUES + 1)); fi
if [ "$ACTUAL_DATA" -ne "$DECLARED_DATA" ]; then SYNC_ISSUES=$((SYNC_ISSUES + 1)); fi
if [ "$ACTUAL_KNOWLEDGE" -ne "$DECLARED_KNOWLEDGE" ]; then SYNC_ISSUES=$((SYNC_ISSUES + 1)); fi

TOTAL_ISSUES=$((SYNC_ISSUES + FORMAT_ISSUES))

if [ "$TOTAL_ISSUES" -eq 0 ]; then
    echo "✅ **健康状态**：优秀" >> "$REPORT_FILE"
    echo "" >> "$REPORT_FILE"
    echo "所有能力资产质量良好，无需改进。" >> "$REPORT_FILE"
else
    echo "⚠️ **健康状态**：需要改进" >> "$REPORT_FILE"
    echo "" >> "$REPORT_FILE"
    echo "发现 $TOTAL_ISSUES 个问题：" >> "$REPORT_FILE"
    echo "- 同步问题：$SYNC_ISSUES 个" >> "$REPORT_FILE"
    echo "- 格式问题：$FORMAT_ISSUES 个" >> "$REPORT_FILE"
    echo "" >> "$REPORT_FILE"
    echo "**建议**：运行 \`bash ops/scripts/sync-capability-index.sh\` 自动修复同步问题" >> "$REPORT_FILE"
fi

echo "" >> "$REPORT_FILE"
echo "---" >> "$REPORT_FILE"
echo "_报告生成时间：$(date)_" >> "$REPORT_FILE"

echo "✅ 质量检查完成：$REPORT_FILE"
echo ""
cat "$REPORT_FILE"
