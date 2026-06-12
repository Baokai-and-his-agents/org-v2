# Skill: Capability Analytics

**类型**：skill  
**创建**：2026-06-13  
**更新**：2026-06-13  
**复用次数**：1

## 🎯 用途

分析能力资产的使用情况和依赖关系，支持数据驱动的能力管理。

## 📥 输入

- 能力文件元数据（复用次数、依赖链接）

## 📤 输出

- 使用统计报告
- 依赖关系图谱
- 管理建议

## 🔄 工具

### 1. 使用统计 (capability-usage-stats.sh)

**功能**：分析能力的使用频率

```bash
bash ops/scripts/capability-usage-stats.sh
```

**输出**：
- Top 10 最常用能力
- 未使用能力列表（归档候选）
- 统计摘要（总数、已用、未用、平均）

**用途**：
- 识别热门能力 → 重点维护
- 识别冷门能力 → 考虑归档
- 评估能力组合价值

### 2. 依赖分析 (capability-dependencies.sh)

**功能**：可视化能力间的关联关系

```bash
bash ops/scripts/capability-dependencies.sh
```

**输出**：
- 有依赖的能力列表
- 最多被引用的能力（核心能力）
- 关系统计（总数、平均、连通性）

**用途**：
- 识别核心能力 → 优先改进
- 理解知识图谱结构
- 引导能力开发方向

## 💡 分析模式

### 模式 1：定期健康检查

**频率**：每月

```bash
# 1. 使用统计
bash ops/scripts/capability-usage-stats.sh > reports/usage-$(date +%Y%m).txt

# 2. 依赖分析
bash ops/scripts/capability-dependencies.sh > reports/deps-$(date +%Y%m).txt

# 3. 对比上月，识别趋势
diff reports/usage-202406.txt reports/usage-202405.txt
```

### 模式 2：归档决策

**触发**：3 个月未使用

```bash
# 查找未使用能力
bash ops/scripts/capability-usage-stats.sh | grep "never used"

# 对每个候选：
# 1. 检查是否有依赖
bash ops/scripts/capability-dependencies.sh | grep <capability-name>

# 2. 如果无依赖且确认过时 → 移到 archive/
# 3. 如果有依赖 → 先更新依赖方
```

### 模式 3：能力优先级

**基于数据决策**：

1. **高优先级**（高使用 + 高被引用）
   - 核心能力
   - 重点维护、优先改进

2. **中优先级**（高使用 OR 高被引用）
   - 重要但非核心
   - 保持稳定

3. **低优先级**（低使用 + 低被引用）
   - 外围能力
   - 按需维护

4. **归档候选**（0 使用 + 0 被引用 + 3 月+）
   - 过时或冗余
   - 考虑归档

## 🎓 最佳实践

### 1. 定期运行

每月第一周运行分析，追踪趋势。

### 2. 更新元数据

使用能力后，手动更新"复用次数"：

```markdown
**复用次数**：3  # 从 2 更新到 3
```

### 3. 建立链接

在"相关能力"部分使用 `[[name]]` 链接：

```markdown
## 🔗 相关能力

- [[problem-driven-development]] - 问题驱动开发
- [[health-score-calculator]] - 健康度计算
```

### 4. 数据驱动决策

不要凭感觉归档，看数据：
- 使用频率
- 依赖关系
- 时间衰减

## 📊 实际案例

**Phase 5+ 分析结果**（任务 067-068）：

**使用统计**：
- 39 个能力，0 个显示使用（元数据待更新）
- 洞察：需要追踪机制

**依赖分析**：
- 26 个依赖链接
- 9 个能力有明确依赖
- 核心能力：
  - problem-driven-development (3x)
  - health-score-calculator (3x)
  - unit-testing-framework (2x)

**决策影响**：
- 优先改进核心能力
- 确保核心能力稳定
- 外围能力按需维护

## ⚠️ 注意事项

### 元数据维护

**问题**：手动更新容易遗漏

**改进**：
```bash
# 未来可以自动化：扫描 git log 中的能力引用
git log --all --grep="capability:" | 
grep -oE "capability:[a-z-]+" | 
sort | uniq -c
```

### 依赖完整性

**问题**：可能有隐式依赖未记录

**改进**：
- 鼓励显式 `[[name]]` 链接
- 代码审查检查链接完整性

## 🔗 相关能力

- [[capability-export-tool]] - 导出能力
- [[capability-import-tool]] - 导入能力
- [[capability-search-tool]] - 搜索能力

---

_创建于任务 067-068_  
_能力管理工具链的分析层_
