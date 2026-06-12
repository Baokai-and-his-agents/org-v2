# Skill: Unit Testing Framework

**类型**：skill  
**创建**：2026-06-13  
**更新**：2026-06-13  
**复用次数**：0

---

## 🎯 用途

为能力管理系统创建自动化单元测试框架，确保系统质量和可靠性。

---

## 📥 输入

- 测试目标（能力文件、工具脚本、文档等）
- 质量标准（必须字段、格式要求等）
- 测试覆盖范围

---

## 📤 输出

- 可执行的测试脚本（`ops/tests/test-*.sh`）
- 自动化测试报告（通过/失败统计）
- 失败详情（具体错误位置和原因）

---

## 🔄 步骤

### 1. 创建测试目录结构

```bash
mkdir -p ops/tests
```

### 2. 定义测试辅助函数

创建可复用的断言函数：

```bash
# 文件存在性检查
assert_file_exists() {
    local file=$1
    local test_name=$2
    # 实现...
}

# 内容包含检查
assert_contains() {
    local file=$1
    local pattern=$2
    local test_name=$3
    # 实现...
}

# 非空检查
assert_not_empty() {
    local file=$1
    local test_name=$2
    # 实现...
}
```

### 3. 组织测试套件

按功能模块划分：

```bash
# 测试套件 1: 能力文件结构
test_capability_structure() {
    # 测试标题、类型、日期等必要字段
}

# 测试套件 2: 工具脚本
test_tool_scripts() {
    # 测试脚本存在性和可执行权限
}

# 测试套件 3: 文档完整性
test_documentation() {
    # 测试关键文档的存在性和内容
}
```

### 4. 实现主测试运行器

```bash
main() {
    echo "Running Tests..."
    
    # 运行所有测试套件
    test_capability_structure
    test_tool_scripts
    test_documentation
    
    # 统计并报告结果
    echo "Total: $TESTS_RUN"
    echo "Passed: $TESTS_PASSED"
    echo "Failed: $TESTS_FAILED"
    
    # 返回适当的退出码
    [[ $TESTS_FAILED -eq 0 ]] && exit 0 || exit 1
}
```

### 5. 添加色彩输出

使用 ANSI 颜色代码增强可读性：

```bash
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${GREEN}✓${NC} Test passed"
echo -e "${RED}✗${NC} Test failed"
```

### 6. 集成到 CI/CD

在 `.github/workflows/` 中添加测试步骤：

```yaml
- name: Run Unit Tests
  run: bash ops/tests/test-capability-quality.sh
```

---

## 💡 注意事项

### 测试设计原则

1. **独立性**：每个测试独立运行，不依赖其他测试
2. **可重复**：多次运行结果一致
3. **快速**：单个测试 < 1 秒
4. **清晰**：测试名称说明测试内容

### 断言策略

- **存在性**：文件/目录是否存在
- **内容性**：文件包含必要字段
- **格式性**：符合规范（如日期格式）
- **完整性**：所有必要部分都存在

### 错误报告

失败时提供：
- 测试名称
- 失败原因
- 相关文件路径
- 期望 vs 实际

### 性能考虑

- 避免重复读取同一文件
- 使用 `grep -q` 快速检查
- 并行运行独立测试套件（可选）

---

## 🔗 相关能力

- [[quality-check-automation]] - 质量检查自动化
- [[problem-driven-development]] - 问题驱动开发
- [[health-score-calculator]] - 健康度计算器

---

## 📊 使用示例

```bash
# 基础运行
bash ops/tests/test-capability-quality.sh

# CI 集成
if ! bash ops/tests/test-capability-quality.sh; then
    echo "Tests failed!"
    exit 1
fi

# 添加新测试
test_new_feature() {
    assert_file_exists "path/to/file" "Feature file exists"
    assert_contains "path/to/file" "pattern" "Contains expected pattern"
}
```

---

## 📈 收益

- **早期发现问题**：自动化检测质量问题
- **回归预防**：防止旧问题重现
- **文档保证**：确保文档完整性
- **CI 就绪**：可集成到自动化流程
- **信心提升**：每次修改后快速验证

---

## 🎓 最佳实践

1. **测试先行**：添加新功能前先写测试
2. **覆盖核心**：优先测试关键路径
3. **持续运行**：每次提交前运行测试
4. **快速反馈**：测试失败立即修复
5. **文档同步**：测试即文档（测试说明预期行为）

---

_创建于任务 051_  
_验证：30 个测试全部通过_
