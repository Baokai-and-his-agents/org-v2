#!/bin/bash
# 系统健康度自动评分脚本
# 根据多个维度自动计算 org-v2 系统的健康度

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"

# 颜色定义
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
CYAN='\033[0;36m'
NC='\033[0m'

# 评分函数：将分数归一化到 0-10
normalize_score() {
    local actual=$1
    local min=$2
    local max=$3
    local score=$(echo "scale=2; 10 * ($actual - $min) / ($max - $min)" | bc)
    
    # 确保在 0-10 范围内
    if (( $(echo "$score < 0" | bc -l) )); then
        echo "0"
    elif (( $(echo "$score > 10" | bc -l) )); then
        echo "10"
    else
        printf "%.1f" "$score"
    fi
}

# 1. 结构清晰度评分
score_structure_clarity() {
    cd "$REPO_ROOT"
    
    # 检查核心目录是否存在
    local required_dirs=("control" "ops" "capabilities" "docs")
    local existing=0
    
    for dir in "${required_dirs[@]}"; do
        [[ -d "$dir" ]] && existing=$((existing + 1))
    done
    
    # 检查关键文件
    local required_files=("NOW.md" "MEMORY.md" "README.md" "QUICKSTART.md")
    for file in "${required_files[@]}"; do
        [[ -f "$file" ]] && existing=$((existing + 1))
    done
    
    # 8 个关键项，normalize到 0-10
    normalize_score $existing 0 8
}

# 2. 可执行性评分
score_executability() {
    cd "$REPO_ROOT"
    
    # 统计可执行脚本数量
    local scripts=$(find ops/scripts -name "*.sh" -type f 2>/dev/null | wc -l | tr -d ' ')
    
    # 检查脚本是否可执行
    local executable=0
    while IFS= read -r script; do
        [[ -x "$script" ]] && executable=$((executable + 1))
    done < <(find ops/scripts -name "*.sh" -type f 2>/dev/null)
    
    # 至少 5 个可执行脚本得满分
    normalize_score $executable 0 5
}

