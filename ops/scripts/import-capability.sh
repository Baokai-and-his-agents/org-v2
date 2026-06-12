#!/bin/bash
# 能力导入脚本
# 从 YAML 文件导入能力到本地能力库

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
CAPABILITIES_DIR="$REPO_ROOT/capabilities"

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# 使用说明
usage() {
    cat << USAGE
📥 能力导入脚本

用法:
    bash $(basename $0) [选项]

选项:
    -f, --file FILE         YAML 能力包文件路径
    -d, --dry-run          预览模式（不实际写入）
    -s, --skip-existing    跳过已存在的能力
    -o, --overwrite        覆盖已存在的能力
    -r, --rename           重命名冲突的能力
    -h, --help             显示此帮助信息

示例:
    # 预览导入
    bash $(basename $0) -f capability.yaml --dry-run

    # 实际导入（跳过已存在）
    bash $(basename $0) -f capability.yaml --skip-existing

    # 覆盖导入
    bash $(basename $0) -f capability.yaml --overwrite

USAGE
    exit 1
}

# 解析参数
FILE=""
DRY_RUN=false
CONFLICT_MODE="ask"  # ask/skip/overwrite/rename

while [[ $# -gt 0 ]]; do
    case $1 in
        -f|--file)
            FILE="$2"
            shift 2
            ;;
        -d|--dry-run)
            DRY_RUN=true
            shift
            ;;
        -s|--skip-existing)
            CONFLICT_MODE="skip"
            shift
            ;;
        -o|--overwrite)
            CONFLICT_MODE="overwrite"
            shift
            ;;
        -r|--rename)
            CONFLICT_MODE="rename"
            shift
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
if [[ -z "$FILE" ]]; then
    echo -e "${RED}错误: 必须指定 -f FILE${NC}"
    usage
fi

if [[ ! -f "$FILE" ]]; then
    echo -e "${RED}错误: 文件不存在 $FILE${NC}"
    exit 1
fi

# 简易 YAML 解析（提取能力内容）
# 注意：这是简化版，生产环境应使用 yq 或 python
extract_capabilities() {
    local yaml_file=$1
    
    # 检测是否有 yq
    if command -v yq &> /dev/null; then
        echo -e "${GREEN}使用 yq 解析 YAML${NC}"
        # 使用 yq 解析（更可靠）
        yq eval '.capabilities[] | .type + "|" + .path + "|" + (.content | @base64)' "$yaml_file"
    else
        echo -e "${YELLOW}警告: 未安装 yq，使用简易解析器${NC}"
        echo -e "${YELLOW}推荐安装 yq: brew install yq 或 pip install yq${NC}"
        
        # 简易解析器（基于模式匹配）
        awk '
        /^  - type:/ { type=$3 }
        /^    path:/ { path=$2 }
        /^    content: \|/ { 
            in_content=1
            content=""
            next
        }
        in_content && /^      / {
            sub(/^      /, "")
            content = content $0 "\n"
        }
        in_content && !/^      / {
            print type "|" path "|" content
            in_content=0
            type=""
            path=""
            content=""
        }
        ' "$yaml_file"
    fi
}

# 导入单个能力
import_capability() {
    local type=$1
    local path=$2
    local content=$3
    
    # 提取文件名
    local filename=$(basename "$path")
    local target="$CAPABILITIES_DIR/$type/$filename"
    
    # 检查冲突
    if [[ -f "$target" ]]; then
        case $CONFLICT_MODE in
            skip)
                echo -e "${YELLOW}⏭️  跳过已存在: $type/$filename${NC}"
                return 0
                ;;
            overwrite)
                echo -e "${YELLOW}📝 覆盖已存在: $type/$filename${NC}"
                ;;
            rename)
                local counter=1
                local name="${filename%.md}"
                while [[ -f "$CAPABILITIES_DIR/$type/${name}-${counter}.md" ]]; do
                    counter=$((counter + 1))
                done
                filename="${name}-${counter}.md"
                target="$CAPABILITIES_DIR/$type/$filename"
                echo -e "${BLUE}📝 重命名为: $type/$filename${NC}"
                ;;
            ask)
                echo -e "${YELLOW}⚠️  冲突检测到: $type/$filename${NC}"
                echo "  本地: $target"
                echo "  导入: $path"
                echo ""
                echo "选项:"
                echo "  1) 跳过（保留本地）"
                echo "  2) 覆盖（使用导入）"
                echo "  3) 重命名（保留两者）"
                read -p "请选择 [1/2/3]: " choice
                case $choice in
                    1) return 0 ;;
                    2) echo -e "${GREEN}覆盖${NC}" ;;
                    3) 
                        local counter=1
                        local name="${filename%.md}"
                        while [[ -f "$CAPABILITIES_DIR/$type/${name}-${counter}.md" ]]; do
                            counter=$((counter + 1))
                        done
                        filename="${name}-${counter}.md"
                        target="$CAPABILITIES_DIR/$type/$filename"
                        echo -e "${GREEN}重命名为: $filename${NC}"
                        ;;
                    *) 
                        echo -e "${RED}无效选择，跳过${NC}"
                        return 0
                        ;;
                esac
                ;;
        esac
    fi
    
    # 写入文件
    if [[ "$DRY_RUN" == true ]]; then
        echo -e "${BLUE}[DRY-RUN] 将导入: $type/$filename${NC}"
    else
        mkdir -p "$(dirname "$target")"
        echo "$content" > "$target"
        echo -e "${GREEN}✅ 导入成功: $type/$filename${NC}"
    fi
}

# 主逻辑
main() {
    cd "$REPO_ROOT"
    
    echo -e "${GREEN}📥 开始导入能力包...${NC}"
    echo "文件: $FILE"
    
    if [[ "$DRY_RUN" == true ]]; then
        echo -e "${YELLOW}模式: 预览（不实际写入）${NC}"
    fi
    
    echo ""
    
    # 解析并导入
    local count=0
    local success=0
    
    while IFS='|' read -r type path content; do
        if [[ -z "$type" || -z "$path" ]]; then
            continue
        fi
        
        count=$((count + 1))
        
        # 如果使用 yq，content 是 base64 编码的
        if command -v yq &> /dev/null; then
            content=$(echo "$content" | base64 -d 2>/dev/null || echo "$content")
        fi
        
        import_capability "$type" "$path" "$content" && success=$((success + 1))
    done < <(extract_capabilities "$FILE")
    
    echo ""
    echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${GREEN}导入完成${NC}"
    echo "总计: $count 个能力"
    echo "成功: $success 个"
    
    if [[ "$DRY_RUN" == false ]]; then
        echo ""
        echo "下一步:"
        echo "1. 运行质量检查: bash ops/scripts/check-capabilities.sh"
        echo "2. 查看导入的能力: ls $CAPABILITIES_DIR/"
        echo "3. 提交到 Git: git add capabilities/ && git commit -m 'Import capabilities'"
    fi
}

main
