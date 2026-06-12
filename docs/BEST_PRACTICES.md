# 最佳实践指南

基于 30+ 任务实践的经验沉淀。

---

## 🎯 核心原则

### 1. 强制沉淀 > 可选沉淀

**为什么**：
- 可选 = 很少做
- 强制 = 形成习惯
- 习惯 = 复利

**如何做**：
- 每个任务完成后评估可复用性
- 阻塞性质量检查（不通过不能继续）
- 沉淀模板降低心理门槛

---

### 2. 极简结构 > 复杂分类

**为什么**：
- 3 层足够（control/ops/capabilities）
- 过度分类 = 维护成本
- 简单 = 可持续

**如何做**：
- 不要创建太多子目录
- 扁平优于嵌套
- 优先命名清晰而非层级深

---

### 3. 自动化优先

**为什么**：
- 手动 = 容易忘记
- 自动 = 持续执行
- 投入 4.5h 持续回报

**如何做**：
- 能自动化的都自动化
- CI 运行质量检查
- 脚本处理重复工作

---

## 📋 任务管理

### 规划先于执行

**错误做法**：
```
想到什么做什么
遇到问题临时决定
没有清晰的完成标准
```

**正确做法**：
```
1. 创建任务文件（ops/tasks/xxx.md）
2. 明确目标、背景、计划
3. 定义验收标准
4. 执行并记录
5. 完成后评估能否复用
```

---

### 任务大小控制

**建议**：
- 单个任务：30-60 分钟
- 太大：拆分成多个子任务
- 太小：合并为一个任务

**拆分示例**：
```
❌ "完善文档"（太大）

✅ 拆分为：
  - "创建 FAQ 前 10 个问题"
  - "完善 README 示例"
  - "增加 QUICKSTART 截图"
```

---

## 💎 能力沉淀

### 什么值得沉淀

**Yes（沉淀）**：
- ✅ 通用的工作流程（skill）
- ✅ 可复用的模板（data）
- ✅ 重要的决策（knowledge）
- ✅ 系统设计（system）

**No（不沉淀）**：
- ❌ 一次性的报告
- ❌ 临时的草稿
- ❌ 项目特定的代码

---

### 沉淀质量标准

**必备元素**：
```markdown
# [类型]: [名称]

**类型**：skill/data/knowledge/system
**创建**：YYYY-MM-DD
**更新**：YYYY-MM-DD
**复用次数**：N

## 🎯 用途
[清晰的使用场景]

## 📥 输入
[需要什么]

## 📤 输出
[产生什么]

## 🔄 步骤
[如何执行]

## 💡 注意事项
[坑点、限制]
```

---

### 沉淀时机

**最佳时机**：任务完成后立即沉淀

**为什么**：
- 记忆最清晰
- 上下文完整
- 动力最强

**流程**：
```
完成任务 
  → 评估可复用性
  → 创建能力文件
  → 运行质量检查
  → 提交 Git
```

---

## 🔄 日常流程

### 每日开始

```bash
# 1. 查看当前状态
cat NOW.md

# 2. 选择今天的任务
# 优先级：阻塞 > 高价值 > 简单快速

# 3. 创建任务文件（如果没有）
vi ops/tasks/XXX-task-name.md

# 4. 开始工作
```

---

### 每日结束

```bash
# 1. 提交代码
git add -A
git commit -m "Complete task XXX: [description]"
git push

# 2. 运行巡检
bash ops/scripts/duty-check.sh

# 3. 更新 NOW.md（如有必要）

# 4. 评估并沉淀能力
```

---

### 每周回顾

```bash
# 1. 生成周报
bash ops/scripts/generate-weekly-report.sh -o weekly-report.md

# 2. 计算健康度
bash ops/scripts/calculate-health-score.sh

# 3. 识别改进方向
# 查看健康度报告的建议

# 4. 规划下周任务
```

---

## 🛠️ 工具使用

### 能力导出/导入

**导出能力分享**：
```bash
# 导出单个
bash ops/scripts/export-capability.sh \
  -t skill -n problem-driven-development \
  -o my-skill.yaml

# 导出所有 skills
bash ops/scripts/export-capability.sh \
  -c skill -o all-skills.yaml
```

**导入他人能力**：
```bash
# 预览
bash ops/scripts/import-capability.sh \
  -f capability.yaml --dry-run

# 实际导入（跳过已存在）
bash ops/scripts/import-capability.sh \
  -f capability.yaml --skip-existing
```

---

### 能力搜索

```bash
# 基础搜索
bash ops/scripts/search-capability.sh error

# 详细模式（显示匹配内容）
bash ops/scripts/search-capability.sh -v "problem driven"

# 只搜索 skills
bash ops/scripts/search-capability.sh -t skill debugging
```

---

## ⚠️ 常见陷阱

### 1. 过度设计

**陷阱**：
- 创建太多层级
- 过早优化
- 复杂的分类系统

**解决**：
- 从简单开始
- 需要时再扩展
- 优先可用性

---

### 2. 忽视质量检查

**陷阱**：
- 跳过检查脚本
- 认为"后面再改"
- 质量债务累积

**解决**：
- 强制运行检查
- CI 自动执行
- 不通过不合并

---

### 3. 沉淀太少或太多

**太少**：
- 只完成任务不沉淀
- 知识流失
- 无复利效应

**太多**：
- 什么都沉淀
- 维护成本高
- 难以查找

**平衡**：
- 70% 沉淀率是目标
- 专注可复用的
- 定期清理过时的

---

### 4. 孤立工作

**陷阱**：
- 不分享能力
- 不学习他人
- 重复造轮子

**解决**：
- 使用社区能力库
- 贡献自己的能力
- 参与 Discussions

---

## 📊 度量指标

### 跟踪这些指标

1. **沉淀率**：能力数 / 任务数（目标 70%+）
2. **复用次数**：平均每个能力被用几次
3. **健康度**：系统整体评分（目标 8.0+）
4. **任务效率**：平均每任务用时（目标持续下降）

### 如何查看

```bash
# 健康度
bash ops/scripts/calculate-health-score.sh

# 周报（包含任务统计）
bash ops/scripts/generate-weekly-report.sh

# 能力统计
find capabilities -name "*.md" | wc -l
```

---

## 🎓 进阶技巧

### 能力版本管理

使用 Git 标签标记重要版本：
```bash
git tag -a capability-v1.0 -m "First stable capability set"
git push origin capability-v1.0
```

---

### 跨项目能力共享

```bash
# 项目 A 导出
cd project-a
bash ops/scripts/export-capability.sh -a -o ~/shared-caps.yaml

# 项目 B 导入
cd project-b
bash ops/scripts/import-capability.sh -f ~/shared-caps.yaml
```

---

### 自定义健康度维度

编辑 `ops/scripts/calculate-health-score.sh`，添加你关心的维度。

---

## 💬 寻求帮助

**文档没解决？**
1. 搜索 Issues
2. 查看 Discussions
3. 创建新 Issue
4. 查看 FAQ.md

**想贡献改进？**
1. Fork 仓库
2. 创建分支
3. 提交 PR
4. 等待 Review

---

_最后更新：2026-06-13_  
_基于：30+ 任务实践经验_
