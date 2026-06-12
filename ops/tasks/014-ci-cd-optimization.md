# 第十四个任务：优化 CI/CD 流程

**创建**：2026-06-12  
**状态**：进行中  
**类型**：工程改进型  
**优先级**：高  
**预计时间**：40 分钟

---

## 🎯 目标

修复并优化 GitHub Actions CI，添加更多自动化检查，提升代码质量保障和开发体验。

---

## 📋 背景

当前 CI 状态：
- ✅ 结构检查（check.yml）存在但可能未完全工作
- ⚠️ Duty 巡检（duty-check.yml）存在问题（task 004）
- ❌ 缺少质量检查集成
- ❌ 缺少能力索引同步检查

需要：
- 修复现有 CI
- 添加新的自动化检查
- 优化执行效率
- 提供清晰的错误信息

---

## 📊 任务范围

### In Scope
- 修复现有 CI 问题
- 集成 check-capabilities.sh
- 集成 sync-capability-index.sh
- 添加 Markdown lint（可选）
- 优化执行速度

### Out of Scope
- 复杂的测试框架
- 部署流程
- 多平台测试矩阵

---

## 🔄 执行计划

### 1. 审查现有 CI
- [ ] 检查 .github/workflows/check.yml
- [ ] 检查 .github/workflows/duty-check.yml
- [ ] 识别问题和改进点

### 2. 修复问题
- [ ] 解决跨平台兼容性问题
- [ ] 修复脚本权限
- [ ] 确保依赖可用

### 3. 添加新检查
- [ ] 能力资产质量检查
- [ ] 索引同步验证
- [ ] 文档格式检查（可选）

### 4. 优化体验
- [ ] 清晰的错误消息
- [ ] 并行执行（where possible）
- [ ] 缓存优化

---

## 📤 预期输出

1. 修复的 CI workflows
2. 新增检查集成
3. CI 运行成功
4. 文档更新

---

## ✅ 验收标准

1. 所有 CI checks 通过
2. PR 能正确触发检查
3. 错误信息清晰
4. 执行时间合理（<5 分钟）

---

## 💡 可能沉淀能力

**Knowledge 候选**：
- github-actions-best-practices（GitHub Actions 最佳实践）

---

## 📝 执行记录

_进行中_
