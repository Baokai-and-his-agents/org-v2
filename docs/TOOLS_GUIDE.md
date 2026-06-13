# 工具使用指南

org-v2 提供 13 个自动化工具，帮助你高效管理组织能力。

**更新**：2026-06-13

---

## 🔧 工具清单

### 能力管理（6 个）

1. **export-capability.sh** - 导出能力
2. **import-capability.sh** - 导入能力
3. **search-capability.sh** - 搜索能力
4. **check-capabilities.sh** - 质量检查
5. **capability-usage-stats.sh** - 使用统计
6. **capability-dependencies.sh** - 依赖分析

### 报告监控（4 个）

7. **generate-weekly-report.sh** - 周报生成
8. **generate-monthly-report.sh** - 月报生成
9. **calculate-health-score.sh** - 健康度评分
10. **duty-check.sh** - 日常巡检

### 测试套件（3 个）

11. **test-capability-quality.sh** - 单元测试
12. **test-workflow-integration.sh** - 集成测试
13. **benchmark-tools.sh** - 性能测试

---

## 📚 详细使用

### 1. export-capability.sh

**用途**：导出能力为 YAML 格式，便于分享和备份

**基础用法**：
```bash
# 导出单个能力
bash ops/scripts/export-capability.sh \
  -t skill \
  -n problem-driven-development \
  -o output.yaml

# 导出整个分类
bash ops/scripts/export-capability.sh \
  -c skill \
  -o all-skills.yaml
```

**参数**：
- `-t, --type`：能力类型（skill/data/knowledge/system）
- `-n, --name`：能力名称
- `-c, --category`：导出整个分类
- `-o, --output`：输出文件路径

**使用场景**：
- 跨项目复用能力
- 团队分享经验
- 能力备份

---

### 2. import-capability.sh

**用途**：从 YAML 文件导入能力

**基础用法**：
```bash
# 导入单个能力
bash ops/scripts/import-capability.sh \
  -f capability.yaml

# 导入多个能力
bash ops/scripts/import-capability.sh \
  -f all-skills.yaml
```

**参数**：
- `-f, --file`：输入文件路径
- `-o, --overwrite`：覆盖已存在的能力（可选）

**使用场景**：
- 从其他项目导入能力
- 恢复备份
- 团队能力共享

---

### 3. search-capability.sh

**用途**：在所有能力中搜索关键词

**基础用法**：
```bash
# 搜索关键词
bash ops/scripts/search-capability.sh "testing"

# 按类型搜索
bash ops/scripts/search-capability.sh -t skill "automation"

# 精确匹配
bash ops/scripts/search-capability.sh -e "problem-driven-development"
```

**参数**：
- `keyword`：搜索关键词（必需）
- `-t, --type`：限定类型
- `-e, --exact`：精确匹配

**使用场景**：
- 快速找到相关能力
- 检查是否已有类似能力
- 复用现有经验

---

### 4. check-capabilities.sh

**用途**：检查所有能力文件的质量

**基础用法**：
```bash
# 运行质量检查
bash ops/scripts/check-capabilities.sh

# 查看报告
cat ops/reports/capability-quality-$(date +%Y-%m-%d).md
```

**检查项**：
- 文件格式（Markdown）
- 必需字段（类型、创建日期）
- 文件命名规范
- 目录结构

**使用场景**：
- 提交前验证
- 定期质量审查
- CI/CD 自动检查

---

### 5. capability-usage-stats.sh

**用途**：分析能力使用频率

**基础用法**：
```bash
# 查看使用统计
bash ops/scripts/capability-usage-stats.sh
```

**输出**：
- Top 10 最常用能力
- 未使用能力列表
- 统计摘要（总数、平均）

**使用场景**：
- 识别热门能力（重点维护）
- 发现冷门能力（考虑归档）
- 评估能力组合价值

---

### 6. capability-dependencies.sh

**用途**：分析能力之间的依赖关系

**基础用法**：
```bash
# 查看依赖关系
bash ops/scripts/capability-dependencies.sh
```

**输出**：
- 有依赖的能力列表
- 最多被引用的能力（核心）
- 关系统计

**使用场景**：
- 识别核心能力
- 理解知识图谱
- 引导能力开发

---

### 7. generate-weekly-report.sh

**用途**：自动生成周报

**基础用法**：
```bash
# 默认生成最近 7 天
bash ops/scripts/generate-weekly-report.sh

# 自定义天数
bash ops/scripts/generate-weekly-report.sh -d 14

# 指定输出
bash ops/scripts/generate-weekly-report.sh -o reports/weekly.md
```

**参数**：
- `-d, --days`：天数（默认 7）
- `-o, --output`：输出文件

**使用场景**：
- 周例会准备
- 进度追踪
- 团队同步

---

### 8. generate-monthly-report.sh

**用途**：自动生成月报

