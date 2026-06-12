# 进阶教程

深度使用 org-v2 的高级技巧。

---

## 🎯 适合对象

- 已完成 QUICKSTART.md
- 熟悉基本工作流程
- 希望深度定制和优化

---

## 📚 进阶主题

### 1. 自定义能力分类

**默认分类**：
- skill（工作方法）
- data（模板清单）
- knowledge（经验教训）
- system（系统设计）

**添加新分类**：

```bash
# 1. 创建新目录
mkdir capabilities/custom

# 2. 更新 INDEX.md
echo "- custom/" >> capabilities/INDEX.md

# 3. 创建第一个能力
cat > capabilities/custom/example.md << 'MD'
# Custom: Example

**类型**：custom
**创建**：2026-06-13
**更新**：2026-06-13
**复用次数**：0

## 🎯 用途
...
MD

# 4. 更新质量检查脚本（可选）
vi ops/scripts/check-capabilities.sh
```

---

### 2. 跨项目能力共享

**场景**：多个项目复用相同能力

**方案 A：符号链接**

```bash
# 中心化能力库
mkdir ~/org-capabilities

# 项目 A
cd project-a
ln -s ~/org-capabilities capabilities-shared

# 项目 B  
cd project-b
ln -s ~/org-capabilities capabilities-shared
```

**方案 B：Git Submodule**

```bash
# 创建共享仓库
cd ~/org-capabilities
git init
git add .
git commit -m "Init shared capabilities"

# 项目 A
cd project-a
git submodule add ~/org-capabilities capabilities-shared

# 项目 B
cd project-b
git submodule add ~/org-capabilities capabilities-shared

# 更新
git submodule update --remote
```

**方案 C：导入/导出**

```bash
# 项目 A 导出
cd project-a
bash ops/scripts/export-capability.sh -a -o ~/caps.yaml

# 项目 B 导入
cd project-b
bash ops/scripts/import-capability.sh -f ~/caps.yaml
```

---

### 3. CI/CD 高级配置

**多阶段质量检查**：

```yaml
# .github/workflows/quality-check.yml
name: Quality Check

on: [push, pull_request]

jobs:
  check-capabilities:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - name: Capability Quality
        run: bash ops/scripts/check-capabilities.sh
      
  check-health:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - name: System Health
        run: |
          score=$(bash ops/scripts/calculate-health-score.sh | grep "总体健康度" | awk '{print $2}' | cut -d'/' -f1)
          if (( $(echo "$score < 7.0" | bc -l) )); then
            echo "Health score too low: $score"
            exit 1
          fi
      
  check-docs:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - name: Documentation Links
        run: |
          # 检查死链
          find docs -name "*.md" -exec grep -o '\[.*\](.*\.md)' {} \; | \
            sed 's/.*(\(.*\))/\1/' | \
            while read link; do
              [ -f "$link" ] || echo "Dead link: $link"
            done
```

---

### 4. 自定义健康度维度

**添加新维度**：

```bash
# 编辑评分脚本
vi ops/scripts/calculate-health-score.sh

# 添加新函数
score_custom_dimension() {
    local score=0
    
    # 你的评分逻辑
    # ...
    
    normalize_score $score 0 10
}

# 在 main() 中调用
local s9=$(score_custom_dimension)

# 更新总分计算
local total=$(echo "scale=1; ($s1 + ... + $s9) / 9" | bc)
```

---

### 5. 任务模板化

**创建任务模板**：

```bash
# ops/templates/task-template.md
cat > ops/templates/task-template.md << 'TEMPLATE'
# 第 XXX 个任务：[任务名称]

**创建**：YYYY-MM-DD  
**状态**：计划中  
**类型**：[开发/文档/优化/规划]  
**优先级**：[高/中/低]  
**预计时间**：X 小时

---

## 🎯 目标

[一句话目标]

---

## 📋 背景

- 当前状态：
- 为什么需要：
- 预期影响：

---

## 🔄 执行计划

### 1. 第一步
- [ ] 子任务 1
- [ ] 子任务 2

### 2. 第二步
- [ ] 子任务 3

---

## 📤 预期输出

1. 
2. 

---

## ✅ 验收标准

1. 
2. 

---

## 📝 执行记录

_待填写_

---

## 💡 能力沉淀

**可复用性**：[高/中/低]  
**沉淀类型**：[skill/data/knowledge/system]  
**沉淀名称**：[如果可复用]
TEMPLATE

# 使用模板创建新任务
cp ops/templates/task-template.md ops/tasks/042-new-task.md
vi ops/tasks/042-new-task.md
```

