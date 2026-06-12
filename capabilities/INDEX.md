# 能力资产索引

**目的**：快速查找可复用的组织能力

**更新**：每次新增能力资产时同步

---

## 📊 统计

- Skills: 6
- Data: 3
- Knowledge: 4

**总计**：13 个能力资产 🎉

**本周新增**：13  
**本周复用**：8+

---

## 🔧 Skills（工作方法）

> 可重复执行的流程、检查清单、脚本

- [org-bootstrap](skill/org-bootstrap.md) - 从零搭建 AI 原生组织的完整流程
- [duty-check](skill/duty-check.md) - Duty Agent 定期巡检和 heartbeat 生成
- [problem-driven-development](skill/problem-driven-development.md) - 问题驱动开发：调试→修复→沉淀循环
- [launch-preparation](skill/launch-preparation.md) - 产品/项目外部发布准备流程
- [quality-check-automation](skill/quality-check-automation.md) - 自动化质量检查系统构建
- [readme-optimization](skill/readme-optimization.md) - 项目 README 优化（徽章、价值主张、CTA）

---

## 📚 Data（结构化事实）

> 样本、模板、价格表、竞品库

- [product-brief-template](data/product-brief-template.md) - 产品 brief 标准模板
- [contributing-guide-template](data/contributing-guide-template.md) - 开源项目贡献指南模板
- [roadmap-template](data/roadmap-template.md) - 产品路线图模板（透明度与灵活性平衡）

---

## 💡 Knowledge（经验案例）

> 决策依据、失败教训、成功案例

- [org-design-decisions](knowledge/org-design-decisions.md) - 从 org-blueprint 学到的组织设计决策
- [cross-platform-bash-compatibility](knowledge/cross-platform-bash-compatibility.md) - Bash 脚本跨平台兼容性（macOS/Linux）
- [competitor-analysis-ai-org-frameworks](knowledge/competitor-analysis-ai-org-frameworks.md) - AI 原生组织框架竞品分析
- [github-actions-best-practices](knowledge/github-actions-best-practices.md) - GitHub Actions CI/CD 最佳实践（质量门禁设计）

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
