# Contributing to org-v2

感谢你考虑为 org-v2 做贡献！

org-v2 是一个 AI 原生组织框架，由社区驱动。我们欢迎各种形式的贡献。

---

## ⚡ 快速开始

**第一次贡献？** 5 分钟快速上手：

### 方式 1：文档改进（最简单）

1. 在 GitHub 上找到要改的文档
2. 点击右上角 ✏️（编辑）按钮
3. 直接修改，GitHub 会自动 fork 和创建 PR
4. 填写简短说明，提交！

**适合**：修正错别字、补充说明、优化表达

### 方式 2：报告问题

发现 Bug 或有新想法？

1. 访问 [Issues](https://github.com/Baokai-and-his-agents/org-v2/issues)
2. 点击 "New Issue"
3. 选择模板（Bug Report / Feature Request）
4. 填写详细信息，提交！

**提示**：详细的描述 = 更快的解决

### 方式 3：分享经验

用过 org-v2？分享你的经验！

1. 访问 [Discussions](https://github.com/Baokai-and-his-agents/org-v2/discussions)
2. 选择 "Show and tell" 分类
3. 写下你的使用心得、案例、教程
4. 帮助其他用户！

---

## 🤝 贡献方式

### 1. 代码贡献

**适合**：
- 修复 Bug
- 实现新功能
- 改进脚本性能
- 增强自动化

**流程**：见下方"提交代码"部分

---

### 2. 文档改进

**适合**：
- 修正错误
- 补充示例
- 优化表达
- 翻译文档

**流程**：与代码贡献相同

---

### 3. 反馈与建议

**适合**：
- 报告 Bug
- 提出 Feature
- 分享使用经验
- 提问求助

**方式**：
- Bug: [Issue](https://github.com/Baokai-and-his-agents/org-v2/issues) (使用 bug_report 模板)
- Feature: [Issue](https://github.com/Baokai-and-his-agents/org-v2/issues) (使用 feature_request 模板)
- 讨论: [Discussions](https://github.com/Baokai-and-his-agents/org-v2/discussions)

---

### 4. 分享经验

**适合**：
- 写使用教程
- 分享实践案例
- 录制视频演示
- 在社交媒体推广

**方式**：
- 在 Discussions 分享
- 发 PR 添加到 `docs/examples/`
- 标记 `#orgv2` 在 Twitter

---

## 🚀 提交代码

### 1. 准备环境

```bash
# Fork 仓库到你的 GitHub 账号

# Clone 你的 fork
git clone https://github.com/YOUR_USERNAME/org-v2.git
cd org-v2

# 添加上游仓库
git remote add upstream https://github.com/Baokai-and-his-agents/org-v2.git
```

### 2. 创建分支

```bash
# 同步最新代码
git fetch upstream
git checkout main
git merge upstream/main

# 创建功能分支
git checkout -b feature/your-feature-name
# 或 fix/your-bug-fix
```

分支命名规范：
- `feature/` - 新功能
- `fix/` - Bug 修复
- `docs/` - 文档更新
- `refactor/` - 代码重构

### 3. 开发与测试

**编写代码**：
- 遵循代码规范（见下方）
- 添加注释
- 保持简洁

**测试**：
```bash
# 测试脚本
bash ops/scripts/your-script.sh

# 检查能力资产质量
bash ops/scripts/check-capabilities.sh

# 运行结构检查（如果有）
bash ops/scripts/check-structure.sh
```

### 4. 提交改动

```bash
# 添加文件
git add path/to/changed/files

# 提交（遵循 Commit Message 规范）
git commit -m "feat: add new feature description"

# 推送到你的 fork
git push origin feature/your-feature-name
```

### 5. 发起 Pull Request

1. 访问你的 fork 页面
2. 点击 "Compare & pull request"
3. 填写 PR 描述（见模板）
4. 提交 PR

**PR 描述应包括**：
- 改动内容
- 为什么需要这个改动
- 如何测试
- 相关 Issue（如有）

---

## 📝 代码规范

### Bash 脚本

```bash
#!/bin/bash
# 脚本说明（一句话）
# 详细描述用途和使用方法

set -e  # 遇到错误立即退出

# 函数使用小写 + 下划线
function check_something() {
    local var_name="value"
    # 实现
}

# 变量使用大写
GLOBAL_VAR="value"

# 输出使用 emoji 增强可读性
echo "✅ Success message"
echo "⚠️ Warning message"
echo "❌ Error message"
```

### Markdown 文档

- 使用标题层级（H1 → H2 → H3）
- 代码块标记语言（```bash, ```json）
- 链接使用相对路径
- 保持简洁清晰

### Commit Message

格式：`<type>: <subject>`

**类型**：
- `feat`: 新功能
- `fix`: Bug 修复
- `docs`: 文档更新
- `refactor`: 代码重构
- `test`: 测试相关
- `chore`: 构建/工具相关

**示例**：
```
feat: add capability quality check script
fix: resolve cross-platform sed compatibility
docs: update FAQ with 10 new questions
refactor: simplify duty-check.sh logic
```

**规则**：
- 主题 ≤ 50 字符
- 使用现在时（"add" not "added"）
- 首字母小写
- 结尾不加句号

---

## 🔍 Code Review

PR 提交后：

1. **自动检查**（如果配置）
   - 结构检查
   - 质量检查

2. **人工 Review**
   - 代码质量
   - 是否符合规范
   - 是否有测试

3. **反馈与修改**
   - 维护者会留下评论
   - 根据反馈修改代码
   - 推送新提交会自动更新 PR

4. **合并**
   - Review 通过后合并
   - 你会收到通知

**Review 时间**：
- 通常 1-3 天
- 简单 PR 可能更快
- 复杂 PR 可能需要讨论

---

## 🎯 贡献优先级

当前最需要的贡献：

**高优先级**：
- 使用反馈（最重要！）
- Bug 报告
- 文档改进
- 示例项目

**中优先级**：
- 新功能实现
- 性能优化
- 测试覆盖

**低优先级**：
- 大规模重构
- 架构改动
- 企业功能

如果不确定，先开 Issue 讨论。

---

## 💬 交流渠道

- **Bug/Feature**: [GitHub Issues](https://github.com/Baokai-and-his-agents/org-v2/issues)
- **讨论**: [GitHub Discussions](https://github.com/Baokai-and-his-agents/org-v2/discussions)
- **实时交流**: Twitter `#orgv2`（计划中）

---

## 🌟 行为准则

我们致力于营造友好、包容、专业的社区环境。

**我们期望**：
- 尊重不同观点
- 建设性反馈
- 专注问题解决
- 友好互助

**不可接受**：
- 人身攻击
- 骚扰行为
- 歧视言论
- 恶意破坏

详见 [CODE_OF_CONDUCT.md](CODE_OF_CONDUCT.md)

---

## 🙏 致谢

每个贡献都很重要，无论大小。

贡献者名单：见 [CONTRIBUTORS.md](CONTRIBUTORS.md)（待创建）

---

## ❓ 常见问题

### Q1: 我不会编程，能贡献吗？

**A**: 当然可以！你可以：
- 改进文档（修正错误、补充说明）
- 报告问题（描述你遇到的 Bug）
- 分享经验（写使用教程、案例）
- 提供反馈（告诉我们哪里不好用）

这些都是非常有价值的贡献！

### Q2: 我的 PR 多久会被 review？

**A**: 通常 1-3 天内会有初步反馈。

- 简单 PR（文档、小 fix）：可能几小时内
- 复杂 PR（新功能、大改动）：可能需要更多讨论

如果超过 3 天没有回应，可以礼貌地 ping 一下。

### Q3: 我应该先开 Issue 还是直接提 PR？

**A**: 取决于改动大小：

- **小改动**（文档错误、明显的 bug）→ 直接提 PR
- **大改动**（新功能、重构）→ 先开 Issue 讨论

这样可以避免白费功夫。

### Q4: Commit Message 写错了怎么办？

**A**: 如果还没 push：
```bash
git commit --amend -m "correct: message"
```

如果已经 push 了也没关系，review 时可以 squash commits。

### Q5: 我的 PR 被要求修改，怎么办？

**A**: 这很正常！步骤：

1. 在本地修改代码
2. 提交新的 commit
3. Push 到同一个分支
4. PR 会自动更新

不需要关闭重开 PR。

### Q6: 可以一次提交多个不相关的改动吗？

**A**: 最好不要。建议：

- 一个 PR 解决一个问题
- 多个问题 = 多个 PR
- 这样 review 更快，合并更容易

### Q7: 我想贡献但不知道做什么？

**A**: 几个建议：

1. 看 [Issues](https://github.com/Baokai-and-his-agents/org-v2/issues) 中标记 `good first issue` 的
2. 完善现有文档（补充示例、优化表达）
3. 写使用教程（分享你的实践）
4. 试用系统并报告问题

### Q8: 贡献会被记录吗？

**A**: 会！

- GitHub 自动记录所有贡献者
- 我们会维护 CONTRIBUTORS.md
- 重要贡献会在 CHANGELOG 中提及

你的名字会出现在贡献者列表中。

---

## ❓ 更多问题？

如有疑问：
1. 先查看 [FAQ](FAQ.md)
2. 搜索 [Issues](https://github.com/Baokai-and-his-agents/org-v2/issues)
3. 提新 Issue（使用 question 模板）
4. 在 [Discussions](https://github.com/Baokai-and-his-agents/org-v2/discussions) 提问

---

**感谢你的贡献！** 🎉

你的参与让 org-v2 变得更好。
