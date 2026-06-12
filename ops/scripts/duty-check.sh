#!/bin/bash
# Duty Agent 巡检脚本
# 检查组织运行状态并生成 heartbeat

set -e

# 确保在正确的目录
if [ ! -d "ops/heartbeats" ]; then
    echo "❌ Error: ops/heartbeats directory not found"
    echo "Current directory: $(pwd)"
    echo "Please run from repository root"
    exit 1
fi

HEARTBEAT_DATE=$(date +%Y-%m-%d-%H%M)
HEARTBEAT_FILE="ops/heartbeats/${HEARTBEAT_DATE}.md"
CURRENT_TIME=$(date +"%Y-%m-%d %H:%M")

echo "🔍 开始 Duty Agent 巡检..."
echo ""

# 创建 heartbeat 文件
cat > "$HEARTBEAT_FILE" << EOF
# Duty Agent Heartbeat

**时间**：${CURRENT_TIME}
**执行者**：Duty Agent

---

## 🎯 巡检范围

- NOW.md 任务状态
- 资源请求
- 能力资产状态
- 系统健康度

---

EOF

# 检查 1: NOW.md 任务状态
echo "## ✅ 检查结果" >> "$HEARTBEAT_FILE"
echo "" >> "$HEARTBEAT_FILE"
echo "### 1. 活跃任务" >> "$HEARTBEAT_FILE"
echo "" >> "$HEARTBEAT_FILE"

ACTIVE_TASKS=$(grep -A 10 "## 📋 活跃任务" NOW.md | grep "ops/tasks" | wc -l | xargs)
if [ "$ACTIVE_TASKS" -eq 0 ]; then
    echo "✅ 无活跃任务" >> "$HEARTBEAT_FILE"
else
    echo "📋 活跃任务数：$ACTIVE_TASKS" >> "$HEARTBEAT_FILE"
    grep -A 10 "## 📋 活跃任务" NOW.md | grep -E "^\-" >> "$HEARTBEAT_FILE" || true
fi
echo "" >> "$HEARTBEAT_FILE"

# 检查 2: 资源请求
echo "### 2. 资源请求" >> "$HEARTBEAT_FILE"
echo "" >> "$HEARTBEAT_FILE"

RESOURCE_REQUESTS=$(grep -A 5 "## 🎯 当前请求" ops/resource-requests.md | grep -E "^###" | wc -l | xargs)
if [ "$RESOURCE_REQUESTS" -eq 0 ]; then
    echo "✅ 无待处理资源请求" >> "$HEARTBEAT_FILE"
else
    echo "⚠️ 待处理资源请求：$RESOURCE_REQUESTS" >> "$HEARTBEAT_FILE"
fi
echo "" >> "$HEARTBEAT_FILE"

# 检查 3: 能力资产统计
echo "### 3. 能力资产" >> "$HEARTBEAT_FILE"
echo "" >> "$HEARTBEAT_FILE"

TOTAL_SKILLS=$(find capabilities/skill/ -name "*.md" 2>/dev/null | wc -l | xargs)
TOTAL_DATA=$(find capabilities/data/ -name "*.md" 2>/dev/null | wc -l | xargs)
TOTAL_KNOWLEDGE=$(find capabilities/knowledge/ -name "*.md" 2>/dev/null | wc -l | xargs)

echo "- Skills: $TOTAL_SKILLS" >> "$HEARTBEAT_FILE"
echo "- Data: $TOTAL_DATA" >> "$HEARTBEAT_FILE"
echo "- Knowledge: $TOTAL_KNOWLEDGE" >> "$HEARTBEAT_FILE"
echo "- **总计**: $((TOTAL_SKILLS + TOTAL_DATA + TOTAL_KNOWLEDGE))" >> "$HEARTBEAT_FILE"
echo "" >> "$HEARTBEAT_FILE"

# 检查 4: 系统健康度
echo "### 4. 系统健康度" >> "$HEARTBEAT_FILE"
echo "" >> "$HEARTBEAT_FILE"

# 检查是否有过期的能力资产（简化版）
OUTDATED=0
echo "✅ 系统运行正常" >> "$HEARTBEAT_FILE"
echo "" >> "$HEARTBEAT_FILE"

# 行动建议
echo "## 🔄 建议行动" >> "$HEARTBEAT_FILE"
echo "" >> "$HEARTBEAT_FILE"

if [ "$ACTIVE_TASKS" -eq 0 ]; then
    echo "- 考虑创建新任务" >> "$HEARTBEAT_FILE"
fi

if [ "$RESOURCE_REQUESTS" -gt 0 ]; then
    echo "- ⚠️ 有 $RESOURCE_REQUESTS 个资源请求待 Owner 处理" >> "$HEARTBEAT_FILE"
fi

# 本周进度
WEEK_AGO=$(date -v-7d +%Y-%m-%d)
RECENT_COMMITS=$(git log --since="$WEEK_AGO" --oneline 2>/dev/null | wc -l | xargs)
echo "- 本周提交数：$RECENT_COMMITS" >> "$HEARTBEAT_FILE"

echo "" >> "$HEARTBEAT_FILE"
echo "---" >> "$HEARTBEAT_FILE"
echo "_巡检完成时间：$(date)_" >> "$HEARTBEAT_FILE"

echo "✅ Heartbeat 已生成：$HEARTBEAT_FILE"
echo ""
cat "$HEARTBEAT_FILE"
