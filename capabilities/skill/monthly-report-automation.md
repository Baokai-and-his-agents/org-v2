# Skill: Monthly Report Automation

**类型**：skill  
**创建**：2026-06-13  
**更新**：2026-06-13  
**复用次数**：1

## 🎯 用途

自动生成月度进展报告，追踪长期趋势和成就。

## 📥 输入

- 时间范围（默认 30 天）
- 输出文件路径（可选）

## 📤 输出

- Markdown 格式月度报告
- 包含：Git 统计、任务完成、能力资产、测试覆盖、主要成就

## 🔄 步骤

### 基础使用

```bash
# 默认生成最近 30 天报告
bash ops/scripts/generate-monthly-report.sh

# 自定义天数
bash ops/scripts/generate-monthly-report.sh -d 60

# 指定输出文件
bash ops/scripts/generate-monthly-report.sh -o reports/custom-report.md
```

### 报告内容

1. **整体概览**
   - Git 活动（提交数、贡献者、代码变更量）
   - 任务完成情况
   - 能力资产统计

2. **关键指标**
   - 系统健康度
   - 测试覆盖

3. **主要成就**
   - 本月完成的任务列表
   - 新增的能力列表

4. **改进建议**
   - 基于数据的改进方向

5. **下月计划**
   - 待填写部分

### 定期生成

```bash
# 每月 1 号自动生成（cron）
0 9 1 * * cd /path/to/org-v2 && bash ops/scripts/generate-monthly-report.sh
```

## 💡 注意事项

### 跨平台兼容

脚本自动处理 macOS 和 Linux 的 `date` 命令差异：

```bash
if [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS
    date -v-30d
else
    # Linux
    date -d "-30 days"
fi
```

### 数据来源

- **Git 统计**：`git log` 命令
- **任务统计**：扫描 `ops/tasks/` 目录
- **能力统计**：扫描 `capabilities/` 目录
- **测试统计**：分析测试脚本

### 与周报的区别

| 维度 | 周报 | 月报 |
|------|------|------|
| 周期 | 7 天 | 30 天 |
| 详细度 | 详细 | 概览 |
| 用途 | 短期追踪 | 长期趋势 |
| 频率 | 每周 | 每月 |

## 🎓 最佳实践

1. **定期生成**：每月初生成上月报告
2. **补充计划**：生成后手动填写下月计划
3. **趋势分析**：对比多个月份的报告
4. **团队分享**：月度报告可用于团队回顾

## 🔗 相关能力

- [[weekly-report-automation]] - 周报自动生成
- [[health-score-calculator]] - 健康度计算
- [[milestone-review-process]] - 里程碑回顾流程

---

_创建于任务 061_  
_补充周报工具，提供长期追踪_
