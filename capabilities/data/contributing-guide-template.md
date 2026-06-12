# Data: Contributing Guide Template

**类型**：data  
**创建**：2026-06-12  
**更新**：2026-06-12  
**复用次数**：1（task 008）

---

## 🎯 用途

为开源项目创建贡献指南的结构化模板，涵盖代码贡献、文档改进、反馈机制、行为准则等核心要素。

---

## 📊 模板结构

### CONTRIBUTING.md

```markdown
# Contributing to [PROJECT_NAME]

## 🤝 贡献方式

### 1. 代码贡献
- 修复 Bug
- 实现新功能
- 性能优化

### 2. 文档改进
- 修正错误
- 补充示例
- 翻译文档

### 3. 反馈与建议
- Bug Report (GitHub Issues)
- Feature Request (GitHub Issues)
- 讨论 (GitHub Discussions)

## 🚀 提交代码

### 1. 准备环境
\`\`\`bash
git clone https://github.com/YOUR_ORG/YOUR_PROJECT.git
cd YOUR_PROJECT
git remote add upstream https://github.com/YOUR_ORG/YOUR_PROJECT.git
\`\`\`

### 2. 创建分支
\`\`\`bash
git checkout -b feature/your-feature-name
\`\`\`

### 3. 开发与测试
- 编写代码
- 添加测试
- 本地验证

### 4. 提交改动
\`\`\`bash
git commit -m "feat: add feature description"
git push origin feature/your-feature-name
\`\`\`

### 5. 发起 Pull Request
- 填写 PR 描述
- 等待 Review
- 根据反馈修改

## 📝 代码规范

### Commit Message 格式
\`<type>: <subject>\`

类型：
- feat: 新功能
- fix: Bug 修复
- docs: 文档更新
- refactor: 代码重构
- test: 测试相关
- chore: 构建/工具相关

### 代码风格
[项目特定的代码风格指南]

## 💬 交流渠道
- GitHub Issues (Bug/Feature)
- GitHub Discussions (讨论)
- [其他渠道]

## 🌟 行为准则
见 CODE_OF_CONDUCT.md
```

### CODE_OF_CONDUCT.md

```markdown
# Code of Conduct

## 我们的承诺
营造开放、友好、包容的环境。

## 我们的标准

**积极行为**：
- 友好和包容的语言
- 尊重不同观点
- 接受建设性批评
- 关注对社区最有利的事情

**不可接受行为**：
- 骚扰、侮辱
- 人身攻击
- 发布他人私人信息

## 执行
通过 [CONTACT] 报告违规行为。
```

---

## 📋 必需元素

### 贡献方式（必需）
- [ ] 代码贡献说明
- [ ] 文档改进指引
- [ ] 反馈机制说明

### 代码流程（必需）
- [ ] Fork & Clone 步骤
- [ ] 分支创建规范
- [ ] 提交流程说明
- [ ] PR 提交指引

### 规范（必需）
- [ ] Commit Message 格式
- [ ] 代码风格指南
- [ ] 测试要求（如适用）

### 交流渠道（必需）
- [ ] Issue 使用说明
- [ ] Discussion 使用说明
- [ ] 其他渠道（可选）

### 行为准则（推荐）
- [ ] CODE_OF_CONDUCT.md
- [ ] 或在 CONTRIBUTING.md 中简述

---

## 📝 使用示例

### 成功案例：org-v2 贡献指南

**场景**：为 org-v2 创建贡献指南

**定制**：
1. 贡献方式：4 种（代码/文档/反馈/分享）
2. 代码流程：标准 Fork-Branch-PR
3. 规范：Bash/Markdown/Commit Message
4. 渠道：Issues + Discussions
5. 行为准则：改编自 Contributor Covenant

**输出**：
- CONTRIBUTING.md（200+ 行）
- CODE_OF_CONDUCT.md（简化版）

**时间**：20 分钟

**效果**：
- 清晰的贡献路径
- 降低参与门槛
- 规范化协作

---

## 💡 定制建议

### 根据项目类型调整

**库/框架项目**：
- 强调测试要求
- API 兼容性说明
- 性能测试指引

**应用项目**：
- UI/UX 设计规范
- 用户体验测试
- 国际化贡献

**文档项目**：
- 写作风格指南
- 翻译流程
- 审校标准

### 根据团队规模调整

**小团队（1-5 人）**：
- 简化流程
- 快速 Review
- 非正式沟通

**中团队（5-20 人）**：
- 标准流程
- 分类 Review
- 结构化沟通

**大团队（20+ 人）**：
- 严格流程
- 分层 Review
- 正式治理

---

## 🔗 相关能力

- skill/launch-preparation（外部发布）
- data/issue-templates（反馈机制）

---

## 📊 使用记录

| 日期 | 项目 | 结果 | 时间 |
|------|------|------|------|
| 2026-06-12 | org-v2 | CONTRIBUTING + CoC | 20 分钟 |

---

## 🎓 关键要点

1. **清晰 > 完整** - 少而精胜过多而乱
2. **欢迎 > 严格** - 友好的语气鼓励参与
3. **示例 > 规则** - 展示怎么做胜过说什么
4. **渐进 > 一次性** - 先简单版本，逐步完善

---

_此模板从 task 008 提取，已在 org-v2 项目验证有效_
