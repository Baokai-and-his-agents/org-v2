# 工具快速参考

17 个工具的速查表，快速找到需要的命令。

---

## 🔧 能力管理

```bash
# 导出能力
bash ops/scripts/export-capability.sh -t skill -n <name> -o <file>

# 导入能力
bash ops/scripts/import-capability.sh -f <file>

# 搜索能力
bash ops/scripts/search-capability.sh "<keyword>"

# 质量检查
bash ops/scripts/check-capabilities.sh

# 使用统计
bash ops/scripts/capability-usage-stats.sh

# 依赖分析
bash ops/scripts/capability-dependencies.sh

# 使用热力图
bash ops/scripts/capability-heatmap.sh
```

---

## 📊 报告监控

```bash
# 周报（最近 7 天）
bash ops/scripts/generate-weekly-report.sh

# 月报（最近 30 天）
bash ops/scripts/generate-monthly-report.sh

# 统计报告
bash ops/scripts/generate-stats-report.sh

# 健康度评分（8 维度）
bash ops/scripts/calculate-health-score.sh

# 日常巡检
bash ops/scripts/duty-check.sh

# 贡献统计
bash ops/scripts/contributor-stats.sh

# 发布准备检查
bash ops/scripts/check-release-readiness.sh
```

---

## ✅ 测试套件

```bash
# 单元测试（30 个）
bash ops/tests/test-capability-quality.sh

# 集成测试（5 个）
bash ops/tests/integration/test-workflow-integration.sh

# 性能测试（7 个）
bash ops/tests/performance/benchmark-tools.sh
```

---

## 💡 常用组合

### 每日启动
```bash
bash ops/scripts/duty-check.sh
bash ops/scripts/calculate-health-score.sh
```

### 周五总结
```bash
bash ops/scripts/generate-weekly-report.sh
bash ops/scripts/capability-usage-stats.sh
bash ops/scripts/contributor-stats.sh
```

### 发布前检查
```bash
bash ops/scripts/check-release-readiness.sh
bash ops/scripts/generate-stats-report.sh
```

### 提交前验证
```bash
bash ops/scripts/check-capabilities.sh
bash ops/tests/test-capability-quality.sh
```

### 能力分析
```bash
# 查看使用情况
bash ops/scripts/capability-usage-stats.sh

# 查看依赖关系
bash ops/scripts/capability-dependencies.sh

# 查看热力图
bash ops/scripts/capability-heatmap.sh
```

### 能力分享
```bash
# 导出
bash ops/scripts/export-capability.sh -t skill -n api-dev -o share.yaml

# 导入
bash ops/scripts/import-capability.sh -f share.yaml
```

---

## 🔗 详细文档

查看 [完整工具指南](TOOLS_GUIDE.md) 了解详细用法。
