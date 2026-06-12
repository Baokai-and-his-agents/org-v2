# Agent 协作模式

未来的 org-v2 将支持多 agent 协作。本文档探索可能的协作模式。

---

## 🎯 为什么需要多 Agent

### 当前限制（单 Agent + 人类）

- 一次只能做一件事
- 无法并行处理
- 专业化程度有限
- 规模扩展受限

### 多 Agent 潜力

- 并行任务处理
- 角色专业化
- 能力继承与组合
- 规模化协作

---

## 🤝 协作模式

### 1. 串行协作（Sequential）

```
Agent A → 完成任务 1 → 交接 → Agent B → 完成任务 2
```

**适用场景**：
- 任务有明确依赖顺序
- 需要不同专长
- 前一步产出是后一步输入

**示例**：
```
开发 Agent → 编写代码 → 
测试 Agent → 编写测试 → 
文档 Agent → 编写文档
```

**优点**：
- 简单清晰
- 职责分明
- 易于追踪

**缺点**：
- 总时间 = 各阶段时间之和
- 阻塞等待
- 无并行加速

---

### 2. 并行协作（Parallel）

```
任务拆分
  ├─ Agent A → 子任务 1
  ├─ Agent B → 子任务 2
  └─ Agent C → 子任务 3
         ↓
      结果合并
```

**适用场景**：
- 任务可独立拆分
- 子任务无依赖
- 追求速度

**示例**：
```
任务：审查 100 个文件
  ├─ Agent 1: 文件 1-25
  ├─ Agent 2: 文件 26-50
  ├─ Agent 3: 文件 51-75
  └─ Agent 4: 文件 76-100
```

**优点**：
- 大幅加速
- 充分利用资源
- 适合批量任务

**缺点**：
- 需要任务可拆分
- 结果合并复杂
- 协调成本高

---

### 3. 审核协作（Review）

```
Agent A → 提交工作成果 → Agent B → 审核 → 通过/拒绝
                                      ↓
                                  反馈改进
```

**适用场景**：
- 质量要求高
- 需要多重验证
- 风险决策

**示例**：
```
开发 Agent → 编写代码 →
审核 Agent → 检查质量 →
  - 代码规范
  - 测试覆盖
  - 安全隐患
```

**优点**：
- 质量保障
- 减少错误
- 持续改进

**缺点**：
- 额外时间成本
- 可能产生争议
- 需要冲突解决机制

---

### 4. 辅助协作（Assistant）

```
主 Agent（决策者）
    ↓ 请求帮助
辅助 Agent（提供支持）
    ↓ 返回结果
主 Agent（继续工作）
```

**适用场景**：
- 需要专业知识
- 临时查询
- 快速支持

**示例**：
```
产品 Agent（主）→ 需要技术可行性评估
    ↓
技术 Agent（辅）→ 提供评估报告
    ↓
产品 Agent（主）→ 基于评估做决策
```

**优点**：
- 灵活按需
- 保持主导权
- 专业支持

**缺点**：
- 辅助 Agent 可能闲置
- 通信开销
- 需要清晰接口

---

## 💬 通信协议

### 任务分配格式

```yaml
task_assignment:
  id: "task-001"
  from: "coordinator"
  to: "dev-agent-1"
  type: "parallel"
  priority: "high"
  
  description: "实现用户登录功能"
  
  requirements:
    - "使用 OAuth 2.0"
    - "支持 Google 和 GitHub"
    - "记录登录日志"
  
  context:
    related_tasks: ["task-000"]
    related_capabilities: ["skill/oauth-integration"]
  
  deadline: "2026-06-14T18:00:00Z"
  
  output_format: "code + tests + docs"
```

---

### 进度通报格式

```yaml
progress_update:
  task_id: "task-001"
  agent_id: "dev-agent-1"
  timestamp: "2026-06-13T10:30:00Z"
  
  status: "in_progress"  # pending/in_progress/blocked/completed
  
  completion: 60  # 百分比
  
  completed_items:
    - "OAuth client 配置"
    - "Google 登录实现"
  
  in_progress_items:
    - "GitHub 登录实现"
  
  blocked_items: []
  
  next_steps:
    - "完成 GitHub 登录"
    - "编写测试"
```

---

### 结果交接格式

```yaml
task_result:
  task_id: "task-001"
  agent_id: "dev-agent-1"
  timestamp: "2026-06-13T15:00:00Z"
  
  status: "completed"
  
  outputs:
    - type: "code"
      path: "src/auth/oauth.py"
      description: "OAuth 2.0 实现"
    
    - type: "test"
      path: "tests/test_oauth.py"
      description: "单元测试"
    
    - type: "doc"
      path: "docs/oauth-guide.md"
      description: "使用文档"
  
  capabilities_deposited:
    - type: "skill"
      name: "oauth-integration"
  
  metrics:
    time_spent: "4.5h"
    lines_of_code: 342
    test_coverage: "95%"
```