# 3. 文档完整度评分
score_documentation() {
    cd "$REPO_ROOT"
    
    # 关键文档列表
    local docs=(
        "README.md"
        "QUICKSTART.md"
        "FAQ.md"
        "ROADMAP.md"
        "CONTRIBUTING.md"
        "docs/DISCUSSIONS.md"
        "docs/FEEDBACK.md"
        "docs/ANALYTICS.md"
        "docs/CAPABILITY_SHARING.md"
        "docs/AGENT_COLLABORATION.md"
    )
    
    local existing=0
    local total=${#docs[@]}
    
    for doc in "${docs[@]}"; do
        if [[ -f "$doc" ]]; then
            # 检查文件不是空的
            local size=$(wc -l < "$doc" 2>/dev/null || echo "0")
            [[ $size -gt 10 ]] && existing=$((existing + 1))
        fi
    done
    
    normalize_score $existing 0 $total
}

# 4. 自动化程度评分
score_automation() {
    cd "$REPO_ROOT"
    
    # CI/CD 文件
    local ci_score=0
    [[ -f ".github/workflows/quality-check.yml" ]] && ci_score=$((ci_score + 2))
    [[ -f ".github/workflows/capability-check.yml" ]] && ci_score=$((ci_score + 2))
    
    # 自动化脚本
    local automation_scripts=(
        "ops/scripts/check-capabilities.sh"
        "ops/scripts/duty-check.sh"
        "ops/scripts/export-capability.sh"
        "ops/scripts/import-capability.sh"
        "ops/scripts/search-capability.sh"
        "ops/scripts/generate-weekly-report.sh"
    )
    
    for script in "${automation_scripts[@]}"; do
        [[ -x "$script" ]] && ci_score=$((ci_score + 1))
    done
    
    # 10 分满分
    normalize_score $ci_score 0 10
}

# 5. 能力沉淀率评分
score_capability_deposition() {
    cd "$REPO_ROOT"
    
    # 统计能力数量
    local skills=$(find capabilities/skill -name "*.md" -type f 2>/dev/null | wc -l | tr -d ' ')
    local data=$(find capabilities/data -name "*.md" -type f 2>/dev/null | wc -l | tr -d ' ')
    local knowledge=$(find capabilities/knowledge -name "*.md" -type f 2>/dev/null | wc -l | tr -d ' ')
    local system=$(find capabilities/system -name "*.md" -type f 2>/dev/null | wc -l | tr -d ' ')
    local total=$((skills + data + knowledge + system))
    
    # 20+ 能力得满分
    normalize_score $total 0 20
}

# 6. 度量可见性评分
score_metrics_visibility() {
    cd "$REPO_ROOT"
    
    local metrics_score=0
    
    # NOW.md 包含指标
    [[ -f "NOW.md" ]] && grep -q "系统健康度" NOW.md && metrics_score=$((metrics_score + 2))
    
    # 任务记录
    local tasks=$(find ops/tasks -name "*.md" -type f 2>/dev/null | wc -l | tr -d ' ')
    [[ $tasks -gt 10 ]] && metrics_score=$((metrics_score + 2))
    
    # Heartbeats
    local heartbeats=$(find ops/heartbeats -name "*.md" -type f 2>/dev/null | wc -l | tr -d ' ')
    [[ $heartbeats -gt 5 ]] && metrics_score=$((metrics_score + 2))
    
    # 报告
    local reports=$(find ops/reports -name "*.md" -type f 2>/dev/null | wc -l | tr -d ' ')
    [[ $reports -gt 2 ]] && metrics_score=$((metrics_score + 2))
    
    # 统计脚本
    [[ -x "ops/scripts/generate-weekly-report.sh" ]] && metrics_score=$((metrics_score + 2))
    
    # 10 分满分
    normalize_score $metrics_score 0 10
}

# 7. 质量保障评分
score_quality_assurance() {
    cd "$REPO_ROOT"
    
    local quality_score=0
    
    # CI 配置
    [[ -f ".github/workflows/quality-check.yml" ]] && quality_score=$((quality_score + 2))
    [[ -f ".github/workflows/capability-check.yml" ]] && quality_score=$((quality_score + 2))
    
    # 质量检查脚本
    [[ -x "ops/scripts/check-capabilities.sh" ]] && quality_score=$((quality_score + 2))
    
    # Issue/PR 模板
    [[ -d ".github/ISSUE_TEMPLATE" ]] && quality_score=$((quality_score + 2))
    [[ -f ".github/pull_request_template.md" ]] && quality_score=$((quality_score + 1))
    
    # 贡献指南
    [[ -f "CONTRIBUTING.md" ]] && quality_score=$((quality_score + 1))
    
    # 10 分满分
    normalize_score $quality_score 0 10
}

# 8. 外部验证评分
score_external_validation() {
    cd "$REPO_ROOT"
    
    local ext_score=0
    
    # 发布材料
    [[ -f "docs/launch/twitter-thread.md" ]] && ext_score=$((ext_score + 2))
    [[ -f "docs/launch/hackernews-post.md" ]] && ext_score=$((ext_score + 2))
    
    # 社区基础设施
    [[ -f "docs/DISCUSSIONS.md" ]] && ext_score=$((ext_score + 1))
    [[ -f "docs/FEEDBACK.md" ]] && ext_score=$((ext_score + 1))
    [[ -f "docs/ANALYTICS.md" ]] && ext_score=$((ext_score + 1))
    
    # 实际外部指标（GitHub）
    # 这里简化处理，实际应检查 stars/forks/issues
    local stars=0  # 需要 gh CLI 或 API
    [[ $stars -gt 10 ]] && ext_score=$((ext_score + 3))
    
    # 10 分满分（现在只能到 7，实际发布后能到 10）
    normalize_score $ext_score 0 10
}

# 主逻辑
main() {
    cd "$REPO_ROOT"
    
    echo -e "${GREEN}📊 计算系统健康度...${NC}"
    echo ""
    
    # 计算各维度评分
    local s1=$(score_structure_clarity)
    local s2=$(score_executability)
    local s3=$(score_documentation)
    local s4=$(score_automation)
    local s5=$(score_capability_deposition)
    local s6=$(score_metrics_visibility)
    local s7=$(score_quality_assurance)
    local s8=$(score_external_validation)
    
    # 计算总分
    local total=$(echo "scale=1; ($s1 + $s2 + $s3 + $s4 + $s5 + $s6 + $s7 + $s8) / 8" | bc)
    
    # 显示结果
    echo "| 维度 | 评分 | 状态 |"
    echo "|------|------|------|"
    echo "| 结构清晰度 | $s1/10 | $(get_status $s1) |"
    echo "| 可执行性 | $s2/10 | $(get_status $s2) |"
    echo "| 文档完整度 | $s3/10 | $(get_status $s3) |"
    echo "| 自动化程度 | $s4/10 | $(get_status $s4) |"
    echo "| 能力沉淀率 | $s5/10 | $(get_status $s5) |"
    echo "| 度量可见性 | $s6/10 | $(get_status $s6) |"
    echo "| 质量保障 | $s7/10 | $(get_status $s7) |"
    echo "| 外部验证 | $s8/10 | $(get_status $s8) |"
    echo ""
    echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${CYAN}总体健康度: $total/10${NC}"
    echo ""
    
    # 评级
    if (( $(echo "$total >= 9.0" | bc -l) )); then
        echo -e "${GREEN}🌟 优秀 (Excellent)${NC}"
    elif (( $(echo "$total >= 8.0" | bc -l) )); then
        echo -e "${GREEN}✅ 良好 (Good)${NC}"
    elif (( $(echo "$total >= 7.0" | bc -l) )); then
        echo -e "${YELLOW}⚠️  尚可 (Fair)${NC}"
    else
        echo -e "${RED}❌ 需改进 (Needs Improvement)${NC}"
    fi
    
    # 建议
    echo ""
    echo "改进建议:"
    suggest_improvements $s1 $s2 $s3 $s4 $s5 $s6 $s7 $s8
}

# 获取状态表情
get_status() {
    local score=$1
    if (( $(echo "$score >= 9.0" | bc -l) )); then
        echo "🌟"
    elif (( $(echo "$score >= 8.0" | bc -l) )); then
        echo "✅"
    elif (( $(echo "$score >= 7.0" | bc -l) )); then
        echo "⚠️"
    else
        echo "❌"
    fi
}

# 改进建议
suggest_improvements() {
    local scores=("$@")
    local dimensions=("结构清晰度" "可执行性" "文档完整度" "自动化程度" "能力沉淀率" "度量可见性" "质量保障" "外部验证")
    
    local has_suggestions=false
    for i in {0..7}; do
        if (( $(echo "${scores[$i]} < 8.0" | bc -l) )); then
            echo "  - 提升${dimensions[$i]}（当前 ${scores[$i]}/10）"
            has_suggestions=true
        fi
    done
    
    if [[ "$has_suggestions" == false ]]; then
        echo "  无明显短板，系统运行良好！"
    fi
}

main
