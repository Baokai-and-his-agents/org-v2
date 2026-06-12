# Knowledge: GitHub Actions CI/CD Setup

**类型**：knowledge  
**创建**：2026-06-13  
**更新**：2026-06-13  
**复用次数**：1

## 🎯 用途

记录如何为 org-v2 类型的项目配置 GitHub Actions CI/CD 流水线。

## 💡 核心设计

### 质量门禁策略

**原则**：持续验证，及时发现问题

**流水线阶段**：
1. 能力质量检查
2. 单元测试
3. 集成测试
4. 性能基准测试
5. 健康度评分
6. 结果归档

### 触发条件

**Push 到 main**：
- 验证主分支代码质量
- 记录健康度趋势
- 追踪性能回归

**Pull Request**：
- 合并前质量验证
- 阻止不合格代码
- 提供反馈给贡献者

## 📋 工作流配置

### 基础结构

```yaml
name: Quality Check

on:
  push:
    branches: [ main ]
  pull_request:
    branches: [ main ]

jobs:
  quality-check:
    runs-on: ubuntu-latest
    
    steps:
    - name: Checkout code
      uses: actions/checkout@v4
      
    # 测试步骤...
```

### 关键步骤

**1. 能力质量检查**
```yaml
- name: Run capability quality check
  run: bash ops/scripts/check-capabilities.sh
```
验证所有能力文件格式正确。

**2. 单元测试**
```yaml
- name: Run unit tests
  run: bash ops/tests/test-capability-quality.sh
```
30 个单元测试，验证文件结构。

**3. 集成测试**
```yaml
- name: Run integration tests
  run: bash ops/tests/integration/test-workflow-integration.sh
```
5 个端到端测试，验证工作流。

**4. 性能基准**
```yaml
- name: Run performance benchmarks
  run: bash ops/tests/performance/benchmark-tools.sh
```
7 个性能测试，追踪回归。

**5. 健康度评分**
```yaml
- name: Calculate health score
  run: bash ops/scripts/calculate-health-score.sh
```
8 维度评分，趋势监控。

**6. 结果归档**
```yaml
- name: Upload test results
  if: always()
  uses: actions/upload-artifact@v4
  with:
    name: test-results
    path: ops/reports/
```
保存报告供后续分析。

## 💡 最佳实践

### 1. 失败即停止

如果质量检查失败，后续步骤不应继续。

```yaml
- name: Run tests
  run: bash test.sh
  # 失败时 exit 1，自动停止流水线
```

### 2. 结果总是上传

即使测试失败，也要上传结果。

```yaml
- name: Upload results
  if: always()  # 关键：即使失败也运行
```

### 3. 明确依赖

使用特定版本的 Actions：

```yaml
uses: actions/checkout@v4  # 不要用 @latest
```

### 4. 快速反馈

优化测试速度，5 分钟内完成。

```bash
# 并行运行独立测试
- name: Tests
  run: |
    bash test1.sh &
    bash test2.sh &
    wait
```

## 🎓 扩展配置

### 定时运行

每天凌晨运行完整检查：

```yaml
on:
  schedule:
    - cron: '0 0 * * *'  # 每天 00:00 UTC
```

### 多环境测试

在不同 OS 上测试：

```yaml
strategy:
  matrix:
    os: [ubuntu-latest, macos-latest]
runs-on: ${{ matrix.os }}
```

### 条件步骤

仅在特定条件下运行：

```yaml
- name: Deploy
  if: github.ref == 'refs/heads/main'
  run: bash deploy.sh
```

### 通知

失败时发送通知：

```yaml
- name: Notify on failure
  if: failure()
  run: |
    # 发送 Slack/Email 通知
```

## ⚠️ 常见陷阱

### 1. 路径问题

Actions 默认在仓库根目录运行：

```yaml
# ✅ 正确
run: bash ops/scripts/test.sh

# ❌ 错误
run: cd ops && bash scripts/test.sh  # 多余的 cd
```

### 2. 权限问题

脚本必须有执行权限：

```bash
chmod +x ops/scripts/*.sh
git add ops/scripts/*.sh
git commit -m "Make scripts executable"
```

### 3. 环境差异

本地 macOS，CI 是 Linux：

```bash
# 处理 date 命令差异
if [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS
else
    # Linux
fi
```

## 📊 效果验证

**Phase 5+ 实践**：
- 配置于任务 063
- 覆盖所有测试（42 个）
- 包含健康度评分
- 自动化程度 9.5 → 10.0

**预期收益**：
- 每次 push 自动验证
- PR 合并前强制检查
- 性能回归及时发现
- 健康度持续监控

## 🔗 相关能力

- [[github-actions-best-practices]] - GitHub Actions 最佳实践
- [[quality-check-automation]] - 质量检查自动化
- [[unit-testing-framework]] - 单元测试框架

---

_创建于任务 063_  
_org-v2 CI/CD 实践总结_
