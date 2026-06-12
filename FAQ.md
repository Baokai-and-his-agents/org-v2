# 常见问题 (FAQ)

快速解答常见疑问。

---

## 🚀 快速开始

### Q: org-v2 是什么？

A: org-v2 是一个轻量级的知识管理和任务执行系统，帮助个人和小团队：
- 系统化管理任务
- 持续沉淀可复用能力
- 自动化质量保障
- 追踪进度和健康度

---

### Q: 适合我吗？

A: 如果你是以下角色之一，org-v2 很适合你：
- **个人开发者**：管理多个项目，希望复用经验
- **小团队**：2-5 人，需要知识不流失
- **AI 研究者**：实验多，需要追踪结果
- **开源维护者**：贡献者流动，知识需要留存
- **产品开发**：快速迭代，需要决策追踪

详见 [使用案例](docs/use-cases/README.md)

---

### Q: 需要多少时间上手？

A: 
- **快速开始**：15 分钟（阅读 QUICKSTART.md）
- **熟练使用**：1-2 周
- **深度定制**：1-2 个月

---

### Q: 和其他工具（Notion/Obsidian/Jira）有什么区别？

A: org-v2 的独特之处：
1. **强制沉淀机制**：每个任务后评估能否复用
2. **极简结构**：3 层（control/ops/capabilities）就够
3. **完整工具链**：导出/导入/搜索/健康度
4. **Git 原生**：版本控制、协作友好
5. **Agent 就绪**：为 AI 时代设计

**vs Notion**：更轻量，Git 友好，开发者优先  
**vs Obsidian**：更结构化，强制沉淀，任务导向  
**vs Jira**：更简单，知识沉淀，个人/小团队优先

---

## 📚 核心概念

### Q: 什么是"能力"（Capability）？

A: 能力是可复用的知识单元，分 4 类：
- **skill**：工作方法（如何做）
- **data**：模板清单（直接用）
- **knowledge**：经验教训（为什么）
- **system**：系统设计（架构）

每个能力都是独立的 Markdown 文件，包含用途、输入、输出、步骤等标准化信息。

---

### Q: 为什么要"强制沉淀"？

A: 实践证明：
- **可选沉淀**：实际沉淀率 ~14%
- **强制沉淀**：实际沉淀率 ~70%（5x 差距！）

强制沉淀 = 每个任务后问"这个能复用吗？" → 形成习惯 → 复利增长

---

### Q: NOW.md 是什么？

A: NOW.md 是当前工作台，显示：
- 当前进行的任务
- Phase 进度
- 里程碑追踪
- 系统健康度
- 下一步计划

类似"仪表盘"，随时知道自己在哪里。

---

## 🛠️ 实践问题

### Q: 第一个任务应该做什么？

A: 建议顺序：
1. Fork/Clone org-v2
2. 阅读 QUICKSTART.md
3. 创建第一个任务（ops/tasks/001-xxx.md）
4. 完成后沉淀为能力
5. 运行质量检查：`bash ops/scripts/check-capabilities.sh`

---

### Q: 如何决定什么值得沉淀？

A: 问自己：
- ✅ 这个流程会再用吗？（skill）
- ✅ 这个模板能复用吗？（data）
- ✅ 这个决策有参考价值吗？（knowledge）
- ✅ 这个设计能指导未来吗？（system）

如果回答"是"→ 沉淀；如果"不确定"→ 先沉淀（删除容易，遗忘难找回）

---

### Q: 任务太多，如何管理优先级？

A: 使用 NOW.md 的优先级策略：
1. **阻塞任务**：影响其他任务的
2. **高价值任务**：沉淀率高、影响大的
3. **快速任务**：30 分钟内能完成的

每天选 2-3 个任务执行即可。

---

### Q: 质量检查失败怎么办？

A: 
1. 查看具体错误：`bash ops/scripts/check-capabilities.sh`
2. 对照模板补全字段
3. 重新运行确认通过
4. 提交代码

常见问题：缺少类型、创建日期、用途等必要字段。

详见 [故障排查指南](docs/TROUBLESHOOTING.md)

---

### Q: 能力太多，怎么快速找到需要的？

A: 使用搜索工具：
```bash
# 基础搜索
bash ops/scripts/search-capability.sh 关键词

# 详细模式（显示匹配内容）
bash ops/scripts/search-capability.sh -v 关键词

# 只搜索 skills
bash ops/scripts/search-capability.sh -t skill 关键词
```

---

## 🤝 协作问题

### Q: 团队如何使用 org-v2？

A: 两种模式：
1. **共享仓库**：所有人push同一仓库，PR review
2. **能力共享**：各自独立仓库，定期导出/导入能力

