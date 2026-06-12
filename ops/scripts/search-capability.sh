#!/bin/bash
# 能力搜索脚本
# 在能力库中搜索相关能力

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
CAPABILITIES_DIR="$REPO_ROOT/capabilities"

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# 使用说明
usage() {
    cat << USAGE
🔍 能力搜索脚本

用法:
    bash $(basename $0) [选项] <关键词>

选项:
    -t, --type TYPE         按类型筛选 (skill/data/knowledge/system)
    -i, --case-insensitive  忽略大小写（默认）
    -c, --case-sensitive    区分大小写
    -w, --whole-word        全词匹配
    -f, --file-only         只显示文件名
    -v, --verbose           详细模式（显示匹配内容）
    -h, --help              显示此帮助信息

示例:
    # 搜索 "error" 相关能力
    bash $(basename $0) error

    # 只搜索 skills
    bash $(basename $0) -t skill debugging

    # 详细模式（显示匹配的内容）
    bash $(basename $0) -v "problem driven"

    # 只显示文件名
    bash $(basename $0) -f quality

USAGE
    exit 1
}

# 解析参数
TYPE=""
CASE_FLAG="-i"  # -i = 忽略大小写
WHOLE_WORD=false
FILE_ONLY=false
VERBOSE=false
QUERY=""

while [[ $# -gt 0 ]]; do
    case $1 in
        -t|--type)
            TYPE="$2"
            shift 2
            ;;
        -i|--case-insensitive)
            CASE_FLAG="-i"
            shift
            ;;
        -c|--case-sensitive)
            CASE_FLAG=""
            shift
            ;;
        -w|--whole-word)
            WHOLE_WORD=true
            shift
            ;;
        -f|--file-only)
            FILE_ONLY=true
            shift
            ;;
        -v|--verbose)
            VERBOSE=true
            shift
            ;;
        -h|--help)
            usage
            ;;
        -*)
            echo -e "${RED}错误: 未知选项 $1${NC}"
            usage
            ;;
        *)
            QUERY="$QUERY $1"
            shift
            ;;
    esac
done

QUERY=$(echo "$QUERY" | xargs)  # trim spaces

if [[ -z "$QUERY" ]]; then
    echo -e "${RED}错误: 必须提供搜索关键词${NC}"
    usage
fi

# 构建 grep 参数
GREP_OPTS="$CASE_FLAG -n"
if [[ "$WHOLE_WORD" == true ]]; then
    GREP_OPTS="$GREP_OPTS -w"
fi

# 显示结果
display_result() {
    local file=$1
    local type=$(basename $(dirname "$file"))
    local name=$(basename "$file" .md)
    local rel_path="${type}/${name}.md"
    
    if [[ "$FILE_ONLY" == true ]]; then
        echo "$rel_path"
        return
    fi
    
    # 提取标题和描述（修复 sed 正则表达式）
    local title=$(grep -m 1 "^# " "$file" 2>/dev/null | sed 's/^# //' || echo "$name")
    local desc=$(grep -m 1 "^**用途" "$file" 2>/dev/null | sed 's/^\*\*用途\*\*：//' | sed 's/^\*\*用途\*\*//' || echo "")
    
    echo -e "${GREEN}📄 $rel_path${NC}"
    echo -e "   ${CYAN}$title${NC}"
    if [[ -n "$desc" ]]; then
        echo -e "   ${YELLOW}$desc${NC}"
    fi
    
    if [[ "$VERBOSE" == true ]]; then
        echo -e "   ${BLUE}匹配内容:${NC}"
        grep $GREP_OPTS --color=always "$QUERY" "$file" 2>/dev/null | head -n 3 | sed 's/^/     /' || true
    fi
    
    echo ""
}

# 主逻辑
main() {
    cd "$REPO_ROOT"
    
    if [[ ! -d "$CAPABILITIES_DIR" ]]; then
        echo -e "${RED}错误: 能力目录不存在${NC}"
        exit 1
    fi
    
    echo -e "${GREEN}🔍 搜索能力: \"$QUERY\"${NC}"
    if [[ -n "$TYPE" ]]; then
        echo -e "${YELLOW}类型筛选: $TYPE${NC}"
    fi
    echo ""
    
    # 确定搜索路径
    local search_path="$CAPABILITIES_DIR"
    if [[ -n "$TYPE" ]]; then
        search_path="$CAPABILITIES_DIR/$TYPE"
        if [[ ! -d "$search_path" ]]; then
            echo -e "${RED}错误: 类型不存在 $TYPE${NC}"
            exit 1
        fi
    fi
    
    # 搜索
    local count=0
    while IFS= read -r file; do
        if grep $GREP_OPTS -q "$QUERY" "$file" 2>/dev/null; then
            display_result "$file"
            count=$((count + 1))
        fi
    done < <(find "$search_path" -name "*.md" -type f | sort)
    
    # 总结
    echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    if [[ $count -eq 0 ]]; then
        echo -e "${YELLOW}未找到匹配的能力${NC}"
        echo ""
        echo "建议:"
        echo "  - 尝试更通用的关键词"
        echo "  - 使用 -i 忽略大小写"
        echo "  - 移除 -w 全词匹配限制"
    else
        echo -e "${GREEN}找到 $count 个匹配的能力${NC}"
    fi
}

main