---

## ⚠️ 冲突场景

### 场景 1：文件同时修改

```
Agent A 修改 file.py → 提交
Agent B 修改 file.py → 提交 ❌ 冲突！
```

**解决**：
1. **时间戳优先** - 先提交者胜出
2. **智能合并** - 自动合并不冲突部分
3. **人工裁决** - 复杂冲突人类决定
4. **锁机制** - Agent 修改前先锁定

---

### 场景 2：任务优先级争议

```
Agent A: "我的任务更紧急"
Agent B: "我的任务更重要"
```

**解决**：
1. **Owner 决策** - 人类最终决定
2. **评分系统** - 优先级 = 紧急度 × 影响力
3. **资源池** - 预留资源给高优先级
4. **动态调整** - 根据实际情况实时调整

---

### 场景 3：能力重复定义

```
Agent A 沉淀: skill/error-handling.md
Agent B 沉淀: skill/error-recovery.md （实际相同）
```

**解决**：
1. **命名规范** - 统一命名约定
2. **相似度检测** - 自动检测重复
3. **合并建议** - 提示合并相似能力
4. **版本管理** - 保留历史，迭代改进

---

## 🔐 能力权限管理

### 权限级别

```yaml
capability_permissions:
  # 公开（所有 agent 可读）
  public:
    - skill/basic-debugging
    - data/template-readme
  
  # 团队（指定 agent 可读）
  team:
    dev-agents:
      - skill/code-review
      - knowledge/architecture-decisions
    
    ops-agents:
      - skill/deployment-checklist
      - knowledge/incident-response
  
  # 私有（单个 agent 独占）
  private:
    senior-dev-agent:
      - knowledge/legacy-system-quirks
```

---

### 权限继承

```
coordinator-agent
  ├─ dev-agent-1（继承 coordinator 的公开能力）
  ├─ dev-agent-2（继承 coordinator 的公开能力）
  └─ test-agent（继承 coordinator 的公开能力 + 测试专属）
```

---

## 📋 实施路线图

### Phase 5（基础多 Agent）

**目标**：支持 2-3 个 agent 简单协作

**实现**：
- ✅ 串行协作模式
- ✅ 基础通信协议
- ✅ 文件锁机制
- ✅ 简单冲突检测

**时间**：2-3 周

---

### Phase 6（并行协作）

**目标**：支持 5-10 个 agent 并行工作

**实现**：
- ✅ 并行协作模式
- ✅ 任务拆分算法
- ✅ 结果合并逻辑
- ✅ 负载均衡

**时间**：4-6 周

---

### Phase 7（高级协作）

**目标**：支持复杂场景，10+ agent

**实现**：
- ✅ 审核协作模式
- ✅ 辅助协作模式
- ✅ 智能冲突解决
- ✅ 能力权限系统
- ✅ 性能优化

**时间**：8-12 周

---

## 🎓 设计原则

### 1. 渐进式复杂度

从简单开始，逐步增加复杂度：
- Phase 5: 串行（最简单）
- Phase 6: 并行（中等）
- Phase 7: 混合（最复杂）

### 2. 向后兼容

新模式不破坏现有工作流：
- 单 Agent 模式永远可用
- 多 Agent 可选启用
- 逐步迁移

### 3. 可观测性

清晰了解系统状态：
- Agent 状态实时可见
- 任务进度可追踪
- 冲突自动报警
- 性能指标可度量

### 4. 人类在环

人类保留最终控制权：
- 关键决策人类确认
- 冲突升级到人类
- 随时可中断
- 完整审计日志

---

## 💡 关键挑战

### 技术挑战

1. **并发控制**
   - 文件访问冲突
   - 资源竞争
   - 死锁预防

2. **状态同步**
   - Agent 间状态一致性
   - 任务依赖管理
   - 进度实时同步

3. **性能优化**
   - 通信开销
   - 调度效率
   - 资源利用率

---

### 组织挑战

1. **职责划分**
   - 如何拆分任务？
   - Agent 角色定义？
   - 边界如何划清？

2. **质量保证**
   - 多 Agent 输出质量
   - 一致性检查
   - 集成测试

3. **成本控制**
   - API 调用成本
   - 计算资源消耗
   - ROI 评估

---

## 📝 反馈需求

如果你对多 Agent 协作有想法，欢迎分享：

1. **场景需求**
   - 你希望多个 agent 协作完成什么任务？
   - 预期效率提升多少？

2. **模式偏好**
   - 哪种协作模式最吸引你？
   - 最担心什么问题？

3. **优先级**
   - 多 Agent 对你有多重要？
   - 愿意为此付出什么？

[创建讨论](https://github.com/Baokai-and-his-agents/org-v2/discussions/new?category=ideas)

---

_最后更新：2026-06-13_  
_状态：规划中_  
_版本：0.1 (概念设计)_