建议小团队（<5人）用模式1，大团队用模式2。

---

### Q: 如何共享能力给其他项目？

A: 使用导出/导入工具：
```bash
# 项目 A 导出
cd project-a
bash ops/scripts/export-capability.sh -a -o caps.yaml

# 项目 B 导入
cd project-b
bash ops/scripts/import-capability.sh -f caps.yaml
```

---

### Q: 能否和 GitHub Issues/Projects 集成？

A: 可以！org-v2 不替代 GitHub，而是补充：
- **GitHub Issues**：公开讨论、Bug 追踪
- **org-v2 tasks**：个人执行、知识沉淀

建议：Issue → task → 完成后沉淀 → 关闭 Issue

---

## 🔧 技术问题

### Q: 支持哪些平台？

A: 
- ✅ macOS（测试通过）
- ✅ Linux（测试通过）
- ⚠️ Windows（WSL 可用，原生未测试）

---

### Q: 需要什么技术栈？

A: 最小依赖：
- Git
- Bash
- 文本编辑器

可选：
- yq（YAML 处理，提升导入/导出体验）
- GitHub CLI（gh，用于 PR/Issue 操作）

---

### Q: 可以用其他语言（Python/Node.js）重写吗？

A: 可以！核心是**理念**，不是技术：
- 强制沉淀机制
- 3 层结构
- 标准化能力格式

欢迎贡献其他语言实现！

---

### Q: 如何备份数据？

A: org-v2 全部基于 Git：
```bash
# 本地备份
cp -r org-v2 org-v2-backup

# 远程备份
git push origin main

# 额外备份（能力）
bash ops/scripts/export-capability.sh -a -o backup.yaml
```

---

## 📊 度量问题

### Q: 如何查看系统健康度？

A: 运行健康度评分脚本：
```bash
bash ops/scripts/calculate-health-score.sh
```

8 个维度，总分 0-10，建议保持 ≥ 8.0。

---

### Q: 如何生成周报？

A: 使用周报生成器：
```bash
# 默认 7 天
bash ops/scripts/generate-weekly-report.sh

# 指定天数和输出
bash ops/scripts/generate-weekly-report.sh -d 14 -o report.md
```

自动收集 Git 统计、任务完成、能力数量等。

---

### Q: 沉淀率多少算健康？

A: 建议目标：
- **70%+**：优秀（持续复利）
- **50-70%**：良好（有改进空间）
- **<50%**：需要改进（检查流程）

org-v2 在 Phase 5 达到 91%，证明机制有效。

---

## 🚀 进阶问题

### Q: 如何定制健康度维度？

A: 编辑 `ops/scripts/calculate-health-score.sh`，添加新的评分函数。

详见 [进阶教程](docs/ADVANCED.md#4-自定义健康度维度)

---

### Q: 如何自动化日常检查？

A: 使用 cron 定时任务：
```bash
# 每天 9:00 运行巡检
0 9 * * * cd /path/to/org-v2 && bash ops/scripts/duty-check.sh

# 每周一 9:00 生成周报
0 9 * * 1 cd /path/to/org-v2 && bash ops/scripts/generate-weekly-report.sh
```

---

### Q: 能否与 AI Agent 协作？

A: 完全可以！org-v2 为 AI 时代设计：
- 标准化能力格式（易于解析）
- 导出/导入机制（跨 Agent 共享）
- 结构化任务（Agent 可理解）

未来会增加更多 Agent 协作功能。

---

## 💬 社区问题

### Q: 如何贡献？

A: 欢迎贡献！
1. Fork 仓库
2. 创建分支
3. 提交 PR
4. 等待 Review

详见 [CONTRIBUTING.md](CONTRIBUTING.md)

---

### Q: 如何获取帮助？

A: 优先级：
1. 搜索此 FAQ
2. 查看 [TROUBLESHOOTING.md](docs/TROUBLESHOOTING.md)
3. 搜索 [GitHub Issues](https://github.com/Baokai-and-his-agents/org-v2/issues)
4. 创建新 Issue

---

### Q: 有社区讨论群吗？

A: 
- GitHub Discussions（计划启用）
- Twitter: @org_v2（计划创建）

---

### Q: 如何分享我的使用案例？

A: 
1. 在 `docs/use-cases/` 创建你的案例
2. 提交 PR
3. 或在 Discussions 分享

我们很期待听到你的故事！

---

## 🤔 还有问题？

如果这里没有回答你的问题：
1. 搜索 [文档](docs/)
2. 查看 [Issues](https://github.com/Baokai-and-his-agents/org-v2/issues)
3. 创建新 Issue
4. 或邮件联系维护者

---

_最后更新：2026-06-13_  
_持续补充中..._
