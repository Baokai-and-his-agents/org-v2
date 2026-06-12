#!/bin/bash
# 每周五自动生成运行报告

set -e

REPORT_DATE=$(date +%Y-%m-%d)
WEEK_AGO=$(date -v-7d +%Y-%m-%d)
REPORT_FILE="ops/reports/weekly-${REPORT_DATE}.md"

echo "# 本周运行报告" > "$REPORT_FILE"
echo "" >> "$REPORT_FILE"
echo "**日期**：$REPORT_DATE" >> "$REPORT_FILE"
echo "**周期**：$WEEK_AGO ~ $REPORT_DATE" >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE"

# 任务完成数（通过 git log 分析）
echo "## 📊 核心指标" >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE"

TASKS_DONE=$(git log --since="$WEEK_AGO" --grep="Complete\|完成\|Finish" --oneline | wc -l | xargs)
echo "- 完成任务：$TASKS_DONE" >> "$REPORT_FILE"

# 新增能力
NEW_SKILLS=$(git log --since="$WEEK_AGO" --name-only --pretty=format: -- capabilities/skill/ | grep -v "^$" | wc -l | xargs)
NEW_DATA=$(git log --since="$WEEK_AGO" --name-only --pretty=format: -- capabilities/data/ | grep -v "^$" | wc -l | xargs)
NEW_KNOWLEDGE=$(git log --since="$WEEK_AGO" --name-only --pretty=format: -- capabilities/knowledge/ | grep -v "^$" | wc -l | xargs)

echo "- 新增能力：skill($NEW_SKILLS) + data($NEW_DATA) + knowledge($NEW_KNOWLEDGE)" >> "$REPORT_FILE"

# Heartbeats
HEARTBEATS=$(find ops/heartbeats/ -name "*.md" -newermt "$WEEK_AGO" 2>/dev/null | wc -l | xargs)
echo "- Duty 巡检：$HEARTBEATS 次" >> "$REPORT_FILE"

# 提交数
COMMITS=$(git log --since="$WEEK_AGO" --oneline | wc -l | xargs)
echo "- Git 提交：$COMMITS 次" >> "$REPORT_FILE"

echo "" >> "$REPORT_FILE"

# 能力资产统计
echo "## 📚 能力资产统计" >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE"

TOTAL_SKILLS=$(find capabilities/skill/ -name "*.md" 2>/dev/null | wc -l | xargs)
TOTAL_DATA=$(find capabilities/data/ -name "*.md" 2>/dev/null | wc -l | xargs)
TOTAL_KNOWLEDGE=$(find capabilities/knowledge/ -name "*.md" 2>/dev/null | wc -l | xargs)

echo "- Skills: $TOTAL_SKILLS" >> "$REPORT_FILE"
echo "- Data: $TOTAL_DATA" >> "$REPORT_FILE"
echo "- Knowledge: $TOTAL_KNOWLEDGE" >> "$REPORT_FILE"
echo "- **总计**: $((TOTAL_SKILLS + TOTAL_DATA + TOTAL_KNOWLEDGE))" >> "$REPORT_FILE"

echo "" >> "$REPORT_FILE"

# 本周亮点
echo "## ✨ 本周亮点" >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE"
echo "_（手动填写）_" >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE"

# 下周计划
echo "## 📅 下周计划" >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE"
echo "_（手动填写）_" >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE"

# 系统改进建议
echo "## 🔧 系统改进建议" >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE"
echo "_（自动分析）_" >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE"

# 沉淀率分析
if [ "$TASKS_DONE" -gt 0 ]; then
    NEW_CAPABILITIES=$((NEW_SKILLS + NEW_DATA + NEW_KNOWLEDGE))
    DEPOSIT_RATE=$((NEW_CAPABILITIES * 100 / TASKS_DONE))
    echo "- 能力沉淀率：${DEPOSIT_RATE}% ($NEW_CAPABILITIES/$TASKS_DONE)" >> "$REPORT_FILE"

    if [ "$DEPOSIT_RATE" -lt 30 ]; then
        echo "  - ⚠️ 低于目标（30%），建议加强能力沉淀" >> "$REPORT_FILE"
    fi
fi

# Heartbeat 频率
if [ "$HEARTBEATS" -lt 5 ]; then
    echo "- Duty 巡检频率低（目标：每日 1 次），建议提高" >> "$REPORT_FILE"
fi

echo "" >> "$REPORT_FILE"
echo "---" >> "$REPORT_FILE"
echo "_报告生成时间：$(date)_" >> "$REPORT_FILE"

echo "✅ 周报已生成：$REPORT_FILE"
cat "$REPORT_FILE"
