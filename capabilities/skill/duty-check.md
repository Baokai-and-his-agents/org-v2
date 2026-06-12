# Skill: duty-check

**类型**：skill  
**创建**：2026-06-12  
**更新**：2026-06-12  
**复用次数**：1

---

## 🎯 用途

Duty Agent 定期巡检组织运行状态，发现问题并生成 heartbeat 记录

---

## 📥 输入

无（自动读取仓库状态）

---

## 📤 输出

- Heartbeat 记录文件：`ops/heartbeats/YYYY-MM-DD-HHMM.md`
- 控制台输出：巡检结果摘要

---

## 🔄 使用流程

1. **手动触发**（当前阶段）
   ```bash
   cd org-v2
   bash ops/scripts/duty-check.sh
   ```

2. **查看 heartbeat**
   ```bash
   cat ops/heartbeats/$(ls -t ops/heartbeats/ | head -1)
   ```

3. **定期执行**（未来）
   - 通过 cron 或 GitHub Actions
   - 建议频率：每日 1 次

---

## ✅ 检查清单

### 检查项

- [ ] NOW.md 活跃任务数
- [ ] 资源请求待处理数
- [ ] 能力资产统计（skill/data/knowledge）
- [ ] 系统健康度
- [ ] 本周提交数

### 输出质量

- [ ] Heartbeat 文件成功创建
- [ ] 包含所有检查项
- [ ] 提供行动建议
- [ ] 时间戳准确

---

## 📝 示例

### 成功案例

**触发**：2026-06-12 手动运行

**输入**：仓库当前状态

**输出**：
```
ops/heartbeats/2026-06-13-0304.md
- 活跃任务：1
- 资源请求：0
- 能力资产：2 (1 skill + 1 knowledge)
- 系统健康：正常
- 建议：无
```

**时间**：< 1 秒

---

## 🔗 相关能力

- skill/org-bootstrap（组织初始化）
- ops/agent-protocol.md（Agent 工作协议）

---

## 📌 维护说明

- 更新频率：按需（发现新检查项时）
- 负责人：Agent
- 脚本位置：`ops/scripts/duty-check.sh`

---

## 🚀 未来增强

**Phase 2（未来 3 个月）**：
- 自动定时触发（GitHub Actions）
- 异常检测（任务超期、能力资产过期）
- 自动修复简单问题

**Phase 3（未来 6 个月）**：
- 智能建议（基于历史数据）
- 预测性维护
- 自动生成 issue

---

## 📊 使用记录

| 日期 | 场景 | 结果 | 备注 |
|------|------|------|------|
| 2026-06-12 | 首次测试 | ✅ | 验证机制可行 |
