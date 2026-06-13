# 工具使用示例

20 个工具的实际使用场景和示例。

**更新**: 2026-06-13

---

## 🎯 使用场景

### 场景 1: 新项目初始化

```bash
# 1. 查看欢迎信息
bash ops/scripts/init-guide.sh

# 2. 运行初始巡检
bash ops/scripts/duty-check.sh

# 3. 查看健康度
bash ops/scripts/calculate-health-score.sh

# 4. 创建第一个备份
bash ops/scripts/backup-project.sh
```

---

### 场景 2: 每日工作流

```bash
# 早上启动
bash ops/scripts/duty-check.sh
bash ops/scripts/calculate-health-score.sh

# 工作中搜索能力
bash ops/scripts/search-capability.sh "testing"

# 下班前检查
bash ops/scripts/check-capabilities.sh
bash ops/tests/test-capability-quality.sh
```

---

### 场景 3: 周五总结

```bash
# 生成周报
bash ops/scripts/generate-weekly-report.sh

# 查看能力使用情况
bash ops/scripts/capability-usage-stats.sh

# 查看贡献统计
bash ops/scripts/contributor-stats.sh

# 查看工具使用
bash ops/scripts/tool-usage-tracker.sh

# 查看能力热力图
bash ops/scripts/capability-heatmap.sh
```

---

### 场景 4: 月度回顾

```bash
# 生成月报
bash ops/scripts/generate-monthly-report.sh

# 生成统计报告
bash ops/scripts/generate-stats-report.sh

# 查看能力依赖
bash ops/scripts/capability-dependencies.sh

# 创建月度备份
bash ops/scripts/backup-project.sh backups/monthly-$(date +%Y%m)
```

---

### 场景 5: 能力分享

```bash
# 导出能力
bash ops/scripts/export-capability.sh \
  -t skill \
  -n problem-driven-development \
  -o exports/pdd.yaml

# 发送给团队成员
# (通过 email/Slack 等)

# 团队成员导入
bash ops/scripts/import-capability.sh -f pdd.yaml
```

---

### 场景 6: 提交前检查

```bash
# 质量检查
bash ops/scripts/check-capabilities.sh

# 运行所有测试
bash ops/tests/test-capability-quality.sh
bash ops/tests/integration/test-workflow-integration.sh
bash ops/tests/performance/benchmark-tools.sh

# 检查健康度
bash ops/scripts/calculate-health-score.sh

# 如果都通过，提交
git add .
git commit -m "Your commit message"
git push
```

---

### 场景 7: 发布准备

```bash
# 检查发布就绪度
bash ops/scripts/check-release-readiness.sh

# 生成统计报告
bash ops/scripts/generate-stats-report.sh

# 创建发布备份
bash ops/scripts/backup-project.sh backups/release-v1.0

# 如果就绪度 ≥ 90%，可以发布
```

---

### 场景 8: 能力分析

```bash
# 查看使用统计
bash ops/scripts/capability-usage-stats.sh

# 查看依赖关系
bash ops/scripts/capability-dependencies.sh

# 查看热力图
bash ops/scripts/capability-heatmap.sh

# 基于分析结果决定：
# - 重点维护热门能力
# - 优化或归档冷门能力
# - 增加核心能力的文档
```

---

## 🔧 工具组合使用

### 组合 1: 完整健康检查

```bash
#!/bin/bash
echo "运行完整健康检查..."

# 1. 基础巡检
bash ops/scripts/duty-check.sh

# 2. 能力质量
bash ops/scripts/check-capabilities.sh

# 3. 测试套件
bash ops/tests/test-capability-quality.sh

# 4. 健康度评分
bash ops/scripts/calculate-health-score.sh

# 5. 发布准备
bash ops/scripts/check-release-readiness.sh

echo "健康检查完成！"
```

---

### 组合 2: 全面分析报告