**基础用法**：
```bash
# 默认生成最近 30 天
bash ops/scripts/generate-monthly-report.sh

# 自定义周期
bash ops/scripts/generate-monthly-report.sh -d 60
```

**参数**：
- `-d, --days`：天数（默认 30）
- `-o, --output`：输出文件

**使用场景**：
- 月度回顾
- 长期趋势追踪
- 绩效评估

---

### 9. calculate-health-score.sh

**用途**：计算系统健康度（8 维度评分）

**基础用法**：
```bash
# 计算健康度
bash ops/scripts/calculate-health-score.sh
```

**输出**：
- 8 个维度评分（0-10）
- 总体健康度
- 改进建议

**使用场景**：
- 系统诊断
- 持续改进
- 目标设定

---

### 10. duty-check.sh

**用途**：日常巡检，生成 heartbeat

**基础用法**：
```bash
# 运行巡检
bash ops/scripts/duty-check.sh
```

**检查项**：
- 文件结构完整性
- 必需文档存在
- 能力文件格式

**使用场景**：
- 每日启动检查
- 定期维护
- 问题早发现

---

### 11-13. 测试套件

**基础用法**：
```bash
# 单元测试
bash ops/tests/test-capability-quality.sh

# 集成测试
bash ops/tests/integration/test-workflow-integration.sh

# 性能测试
bash ops/tests/performance/benchmark-tools.sh
```

**使用场景**：
- 提交前验证
- CI/CD 自动化
- 回归测试

---

## 🎯 常见工作流

### 工作流 1：添加新能力

```bash
# 1. 搜索是否已存在
bash ops/scripts/search-capability.sh "new-feature"

# 2. 创建能力文件
vim capabilities/skill/new-feature.md

# 3. 质量检查
bash ops/scripts/check-capabilities.sh

# 4. 提交
git add capabilities/skill/new-feature.md
git commit -m "Add capability: new-feature"
```

### 工作流 2：周报生成

```bash
# 1. 生成周报
bash ops/scripts/generate-weekly-report.sh -o reports/weekly-$(date +%Y%m%d).md

# 2. 查看报告
cat reports/weekly-$(date +%Y%m%d).md

# 3. 分享给团队
# 复制内容到 Slack/Email
```

### 工作流 3：能力分享

```bash
# 1. 导出能力
bash ops/scripts/export-capability.sh \
  -t skill \
  -n api-development \
  -o shared/api-development.yaml

# 2. 分享文件
# 发送给其他团队成员

# 3. 他们导入
bash ops/scripts/import-capability.sh -f api-development.yaml
```

### 工作流 4：系统诊断

```bash
# 1. 运行巡检
bash ops/scripts/duty-check.sh

# 2. 计算健康度
bash ops/scripts/calculate-health-score.sh

# 3. 质量检查
bash ops/scripts/check-capabilities.sh

# 4. 查看依赖
bash ops/scripts/capability-dependencies.sh
```

---

## 💡 最佳实践

### 1. 定期运行

**日常**（每天）：
```bash
bash ops/scripts/duty-check.sh
```

**周期**（每周）：
```bash
bash ops/scripts/generate-weekly-report.sh
bash ops/scripts/calculate-health-score.sh
```

**月度**（每月）：
```bash
bash ops/scripts/generate-monthly-report.sh
bash ops/scripts/capability-usage-stats.sh
```

### 2. Git Hooks 集成

```bash
# .git/hooks/pre-commit
#!/bin/bash
bash ops/scripts/check-capabilities.sh
```

### 3. CI/CD 集成

已在 `.github/workflows/quality-check.yml` 配置

### 4. Cron 定时任务

```bash
# 每天 9:00 运行巡检
0 9 * * * cd /path/to/org-v2 && bash ops/scripts/duty-check.sh

# 每周一 9:00 生成周报
0 9 * * 1 cd /path/to/org-v2 && bash ops/scripts/generate-weekly-report.sh
```

---

## ⚠️ 故障排查

### 问题 1：权限错误

**错误**：`Permission denied`

**解决**：
```bash
chmod +x ops/scripts/*.sh
chmod +x ops/tests/**/*.sh
```

### 问题 2：找不到文件

**错误**：`No such file or directory`

**解决**：确保在项目根目录运行
```bash
cd /path/to/org-v2
bash ops/scripts/xxx.sh
```

### 问题 3：跨平台兼容

**macOS vs Linux**：
- 所有脚本已处理跨平台差异
- 主要是 `date` 命令的区别
- 已自动检测并适配

---

## 📚 更多资源

- [最佳实践](BEST_PRACTICES.md) - 使用建议
- [故障排查](TROUBLESHOOTING.md) - 常见问题
- [贡献指南](../CONTRIBUTING.md) - 如何贡献

---

**高效使用工具，让 AI 原生组织运营更轻松！** ⚡
