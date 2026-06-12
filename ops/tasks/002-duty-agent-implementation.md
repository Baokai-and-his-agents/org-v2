# 第二个任务：创建 Duty Agent 巡检机制

**创建**：2026-06-12  
**状态**：✅ 完成  
**优先级**：高  
**Owner**：Baokai

---

## 🎯 目标

实现可工作的 Duty Agent 自动巡检机制，证明组织可以自主运行。

---

## 📋 背景

org-blueprint 的一个核心问题是 Duty Agent 设计完整但可能未真正运行。org-v2 需要证明巡检机制可用。

---

## 📊 任务范围

### In Scope
- 创建 heartbeat 模板
- 实现巡检检查清单脚本
- 测试手动触发巡检
- 生成第一份 heartbeat 记录

### Out of Scope
- 全自动定时触发（Phase 2）
- 复杂的异常检测（Phase 2）
- 自动修复机制（Phase 2）

---

## 🔄 执行计划

### 1. 创建 heartbeat 模板
- [x] 定义 heartbeat 标准格式
- [x] 包含检查项和发现

### 2. 实现巡检脚本
- [x] ops/scripts/duty-check.sh
- [x] 检查 NOW.md 任务状态
- [x] 检查 resource-requests
- [x] 检查能力资产过期
- [x] 生成 heartbeat

### 3. 运行第一次巡检
- [x] 手动触发
- [x] 验证输出
- [x] 生成 heartbeat 记录

### 4. 沉淀能力
- [x] 创建 duty-check skill
- [x] 更新 INDEX.md

---

## ✅ 任务完成

**完成时间**：2026-06-12  
**总耗时**：约 15 分钟  

### 成果
- duty-check.sh 巡检脚本（~110 行）
- 第一份 heartbeat 记录
- 验证巡检机制可用

### 验证结果
✅ Duty Agent 机制证明可行：
- 能自动检查任务状态
- 能检查资源请求
- 能统计能力资产
- 能生成结构化 heartbeat

**沉淀能力**：duty-check skill

---

## ✅ 验收标准

1. 存在 `ops/scripts/duty-check.sh`
2. 能成功运行并生成 heartbeat
3. heartbeat 包含有用信息
4. 可以手动触发巡检

---

## 💡 可能沉淀的能力

**Skill 候选**：
- duty-check - Duty Agent 巡检流程

**Data 候选**：
- heartbeat-template - 巡检记录模板

---

## 📝 执行记录

_待开始_
