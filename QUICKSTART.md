# 快速开始：10 分钟搭建你的 AI 原生组织

**目标**：10 分钟内建立一个可运行的 AI 协作系统

**适合人群**：
- 熟悉 Git 和命令行
- 想用 AI agents 提升效率
- 一人公司或小团队（2-5 人）

---

## 📦 你将获得

- ✅ 完整的组织结构（3 层，极简）
- ✅ 单一工作台入口（NOW.md）
- ✅ 2 个可用 skills（org-bootstrap, duty-check）
- ✅ 自动化脚本（周报、巡检）
- ✅ CI 检查配置

---

## ⚡ 快速开始

### Step 1：克隆仓库（1 分钟）

```bash
# 克隆模板
git clone https://github.com/Baokai-and-his-agents/org-v2.git my-org
cd my-org

# 重新初始化为你的仓库
rm -rf .git
git init
git add -A
git commit -m "Initial commit: org-v2 bootstrap"
```

### Step 2：配置基本信息（2 分钟）

编辑 `control/owner.md`：
```markdown
# 修改这些部分
**Owner**：[你的名字]

## 🎯 当前方向
[填写你的组织目标]
```

编辑 `NOW.md`：
```markdown
**Owner**：[你的名字]

## 🎯 本周目标
[填写你本周的目标]
```

### Step 3：创建第一个任务（3 分钟）

```bash
# 复制任务模板
cp ops/tasks/001-bootstrap-validation.md ops/tasks/001-my-first-task.md
```

编辑 `ops/tasks/001-my-first-task.md`：
```markdown
# 第一个任务：[你的任务标题]

**目标**：[一句话说明目标]

## 📋 任务清单
- [ ] 第一步
- [ ] 第二步
- [ ] 第三步

## 💡 可沉淀的能力
[思考：这个任务结束后能否形成可复用能力？]
```

更新 `NOW.md`：
```markdown
## 📋 活跃任务 (1)
- [001-my-first-task](ops/tasks/001-my-first-task.md) - [任务标题]
```

### Step 4：运行 Duty 巡检（1 分钟）

```bash
bash ops/scripts/duty-check.sh
```

你会看到第一份 heartbeat 记录！

### Step 5：提交到 GitHub（3 分钟）

```bash
# 创建 GitHub 仓库（需要 gh CLI）
gh repo create my-org-name --public --source=. --remote=origin --push

# 或者手动推送到已有仓库
git remote add origin https://github.com/your-username/your-repo.git
git push -u origin main
```

---

## ✅ 验证成功

检查这些是否工作：

1. **打开 NOW.md** - 能看到你的任务？✅
2. **运行 duty-check** - 生成了 heartbeat？✅
3. **查看 capabilities/INDEX.md** - 能看到能力资产？✅
4. **访问 GitHub** - Actions 正在运行？✅

全部 ✅ = 成功！🎉

---

## 🎓 下一步

### 完成第一个任务（10-30 分钟）

1. 按照任务清单工作
2. 完成后，问自己：**这次工作能否复用？**
3. 如果能 → 创建 skill/data/knowledge
4. 更新 `capabilities/INDEX.md`

### 沉淀第一个能力（5-15 分钟）

**Skill 示例**：
```bash
cp capabilities/TEMPLATE.md capabilities/skill/my-first-skill.md
```

填写：
- 🎯 用途（一句话）
- 📥 输入（需要什么）
- 📤 输出（产出什么）
- 🔄 使用流程（步骤）
- ✅ 检查清单

**别忘了**更新 `capabilities/INDEX.md`！

### 生成第一份周报（< 1 分钟）

```bash
bash ops/scripts/weekly-report.sh
```

---

## 📚 核心概念（3 分钟阅读）

### 1. NOW.md = 单一入口
- 所有人打开仓库，10 秒知道"现在做什么"
- 活跃任务、阻塞事项、本周进度都在这里

### 2. 3 层结构
- `control/` - Owner 控制（战略、权限）
- `ops/` - 日常运营（任务、日志、巡检）
- `capabilities/` - 能力资产（skill/data/knowledge）

### 3. 能力沉淀循环
```
任务 → 评估"能否复用" → 沉淀 skill/data/knowledge → 下次复用
```

**目标沉淀率**：30-50%（每 2 个任务至少 1 个形成能力）

### 4. 强制度量
- 周报自动生成（每周五）
- Duty 巡检（每日 1 次）
- 沉淀率追踪

---

## 💡 常见问题

### Q: 我的任务很特殊，不适合沉淀？
A: 问自己：
- 会重复出现吗？（≥2 次）→ 沉淀为 skill
- 是结构化事实吗？（价格、模板）→ 沉淀为 data
- 是经验教训吗？（决策、失败）→ 沉淀为 knowledge

不是所有任务都需要沉淀，但目标是 30-50%。

### Q: skill 应该多详细？
A: 够用就好：
- ✅ 有明确输入输出
- ✅ 有使用流程
- ✅ 有检查清单
- ✅ 有至少 1 个示例

不需要写成 200 页手册。

### Q: Duty Agent 应该多久巡检一次？
A: 阶段 1（当前）：每日手动触发 1 次  
阶段 2（3 个月后）：GitHub Actions 自动每日触发

### Q: 产品代码应该放哪里？
A: **不要放总部仓库！**
- 总部：product brief（1-2 页）+ 状态
- 产品：独立仓库（代码、部署、详细文档）

---

## 🎯 第一周目标

- [ ] 完成 3 个任务
- [ ] 沉淀 2 个能力
- [ ] Duty 巡检 5 次
- [ ] 生成 1 份周报
- [ ] 沉淀率 ≥ 30%

**达成 = 系统证明可用！**

---

## 📖 深入阅读

- [control/owner.md](control/owner.md) - Owner 控制面板
- [ops/agent-protocol.md](ops/agent-protocol.md) - Agent 工作协议
- [capabilities/skill/org-bootstrap.md](capabilities/skill/org-bootstrap.md) - 完整示例
- [产品 Brief](products/briefs/ai-native-org-toolkit.md) - 产品方向

---

## 🆘 需要帮助？

- 查看 [示例任务](ops/tasks/)
- 查看 [示例 skill](capabilities/skill/)
- 提交 GitHub Issue
- 阅读 [设计决策](capabilities/knowledge/org-design-decisions.md)

---

## 🎉 欢迎来到 AI 原生组织！

记住核心原则：
1. **极简优于完美** - 能跑就行
2. **可执行优于可设计** - 先做再优化
3. **度量驱动改进** - 数据说话
4. **强制能力沉淀** - 这是护城河

祝你建立一个高效的 AI 协作系统！🚀

---

_需要更新本指南？欢迎提 PR_
