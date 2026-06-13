# 能力资产索引

**目的**：快速查找可复用的组织能力

**更新**：2026-06-13

---

## 📊 统计

- **Skills**: 16
- **Data**: 6
- **Knowledge**: 15
- **System**: 3

**总计**：40 个能力资产 🎊

**目标达成**：40/35+ (114%) ✅

**最后验证**：2026-06-13（任务 094）

---

## 🔧 Skills（工作方法）

> 可重复执行的流程、检查清单、脚本

1. [org-bootstrap](skill/org-bootstrap.md) - 从零搭建 AI 原生组织
2. [duty-check](skill/duty-check.md) - Duty Agent 定期巡检
3. [duty-check-automation](skill/duty-check-automation.md) - 自动化日常巡检
4. [problem-driven-development](skill/problem-driven-development.md) - 问题驱动开发
5. [launch-preparation](skill/launch-preparation.md) - 产品外部发布准备
6. [quality-check-automation](skill/quality-check-automation.md) - 自动化质量检查
7. [readme-optimization](skill/readme-optimization.md) - README 优化
8. [capability-export-tool](skill/capability-export-tool.md) - 能力导出工具
9. [capability-import-tool](skill/capability-import-tool.md) - 能力导入工具
10. [capability-search-tool](skill/capability-search-tool.md) - 能力搜索工具
11. [weekly-report-automation](skill/weekly-report-automation.md) - 周报自动生成
12. [health-score-calculator](skill/health-score-calculator.md) - 健康度自动评分
13. [unit-testing-framework](skill/unit-testing-framework.md) - 单元测试框架
14. [github-repo-setup](skill/github-repo-setup.md) - GitHub 仓库初始化
15. [monthly-report-automation](skill/monthly-report-automation.md) - 月度报告生成
16. [capability-analytics](skill/capability-analytics.md) - 能力分析（使用统计+依赖）

---

## 📚 Data（结构化事实）

> 样本、模板、价格表、竞品库

1. [product-brief-template](data/product-brief-template.md) - 产品 brief 模板
2. [contributing-guide-template](data/contributing-guide-template.md) - 贡献指南模板
3. [roadmap-template](data/roadmap-template.md) - 产品路线图模板
4. [task-template](data/task-template.md) - 任务文件模板
5. [capability-template](data/capability-template.md) - 能力文件模板
6. [launch-checklist](data/launch-checklist.md) - 产品发布检查清单

---

## 💡 Knowledge（经验案例）

> 决策依据、失败教训、成功案例

1. [org-design-decisions](knowledge/org-design-decisions.md) - 组织设计决策
2. [cross-platform-bash-compatibility](knowledge/cross-platform-bash-compatibility.md) - Bash 跨平台兼容
3. [competitor-analysis-ai-org-frameworks](knowledge/competitor-analysis-ai-org-frameworks.md) - AI 组织框架竞品分析
4. [github-actions-best-practices](knowledge/github-actions-best-practices.md) - GitHub Actions 最佳实践
5. [use-case-documentation](knowledge/use-case-documentation.md) - 使用案例文档编写
6. [best-practices-documentation](knowledge/best-practices-documentation.md) - 最佳实践文档编写
7. [troubleshooting-documentation](knowledge/troubleshooting-documentation.md) - 故障排查文档编写
8. [milestone-review-process](knowledge/milestone-review-process.md) - 里程碑回顾流程
9. [advanced-tutorial-documentation](knowledge/advanced-tutorial-documentation.md) - 进阶教程文档编写
10. [autonomous-iteration-strategy](knowledge/autonomous-iteration-strategy.md) - AI Agent 自主迭代策略
11. [phase-progression-insights](knowledge/phase-progression-insights.md) - Phase 演进规律
12. [tool-chain-design-insights](knowledge/tool-chain-design-insights.md) - 工具链设计经验
13. [self-learning-mechanism](knowledge/self-learning-mechanism.md) - AI Agent 自我学习机制
14. [community-example-patterns](knowledge/community-example-patterns.md) - 社区示例编写模式
15. [github-actions-cicd-setup](knowledge/github-actions-cicd-setup.md) - GitHub Actions CI/CD 配置

---

## 🏗️ System（系统设计）

> 架构设计、系统模式

1. [health-scoring-system](system/health-scoring-system.md) - 8 维度健康度评分系统
2. [quality-check-pipeline](system/quality-check-pipeline.md) - CI/CD 质量检查流水线
3. [capability-management-architecture](system/capability-management-architecture.md) - 能力管理系统架构

---

## 🔗 工具支持

### 查找能力
```bash
# 搜索关键词
bash ops/scripts/search-capability.sh "testing"

# 查看依赖
bash ops/scripts/capability-dependencies.sh
```

### 导入导出
```bash
# 导出能力
bash ops/scripts/export-capability.sh -t skill -n <name> -o <file>

# 导入能力
bash ops/scripts/import-capability.sh -f <file>
```

### 质量检查
```bash
# 检查所有能力
bash ops/scripts/check-capabilities.sh

# 查看使用统计
bash ops/scripts/capability-usage-stats.sh
```

📖 详细文档：[工具指南](../docs/TOOLS_GUIDE.md) | [快速参考](../docs/TOOLS_QUICK_REFERENCE.md)

---

## 📝 添加新能力资产

1. 在对应目录创建文件
2. 使用统一格式（见 `capabilities/TEMPLATE.md`）
3. 更新本索引文件
4. 提交 commit：`Add capability: <name>`

---

## 🗑️ 清理规则

**每月检查**：
- 3 个月未使用 → 标记为 deprecated
- 6 个月未使用 → 移到 archive/
- 明确过时 → 直接删除

记录删除原因到 `capabilities/CHANGELOG.md`

---

## 📈 能力演进历史

| Phase | 新增 | 累计 | 备注 |
|-------|------|------|------|
| 1-2 | 10 | 10 | 初始核心 |
| 3 | +5 | 15 | 生产就绪 |
| 4 | 0 | 15 | 优化期 |
| 5 | +20 | 35 | 任务 053 冲刺 |
| 5+ | +5 | 40 | 自主迭代 (任务 056-069) |

**增长率**：+300% (10 → 40)

**时间跨度**：8 天 (2026-06-05 → 2026-06-13)

**平均速度**：3.75 个能力/天

---

## 🎯 核心能力（最多被引用）

根据依赖分析 (任务 068)：

1. **problem-driven-development** (3 次引用)
2. **health-score-calculator** (3 次引用)
3. **unit-testing-framework** (2 次引用)
4. **quality-check-automation** (2 次引用)
5. **milestone-review-process** (2 次引用)

💡 这些是知识图谱的核心节点，优先维护和改进

---

## 🌍 社区示例

查看 [社区能力示例](../docs/examples/community-capabilities/) 了解真实使用场景：

1. API 开发工作流
2. 数据库迁移工作流
3. 代码审查检查清单
4. 测试策略
5. 文档编写工作流

---

_最后更新：2026-06-13 (任务 095)_  
_40/35+ 目标达成 (114%) 🎊_  
_系统健康度：9.5/10_  
_持续自主迭代中..._
