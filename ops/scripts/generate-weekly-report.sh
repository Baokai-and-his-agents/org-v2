#!/bin/bash
# 周报生成脚本
# 自动收集本周任务、能力、提交，生成结构化周报

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"

# 颜色定义
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# 默认参数
DAYS=7
OUTPUT=""
FORMAT="markdown"

# 使用说明
usage() {
    cat << USAGE
📊 周报生成脚本

用法:
    bash $(basename $0) [选项]

选项:
    -d, --days DAYS         统计天数 (默认: 7)
    -o, --output FILE       输出文件路径
    -f, --format FORMAT     输出格式 (markdown/json, 默认: markdown)
    -h, --help              显示此帮助信息

示例:
    # 生成本周周报
    bash $(basename $0)

    # 生成最近 14 天报告
    bash $(basename $0) -d 14 -o report-2weeks.md

    # JSON 格式输出
    bash $(basename $0) -f json -o report.json

USAGE
    exit 1
}

# 解析参数
while [[ $# -gt 0 ]]; do
    case $1 in
        -d|--days)
            DAYS="$2"
            shift 2
            ;;
        -o|--output)
            OUTPUT="$2"
            shift 2
            ;;
        -f|--format)
            FORMAT="$2"
            shift 2
            ;;
        -h|--help)
            usage
            ;;
        *)
            echo "错误: 未知选项 $1"
            usage
            ;;
    esac
done

# 计算日期范围
SINCE_DATE=$(date -v-${DAYS}d +%Y-%m-%d 2>/dev/null || date -d "-${DAYS} days" +%Y-%m-%d)
TODAY=$(date +%Y-%m-%d)

# 收集数据
collect_data() {
    cd "$REPO_ROOT"
    
    # Git 提交统计
    local commits=$(git log --since="$DAYS days ago" --oneline | wc -l | tr -d ' ')
    local contributors=$(git log --since="$DAYS days ago" --format='%aN' | sort -u | wc -l | tr -d ' ')
    
    # 文件变更
    local files_changed=$(git diff --stat HEAD~$commits HEAD 2>/dev/null | tail -1 | awk '{print $1}' || echo "0")
    local insertions=$(git diff --stat HEAD~$commits HEAD 2>/dev/null | tail -1 | awk '{print $4}' || echo "0")
    local deletions=$(git diff --stat HEAD~$commits HEAD 2>/dev/null | tail -1 | awk '{print $6}' || echo "0")
    
    # 任务统计
    local completed_tasks=$(git log --since="$DAYS days ago" --grep="Complete task" --oneline | wc -l | tr -d ' ')
    
    # 能力统计
    local skill_count=$(find capabilities/skill -name "*.md" -type f 2>/dev/null | wc -l | tr -d ' ')
    local data_count=$(find capabilities/data -name "*.md" -type f 2>/dev/null | wc -l | tr -d ' ')
    local knowledge_count=$(find capabilities/knowledge -name "*.md" -type f 2>/dev/null | wc -l | tr -d ' ')
    local system_count=$(find capabilities/system -name "*.md" -type f 2>/dev/null | wc -l | tr -d ' ')
    local total_capabilities=$((skill_count + data_count + knowledge_count + system_count))
    
    # 最近任务列表
    local recent_tasks=$(git log --since="$DAYS days ago" --grep="Complete task" --format="%s" | sed 's/Complete task //')
    
    # 输出结果（内部格式）
    cat << DATA
commits|$commits
contributors|$contributors
files_changed|$files_changed
insertions|$insertions
deletions|$deletions
completed_tasks|$completed_tasks
skill_count|$skill_count
data_count|$data_count
knowledge_count|$knowledge_count
system_count|$system_count
total_capabilities|$total_capabilities
recent_tasks|$recent_tasks
DATA
}

