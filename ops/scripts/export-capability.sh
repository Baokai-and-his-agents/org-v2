#!/bin/bash
# 能力导出脚本
# 将能力导出为 YAML 格式，便于分享和复用

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
CAPABILITIES_DIR="$REPO_ROOT/capabilities"

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# 使用说明
usage() {
    cat << USAGE
📦 能力导出脚本

用法:
    bash $(basename $0) [选项]

选项:
    -t, --type TYPE          能力类型 (skill/data/knowledge/system)
    -n, --name NAME          能力名称
    -c, --category CATEGORY  导出整个类别的所有能力
    -a, --all               导出所有能力
    -o, --output FILE       输出文件路径 (默认: capability-export.yaml)
    -h, --help              显示此帮助信息

示例:
    # 导出单个 skill
    bash $(basename $0) -t skill -n problem-driven-development -o my-skill.yaml

    # 导出所有 skills
    bash $(basename $0) -c skill -o all-skills.yaml

    # 导出所有能力
    bash $(basename $0) -a -o all-capabilities.yaml

USAGE
    exit 1
}

# 解析参数
TYPE=""
NAME=""
CATEGORY=""
ALL=false
OUTPUT="capability-export.yaml"

while [[ $# -gt 0 ]]; do
    case $1 in
        -t|--type)
            TYPE="$2"
            shift 2
            ;;
        -n|--name)
            NAME="$2"
            shift 2
            ;;
        -c|--category)
            CATEGORY="$2"
            shift 2
            ;;
        -a|--all)
            ALL=true
            shift
            ;;
        -o|--output)
            OUTPUT="$2"
            shift 2
            ;;
        -h|--help)
            usage
            ;;
        *)
            echo -e "${RED}错误: 未知选项 $1${NC}"
            usage
            ;;
    esac
done

# 验证参数
if [[ "$ALL" == false && -z "$CATEGORY" && ( -z "$TYPE" || -z "$NAME" ) ]]; then
    echo -e "${RED}错误: 必须指定 -t/-n, -c, 或 -a${NC}"
    usage
fi

# 获取 Git 用户信息作为作者
AUTHOR=$(git config user.name 2>/dev/null || echo "unknown")
EMAIL=$(git config user.email 2>/dev/null || echo "")
if [[ -n "$EMAIL" ]]; then
    AUTHOR="$AUTHOR <$EMAIL>"
fi

# 生成 YAML metadata
generate_metadata() {
    local pkg_name=$1
    local description=$2
    
    cat << METADATA
metadata:
  name: "$pkg_name"
  version: "1.0.0"
  author: "$AUTHOR"
  description: "$description"
  created: "$(date +%Y-%m-%d)"
  license: "MIT"
  tags: []

METADATA
}

# 导出单个能力
export_single() {
    local type=$1
    local name=$2
    local file="$CAPABILITIES_DIR/$type/$name.md"
    
    if [[ ! -f "$file" ]]; then
        echo -e "${RED}错误: 文件不存在 $file${NC}"
        exit 1
    fi
    
    echo -e "${GREEN}📦 导出能力: $type/$name${NC}"
    
    # 生成 YAML
    {
        generate_metadata "$name" "Capability: $type/$name"
        echo "capabilities:"
        echo "  - type: $type"
        echo "    path: $type/$name.md"
        echo "    content: |"
        # 缩进文件内容
        sed 's/^/      /' "$file"
        echo ""
        echo "quality:"
        echo "  rating: 5"
        echo "  validation: \"official\""
        echo "  usage_count: 0"
        echo "  last_updated: \"$(date +%Y-%m-%d)\""
    } > "$OUTPUT"
    
    echo -e "${GREEN}✅ 导出完成: $OUTPUT${NC}"
    echo "文件大小: $(du -h "$OUTPUT" | cut -f1)"
}

# 导出类别
export_category() {
    local category=$1
    local dir="$CAPABILITIES_DIR/$category"
    
    if [[ ! -d "$dir" ]]; then
        echo -e "${RED}错误: 类别不存在 $category${NC}"
        exit 1
    fi
    
    local count=$(find "$dir" -name "*.md" -type f | wc -l | tr -d ' ')
    echo -e "${GREEN}📦 导出类别: $category ($count 个能力)${NC}"
    
    # 生成 YAML
    {
        generate_metadata "$category-bundle" "All $category capabilities"
        echo "capabilities:"
        
        find "$dir" -name "*.md" -type f | sort | while read -r file; do
            local basename=$(basename "$file" .md)
            echo "  - type: $category"
            echo "    path: $category/$basename.md"
            echo "    content: |"
            sed 's/^/      /' "$file"
            echo ""
        done
        
        echo "quality:"
        echo "  rating: 5"
        echo "  validation: \"official\""
        echo "  usage_count: 0"
        echo "  last_updated: \"$(date +%Y-%m-%d)\""
    } > "$OUTPUT"
    
    echo -e "${GREEN}✅ 导出完成: $OUTPUT${NC}"
    echo "包含能力: $count 个"
    echo "文件大小: $(du -h "$OUTPUT" | cut -f1)"
}

# 导出所有能力
export_all() {
    echo -e "${GREEN}📦 导出所有能力...${NC}"
    
    local total=0
    for cat in skill data knowledge system; do
        local dir="$CAPABILITIES_DIR/$cat"
        if [[ -d "$dir" ]]; then
            local count=$(find "$dir" -name "*.md" -type f | wc -l | tr -d ' ')
            total=$((total + count))
        fi
    done
    
    echo "找到 $total 个能力"
    
    # 生成 YAML
    {
        generate_metadata "org-v2-all-capabilities" "Complete capability library"
        echo "capabilities:"
        
        for cat in skill data knowledge system; do
            local dir="$CAPABILITIES_DIR/$cat"
            if [[ ! -d "$dir" ]]; then
                continue
            fi
            
            find "$dir" -name "*.md" -type f | sort | while read -r file; do
                local basename=$(basename "$file" .md)
                echo "  - type: $cat"
                echo "    path: $cat/$basename.md"
                echo "    content: |"
                sed 's/^/      /' "$file"
                echo ""
            done
        done
        
        echo "quality:"
        echo "  rating: 5"
        echo "  validation: \"official\""
        echo "  usage_count: 0"
        echo "  last_updated: \"$(date +%Y-%m-%d)\""
    } > "$OUTPUT"
    
    echo -e "${GREEN}✅ 导出完成: $OUTPUT${NC}"
    echo "包含能力: $total 个"
    echo "文件大小: $(du -h "$OUTPUT" | cut -f1)"
}

# 主逻辑
main() {
    cd "$REPO_ROOT"
    
    if [[ "$ALL" == true ]]; then
        export_all
    elif [[ -n "$CATEGORY" ]]; then
        export_category "$CATEGORY"
    else
        export_single "$TYPE" "$NAME"
    fi
}

main
