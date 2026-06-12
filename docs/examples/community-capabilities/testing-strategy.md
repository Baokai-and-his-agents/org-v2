# 社区能力示例：测试策略

**贡献者**：org-v2 团队  
**场景**：为项目建立完整的测试体系  
**适用**：所有开发团队

---

## 🎯 用途

从零建立系统化的测试策略，覆盖单元、集成、性能三个层次。

## 📋 工作流步骤

### 1. 测试需求分析

```bash
# 确定测试目标
cat > ops/tasks/XXX-testing-strategy.md << TASK
# 任务：建立测试体系

## 目标
- 单元测试覆盖核心功能
- 集成测试验证工作流
- 性能测试建立基线

## 输入
- 现有代码库
- 关键功能清单

## 输出
- 测试框架
- 测试用例
- CI 集成
TASK
```

### 2. 单元测试（基础层）

```bash
# 创建单元测试
cat > ops/tests/test-core-functions.sh << 'TEST'
#!/bin/bash
# 单元测试：核心功能

test_file_exists() {
    local file=$1
    if [ -f "$file" ]; then
        echo "✅ PASS: $file exists"
        return 0
    else
        echo "❌ FAIL: $file not found"
        return 1
    fi
}

test_script_executable() {
    local script=$1
    if [ -x "$script" ]; then
        echo "✅ PASS: $script is executable"
        return 0
    else
        echo "❌ FAIL: $script not executable"
        return 1
    fi
}

# 运行测试
test_file_exists "README.md"
test_script_executable "ops/scripts/example.sh"
TEST

chmod +x ops/tests/test-core-functions.sh
bash ops/tests/test-core-functions.sh
```

**原则**：
- 每个功能一个测试
- 快速执行（< 1s）
- 独立运行（无依赖）

### 3. 集成测试（工作流层）

```bash
# 创建集成测试
cat > ops/tests/integration/test-complete-workflow.sh << 'TEST'
#!/bin/bash
# 集成测试：完整工作流

set -e

echo "Testing complete workflow..."

# Step 1: Setup
echo "1. Setting up test environment..."
mkdir -p /tmp/test-workspace
cd /tmp/test-workspace

# Step 2: Execute workflow
echo "2. Executing workflow..."
bash /path/to/workflow.sh

# Step 3: Verify results
echo "3. Verifying results..."
if [ -f "expected-output.txt" ]; then
    echo "✅ Workflow completed successfully"
else
    echo "❌ Workflow failed"
    exit 1
fi

# Cleanup
rm -rf /tmp/test-workspace
TEST
```

**原则**：
- 测试真实场景
- 端到端验证
- 包含清理步骤

### 4. 性能测试（基准层）

```bash
# 创建性能测试
cat > ops/tests/performance/benchmark-operations.sh << 'TEST'
#!/bin/bash
# 性能测试：操作基准

time_operation() {
    local description=$1
    shift
    
    local start=$(date +%s%N)
    "$@" > /dev/null 2>&1
    local end=$(date +%s%N)
    
    local duration=$((($end - $start) / 1000000))
    echo "$description: ${duration}ms"
}

# 测试各操作性能
time_operation "File search" find . -name "*.md"
time_operation "Script execution" bash ops/scripts/example.sh
time_operation "Data processing" grep -r "pattern" .

# 设定基准
if [ $duration -lt 1000 ]; then
    echo "✅ Performance: Excellent"
else
    echo "⚠️ Performance: Needs optimization"
fi
TEST
```

**原则**：
- 建立性能基线
- 追踪回归
- 优化有据可依

### 5. CI 集成

```yaml
# .github/workflows/tests.yml
name: Tests

on: [push, pull_request]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      
      - name: Unit Tests
        run: bash ops/tests/test-core-functions.sh
      
      - name: Integration Tests
        run: bash ops/tests/integration/test-complete-workflow.sh
      
      - name: Performance Tests
        run: bash ops/tests/performance/benchmark-operations.sh
```

### 6. 能力沉淀

```bash
cat > capabilities/knowledge/testing-strategy-lessons.md << CAP
# Knowledge: Testing Strategy Lessons

**类型**：knowledge
**创建**：YYYY-MM-DD

## 🎯 用途
记录建立测试体系的经验教训

## 💡 关键洞察

### 1. 测试金字塔
- 单元测试：70%（快速、大量）
- 集成测试：20%（中速、适量）
- 性能测试：10%（慢速、少量）

### 2. 先写测试还是先写代码？
- 关键功能：先写测试（TDD）
- 探索性功能：先写代码，后补测试
- 重构代码：先写测试保护

### 3. 测试粒度
- 太细：维护成本高
- 太粗：定位困难
- 平衡：一个功能点一个测试

### 4. 失败处理
- 测试失败不等于代码坏
- 可能是测试本身的问题
- 先检查测试逻辑

### 5. 性能基准
- 不要过早优化
- 先建立基线
- 追踪趋势比绝对值重要

## ⚠️ 常见陷阱

1. **过度测试**：测试代码比业务代码还多
2. **依赖外部**：网络、数据库导致不稳定
3. **忽略清理**：测试污染环境
4. **缺少文档**：不知道测什么、为什么测

## 🔗 相关能力
- [[unit-testing-framework]]
- [[quality-check-automation]]
CAP
```

---

## 💡 复用价值

- **标准化**：团队统一测试方法
- **自动化**：CI 持续验证质量
- **可追踪**：性能回归及时发现
- **可信任**：代码改动有保障

---

## 📊 实际效果

**Phase 5+ 实践**：
- 从 0 到 42 个测试
- 100% 通过率
- 平均执行时间 137ms
- 发现并修复 5+ 个问题

---

## 🔗 相关能力

- unit-testing-framework
- quality-check-automation
- github-actions-cicd-setup

---

_这是一个社区能力示例，展示如何建立完整测试体系_