# 生成 Markdown 报告
generate_markdown() {
    local data=$1
    
    # 解析数据
    local commits=$(echo "$data" | grep "^commits" | cut -d'|' -f2)
    local contributors=$(echo "$data" | grep "^contributors" | cut -d'|' -f2)
    local files_changed=$(echo "$data" | grep "^files_changed" | cut -d'|' -f2)
    local insertions=$(echo "$data" | grep "^insertions" | cut -d'|' -f2)
    local deletions=$(echo "$data" | grep "^deletions" | cut -d'|' -f2)
    local completed_tasks=$(echo "$data" | grep "^completed_tasks" | cut -d'|' -f2)
    local total_capabilities=$(echo "$data" | grep "^total_capabilities" | cut -d'|' -f2)
    local recent_tasks=$(echo "$data" | grep "^recent_tasks" | cut -d'|' -f2-)
    
    cat << MARKDOWN
# 周报 (${SINCE_DATE} → ${TODAY})

**生成时间**：$(date +"%Y-%m-%d %H:%M")

---

## 📊 整体统计

| 指标 | 数值 |
|------|------|
| Git 提交 | $commits |
| 贡献者 | $contributors |
| 文件变更 | $files_changed |
| 新增行数 | +$insertions |
| 删除行数 | -$deletions |
| 完成任务 | $completed_tasks |
| 能力资产 | $total_capabilities |

---

## ✅ 完成的任务

$( [[ -n "$recent_tasks" ]] && echo "$recent_tasks" | while read -r task; do echo "- $task"; done || echo "_本周无完成任务_" )

---

## 💎 能力资产库

当前能力总数：**$total_capabilities**

| 类型 | 数量 |
|------|------|
| Skills | $(echo "$data" | grep "^skill_count" | cut -d'|' -f2) |
| Data | $(echo "$data" | grep "^data_count" | cut -d'|' -f2) |
| Knowledge | $(echo "$data" | grep "^knowledge_count" | cut -d'|' -f2) |
| System | $(echo "$data" | grep "^system_count" | cut -d'|' -f2) |

---

## 🎯 下周计划

_待填写_

---

## 💬 备注

_待填写_

---

_自动生成于 $(date +"%Y-%m-%d %H:%M:%S")_
MARKDOWN
}

# 生成 JSON 报告
generate_json() {
    local data=$1
    
    cat << JSON
{
  "period": {
    "start": "$SINCE_DATE",
    "end": "$TODAY",
    "days": $DAYS
  },
  "generated_at": "$(date -u +"%Y-%m-%dT%H:%M:%SZ")",
  "statistics": {
    "commits": $(echo "$data" | grep "^commits" | cut -d'|' -f2),
    "contributors": $(echo "$data" | grep "^contributors" | cut -d'|' -f2),
    "files_changed": $(echo "$data" | grep "^files_changed" | cut -d'|' -f2),
    "insertions": $(echo "$data" | grep "^insertions" | cut -d'|' -f2),
    "deletions": $(echo "$data" | grep "^deletions" | cut -d'|' -f2),
    "completed_tasks": $(echo "$data" | grep "^completed_tasks" | cut -d'|' -f2)
  },
  "capabilities": {
    "total": $(echo "$data" | grep "^total_capabilities" | cut -d'|' -f2),
    "by_type": {
      "skill": $(echo "$data" | grep "^skill_count" | cut -d'|' -f2),
      "data": $(echo "$data" | grep "^data_count" | cut -d'|' -f2),
      "knowledge": $(echo "$data" | grep "^knowledge_count" | cut -d'|' -f2),
      "system": $(echo "$data" | grep "^system_count" | cut -d'|' -f2)
    }
  }
}
JSON
}

# 主逻辑
main() {
    echo -e "${GREEN}📊 生成周报...${NC}"
    echo -e "${CYAN}统计范围: $SINCE_DATE → $TODAY ($DAYS 天)${NC}"
    echo ""
    
    # 收集数据
    local data=$(collect_data)
    
    # 生成报告
    local report=""
    case $FORMAT in
        markdown)
            report=$(generate_markdown "$data")
            ;;
        json)
            report=$(generate_json "$data")
            ;;
        *)
            echo "错误: 不支持的格式 $FORMAT"
            exit 1
            ;;
    esac
    
    # 输出
    if [[ -n "$OUTPUT" ]]; then
        echo "$report" > "$OUTPUT"
        echo -e "${GREEN}✅ 报告已保存: $OUTPUT${NC}"
        echo "文件大小: $(du -h "$OUTPUT" | cut -f1)"
    else
        echo "$report"
    fi
}

main