```bash
#!/bin/bash
REPORT_DIR="reports/analysis-$(date +%Y%m%d)"
mkdir -p "$REPORT_DIR"

# 1. 项目统计
bash ops/scripts/generate-stats-report.sh \
  "$REPORT_DIR/stats.md"

# 2. 能力分析
bash ops/scripts/capability-usage-stats.sh \
  > "$REPORT_DIR/usage.txt"

bash ops/scripts/capability-dependencies.sh \
  > "$REPORT_DIR/dependencies.txt"

bash ops/scripts/capability-heatmap.sh \
  > "$REPORT_DIR/heatmap.txt"

# 3. 工具使用
bash ops/scripts/tool-usage-tracker.sh \
  > "$REPORT_DIR/tools.txt"

# 4. 贡献统计
bash ops/scripts/contributor-stats.sh \
  > "$REPORT_DIR/contributors.txt"

echo "分析报告已生成: $REPORT_DIR"
```

---

### 组合 3: 自动化周报

```bash
#!/bin/bash
# 添加到 crontab: 0 9 * * 1 (每周一早上 9 点)

WEEK=$(date +%Y-W%V)
REPORT_DIR="reports/weekly/$WEEK"
mkdir -p "$REPORT_DIR"

# 生成周报
bash ops/scripts/generate-weekly-report.sh \
  "$REPORT_DIR/weekly.md"

# 附加统计
bash ops/scripts/capability-usage-stats.sh \
  > "$REPORT_DIR/capabilities.txt"

bash ops/scripts/contributor-stats.sh \
  > "$REPORT_DIR/contributors.txt"

# 发送通知（可选）
# curl -X POST https://hooks.slack.com/... \
#   -d "{'text': '周报已生成: $REPORT_DIR'}"
```

---

## 💡 最佳实践

### 1. 每日使用

**必须**:
- duty-check.sh (每天至少 1 次)
- calculate-health-score.sh (每天 1 次)

**推荐**:
- search-capability.sh (按需)
- check-capabilities.sh (提交前)

---

### 2. 每周使用

**必须**:
- generate-weekly-report.sh (周五)
- capability-usage-stats.sh (周五)

**推荐**:
- contributor-stats.sh (了解活动)
- tool-usage-tracker.sh (优化工作流)
- backup-project.sh (每周备份)

---

### 3. 每月使用

**必须**:
- generate-monthly-report.sh (月末)
- generate-stats-report.sh (月末)

**推荐**:
- capability-dependencies.sh (优化关系)
- capability-heatmap.sh (识别问题)
- check-release-readiness.sh (评估状态)

---

### 4. 按需使用

**能力管理**:
- export-capability.sh (分享时)
- import-capability.sh (接收时)
- search-capability.sh (查找时)

**测试**:
- test-capability-quality.sh (提交前)
- test-workflow-integration.sh (重大改动后)
- benchmark-tools.sh (性能关注时)

**其他**:
- init-guide.sh (新用户)
- backup-project.sh (重要节点前)

---

## 🚀 进阶技巧

### 技巧 1: 创建快捷命令

```bash
# 添加到 ~/.bashrc 或 ~/.zshrc
alias org-check='cd ~/org-v2 && bash ops/scripts/duty-check.sh'
alias org-health='cd ~/org-v2 && bash ops/scripts/calculate-health-score.sh'
alias org-test='cd ~/org-v2 && bash ops/tests/test-capability-quality.sh'
alias org-backup='cd ~/org-v2 && bash ops/scripts/backup-project.sh'
```

---

### 技巧 2: Git Hooks 集成

```bash
# .git/hooks/pre-commit
#!/bin/bash
bash ops/scripts/check-capabilities.sh || exit 1
bash ops/tests/test-capability-quality.sh || exit 1
```

---

### 技巧 3: CI/CD 集成

已在 `.github/workflows/quality-check.yml` 配置。

---

### 技巧 4: 监控集成

```bash
# 结合监控系统
bash ops/scripts/calculate-health-score.sh | \
  grep "总体健康度" | \
  awk '{print $2}' | \
  curl -X POST https://monitoring.example.com/metrics \
    -d "health_score=$1"
```

---

## 📚 更多资源

- [工具完整指南](TOOLS_GUIDE.md) - 详细文档
- [工具快速参考](TOOLS_QUICK_REFERENCE.md) - 速查表
- [最佳实践](BEST_PRACTICES.md) - 使用建议

---

**让工具为你工作，而不是你为工具工作！** ⚡
