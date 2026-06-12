#!/bin/bash
# 能力资产索引自动同步脚本
# 自动统计并更新 capabilities/INDEX.md 的统计数据

set -e

INDEX_FILE="capabilities/INDEX.md"
DRY_RUN=false

# 参数解析
while [[ $# -gt 0 ]]; do
    case $1 in
        --dry-run)
            DRY_RUN=true
            shift
            ;;
        *)
            echo "Unknown option: $1"
            echo "Usage: $0 [--dry-run]"
            exit 1
            ;;
    esac
done

echo "🔄 开始能力资产索引同步..."
echo ""

# 统计实际文件数
SKILLS_COUNT=$(find capabilities/skill/ -name "*.md" -not -name "README.md" 2>/dev/null | wc -l | xargs)
DATA_COUNT=$(find capabilities/data/ -name "*.md" -not -name "README.md" 2>/dev/null | wc -l | xargs)
KNOWLEDGE_COUNT=$(find capabilities/knowledge/ -name "*.md" -not -name "README.md" 2>/dev/null | wc -l | xargs)
TOTAL_COUNT=$((SKILLS_COUNT + DATA_COUNT + KNOWLEDGE_COUNT))

echo "📊 实际文件统计："
echo "  - Skills: $SKILLS_COUNT"
echo "  - Data: $DATA_COUNT"
echo "  - Knowledge: $KNOWLEDGE_COUNT"
echo "  - 总计: $TOTAL_COUNT"
echo ""

# 读取 INDEX.md 中的当前统计
if [ -f "$INDEX_FILE" ]; then
    CURRENT_SKILLS=$(grep "^- Skills:" "$INDEX_FILE" | grep -oE "[0-9]+" || echo "0")
    CURRENT_DATA=$(grep "^- Data:" "$INDEX_FILE" | grep -oE "[0-9]+" || echo "0")
    CURRENT_KNOWLEDGE=$(grep "^- Knowledge:" "$INDEX_FILE" | grep -oE "[0-9]+" || echo "0")

    echo "📋 INDEX.md 当前统计："
    echo "  - Skills: $CURRENT_SKILLS"
    echo "  - Data: $CURRENT_DATA"
    echo "  - Knowledge: $CURRENT_KNOWLEDGE"
    echo ""

    # 检查是否需要更新
    if [ "$SKILLS_COUNT" -eq "$CURRENT_SKILLS" ] && \
       [ "$DATA_COUNT" -eq "$CURRENT_DATA" ] && \
       [ "$KNOWLEDGE_COUNT" -eq "$CURRENT_KNOWLEDGE" ]; then
        echo "✅ 统计数据已同步，无需更新"
        exit 0
    fi

    echo "⚠️ 发现不一致，需要同步："
    if [ "$SKILLS_COUNT" -ne "$CURRENT_SKILLS" ]; then
        echo "  - Skills: $CURRENT_SKILLS → $SKILLS_COUNT"
    fi
    if [ "$DATA_COUNT" -ne "$CURRENT_DATA" ]; then
        echo "  - Data: $CURRENT_DATA → $DATA_COUNT"
    fi
    if [ "$KNOWLEDGE_COUNT" -ne "$CURRENT_KNOWLEDGE" ]; then
        echo "  - Knowledge: $CURRENT_KNOWLEDGE → $KNOWLEDGE_COUNT"
    fi
    echo ""
else
    echo "❌ 找不到 $INDEX_FILE"
    exit 1
fi

# Dry run 模式
if [ "$DRY_RUN" = true ]; then
    echo "🔍 Dry-run 模式：不执行实际更新"
    exit 0
fi

# 创建临时文件
TEMP_FILE=$(mktemp)

# 更新统计部分（兼容 macOS 和 Linux）
awk -v skills="$SKILLS_COUNT" -v data="$DATA_COUNT" -v knowledge="$KNOWLEDGE_COUNT" -v total="$TOTAL_COUNT" '
BEGIN { in_stats = 0 }

/^## 📊 统计/ {
    in_stats = 1
    print $0
    next
}

in_stats && /^- Skills:/ {
    print "- Skills: " skills
    next
}

in_stats && /^- Data:/ {
    print "- Data: " data
    next
}

in_stats && /^- Knowledge:/ {
    print "- Knowledge: " knowledge
    next
}

in_stats && /^\*\*总计\*\*/ {
    print "**总计**：" total " 个能力资产"
    if (total >= 10) {
        print " 🎉"
    }
    in_stats = 0
    next
}

in_stats && /^$/ {
    in_stats = 0
}

{ print }
' "$INDEX_FILE" > "$TEMP_FILE"

# 替换原文件
mv "$TEMP_FILE" "$INDEX_FILE"

echo "✅ INDEX.md 已更新"
echo ""

# 验证更新
VERIFY_SKILLS=$(grep "^- Skills:" "$INDEX_FILE" | grep -oE "[0-9]+")
VERIFY_DATA=$(grep "^- Data:" "$INDEX_FILE" | grep -oE "[0-9]+")
VERIFY_KNOWLEDGE=$(grep "^- Knowledge:" "$INDEX_FILE" | grep -oE "[0-9]+")

if [ "$VERIFY_SKILLS" -eq "$SKILLS_COUNT" ] && \
   [ "$VERIFY_DATA" -eq "$DATA_COUNT" ] && \
   [ "$VERIFY_KNOWLEDGE" -eq "$KNOWLEDGE_COUNT" ]; then
    echo "✅ 验证通过：同步成功"
    echo ""
    echo "更新摘要："
    echo "  - Skills: $CURRENT_SKILLS → $SKILLS_COUNT"
    echo "  - Data: $CURRENT_DATA → $DATA_COUNT"
    echo "  - Knowledge: $CURRENT_KNOWLEDGE → $KNOWLEDGE_COUNT"
    echo "  - 总计: $TOTAL_COUNT 个能力资产"
else
    echo "❌ 验证失败：同步可能不完整"
    exit 1
fi