---

### 6. 自动化工作流

**每日自动巡检**：

```bash
# crontab -e
# 每天 9:00 运行巡检
0 9 * * * cd /path/to/org-v2 && bash ops/scripts/duty-check.sh

# 每周一 9:00 生成周报
0 9 * * 1 cd /path/to/org-v2 && bash ops/scripts/generate-weekly-report.sh -o weekly-report.md
```

**Git hooks 自动化**：

```bash
# .git/hooks/pre-commit
#!/bin/bash
# 提交前运行质量检查

cd "$(git rev-parse --show-toplevel)"

echo "Running capability quality check..."
if ! bash ops/scripts/check-capabilities.sh; then
    echo "❌ Capability quality check failed!"
    echo "Fix issues and try again."
    exit 1
fi

echo "✅ Quality check passed"
```

---

### 7. 能力版本管理

**语义化版本**：

```bash
# 标记稳定版本
git tag -a v1.0.0 -m "First stable capability set (21 capabilities)"
git push origin v1.0.0

# 查看历史版本
git tag -l

# 回退到特定版本
git checkout v1.0.0
```

**能力变更日志**：

```markdown
# capabilities/CHANGELOG.md

## [1.1.0] - 2026-06-13

### Added
- capability-export-tool
- capability-import-tool
- capability-search-tool

### Changed
- Updated problem-driven-development workflow

### Deprecated
- old-debugging-method

### Removed
- None

### Fixed
- Cross-platform compatibility in bash scripts
```

---

### 8. 性能优化

**大型能力库优化**：

```bash
# 1. 使用索引加速搜索
# 创建能力索引
cat > capabilities/index.json << 'JSON'
{
  "skills": ["org-bootstrap", "duty-check", ...],
  "data": ["product-brief-template", ...],
  "knowledge": ["org-design-decisions", ...],
  "tags": {
    "automation": ["duty-check", "quality-check-automation"],
    "documentation": ["product-brief-template", ...]
  }
}
JSON

# 2. 压缩大文件
find capabilities -name "*.md" -size +1M -exec gzip {} \;

# 3. Git LFS 管理二进制
git lfs track "*.pdf"
git lfs track "*.png"
```

---

### 9. 多环境配置

**开发/生产分离**：

```bash
# config/development.env
HEALTH_CHECK_INTERVAL=1h
AUTO_PUSH=false
VERBOSE=true

# config/production.env  
HEALTH_CHECK_INTERVAL=24h
AUTO_PUSH=true
VERBOSE=false

# 使用
source config/development.env
bash ops/scripts/duty-check.sh
```

---

### 10. Agent 协作准备

**为未来 multi-agent 做准备**：

```bash
# 创建 agent 配置
cat > config/agents.yml << 'YAML'
agents:
  - id: dev-agent-1
    role: developer
    capabilities:
      - skill/*
      - knowledge/architecture-*
    permissions:
      - read: all
      - write: skill/
      
  - id: doc-agent
    role: documentation
    capabilities:
      - data/*
      - knowledge/documentation-*
    permissions:
      - read: all
      - write: data/
YAML
```

---

## 🔬 实验性功能

### AI 辅助能力生成

```bash
# 使用 AI 从任务记录生成能力文档
bash ops/scripts/ai-generate-capability.sh \
  --task ops/tasks/032-export-script.md \
  --output capabilities/skill/capability-export-tool.md
```

---

### 可视化能力关系图

```bash
# 生成能力依赖图
bash ops/scripts/visualize-capabilities.sh \
  --output capabilities-graph.svg
```

---

## 💡 最佳实践回顾

### 何时使用进阶功能

**不要过早优化**：
- ✅ 基础工作流稳定后
- ✅ 遇到明确痛点时
- ❌ 系统刚开始使用时

**渐进式采用**：
1. 掌握基本工作流（1-2 周）
2. 添加自动化（3-4 周）
3. 定制化优化（1-2 月）
4. 高级功能（按需）

---

## 🆘 需要帮助？

**进阶功能问题**：
1. 查看 [TROUBLESHOOTING.md](./TROUBLESHOOTING.md)
2. 搜索 [Discussions](https://github.com/Baokai-and-his-agents/org-v2/discussions)
3. 创建详细的 Issue

**贡献你的技巧**：
- 发现新的高级用法？
- 创建 PR 补充到本文档
- 或在 Discussions 分享

---

_最后更新：2026-06-13_  
_持续补充进阶技巧中..._
