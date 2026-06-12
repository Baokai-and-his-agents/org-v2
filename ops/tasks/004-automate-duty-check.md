# 第四个任务：自动化 Duty 巡检

**创建**：2026-06-12  
**状态**：进行中  
**优先级**：高  
**Owner**：Baokai

---

## 🎯 目标

将 Duty Agent 巡检从手动触发升级为 GitHub Actions 自动定时触发，实现真正的"零人公司"巡检。

---

## 📋 背景

当前 duty-check.sh 需要手动运行。Phase 2 需要实现全自动化，让系统能够自主运行。

---

## 📊 任务范围

### In Scope
- 配置 GitHub Actions 定时触发
- 自动提交 heartbeat 记录
- 失败时通知机制
- 测试自动运行

### Out of Scope
- 复杂的异常检测（Phase 3）
- 自动修复机制（Phase 3）
- 邮件/Slack 通知（Phase 3）

---

## 🔄 执行计划

### 1. 创建 GitHub Actions workflow
- [ ] `.github/workflows/duty-check.yml`
- [ ] 配置 cron 时间表（每日 09:00 UTC）
- [ ] 配置权限（write contents）

### 2. 修改 duty-check.sh
- [ ] 支持 GitHub Actions 环境
- [ ] 自动 git commit + push
- [ ] 错误处理

### 3. 测试
- [ ] 手动触发验证
- [ ] 等待定时触发
- [ ] 验证 heartbeat 自动提交

### 4. 沉淀能力
- [ ] 评估是否需要新 skill

---

## ✅ 验收标准

1. GitHub Actions 配置正确
2. 能自动运行 duty-check.sh
3. Heartbeat 自动提交到仓库
4. 失败时能看到错误日志

---

## 💡 可能沉淀的能力

**Skill 候选**：
- github-actions-automation - 配置 GitHub Actions 的通用方法

**Data 候选**：
- cron-schedule-patterns - 常用的 cron 时间表

---

## 📝 执行记录

### 2026-06-12 开始实施

**计划**：
1. 创建 workflow 文件
2. 修改 duty-check.sh 支持自动提交
3. 测试运行
