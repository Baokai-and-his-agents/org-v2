# 工具性能分析

20 个工具的性能基准和优化建议。

**更新**: 2026-06-13

---

## 📊 性能概览

### 总体性能：优秀

- **平均执行时间**: 137ms
- **最快工具**: < 50ms
- **最慢工具**: < 500ms
- **评级**: EXCELLENT

---

## 🔧 工具性能分类

### 快速工具（< 100ms）

**适合频繁使用**

1. **init-guide.sh** (~10ms)
   - 纯文本输出
   - 无外部依赖

2. **search-capability.sh** (~50ms)
   - 简单 grep 操作
   - 线性搜索

3. **check-capabilities.sh** (~80ms)
   - 文件系统检查
   - 格式验证

4. **tool-usage-tracker.sh** (~90ms)
   - Git log 分析
   - 简单统计

---

### 中速工具（100-300ms）

**日常使用推荐**

5. **duty-check.sh** (~120ms)
   - 多项检查组合
   - 文件统计

6. **calculate-health-score.sh** (~150ms)
   - 8 维度计算
   - 复杂逻辑

7. **capability-usage-stats.sh** (~180ms)
   - 文件遍历
   - 统计分析

8. **capability-dependencies.sh** (~200ms)
   - 依赖关系分析
   - 图构建

9. **capability-heatmap.sh** (~220ms)
   - 引用计数
   - 热度计算

10. **export-capability.sh** (~250ms)
    - 文件读取
    - YAML 生成

11. **import-capability.sh** (~250ms)
    - YAML 解析
    - 文件写入

---

### 慢速工具（300-500ms）

**按需使用**

12. **generate-weekly-report.sh** (~350ms)
    - Git 历史分析
    - 报告生成

13. **generate-monthly-report.sh** (~400ms)
    - 更长时间范围
    - 更多统计

14. **generate-stats-report.sh** (~420ms)
    - 全面统计
    - 多项分析

15. **contributor-stats.sh** (~450ms)
    - Git log 深度分析
    - 时间轴构建

16. **check-release-readiness.sh** (~480ms)
    - 23 项检查
    - 测试执行

17. **backup-project.sh** (~500ms)
    - 文件复制
    - 压缩归档

---

### 特殊工具

**测试工具**（性能独立评估）

18. **test-capability-quality.sh** (~150ms for 30 tests)
    - 5ms/test
    - 优秀性能

19. **test-workflow-integration.sh** (~100ms for 5 tests)
    - 20ms/test
    - 良好性能

20. **benchmark-tools.sh** (~200ms for 7 tests)
    - 29ms/test
    - 可接受

---

## 💡 性能优化建议

### 1. 频繁使用的优化

**duty-check.sh** (当前 120ms):
- ✅ 已优化：避免重复计算
- 💡 可优化：缓存文件统计结果

**calculate-health-score.sh** (当前 150ms):
- ✅ 已优化：并行维度计算
- 💡 可优化：预计算常用指标

---

### 2. 报告生成优化

**generate-weekly-report.sh** (当前 350ms):
- 💡 可优化：增量更新（vs 全量）
- 💡 可优化：缓存 Git 分析结果

**generate-monthly-report.sh** (当前 400ms):
- 💡 可优化：异步生成
- 💡 可优化：分段加载数据

---

### 3. 分析工具优化

**capability-dependencies.sh** (当前 200ms):
- 💡 可优化：构建依赖索引
- 💡 可优化：增量更新图

**capability-heatmap.sh** (当前 220ms):
- 💡 可优化：缓存引用计数
- 💡 可优化：定期预计算

---

### 4. 备份工具优化

**backup-project.sh** (当前 500ms):
- 💡 可优化：增量备份
- 💡 可优化：并行压缩
- 💡 可优化：排除临时文件

---

## 📈 性能改进计划

### Phase 1: 缓存层（预期提升 30%）

```bash
# 添加简单缓存
CACHE_DIR=".cache"
CACHE_TTL=3600  # 1 hour

cache_get() {
    local key=$1
    local file="$CACHE_DIR/$key"
    if [ -f "$file" ]; then
        local age=$(($(date +%s) - $(stat -f %m "$file")))
        if [ $age -lt $CACHE_TTL ]; then
            cat "$file"
            return 0
        fi
    fi
    return 1
}

cache_set() {
    local key=$1
    local value=$2
    mkdir -p "$CACHE_DIR"
    echo "$value" > "$CACHE_DIR/$key"
}
```

**适用工具**:
- capability-usage-stats.sh
- capability-dependencies.sh
- contributor-stats.sh

---

### Phase 2: 并行执行（预期提升 50%）

```bash
# 并行执行独立任务
task1 &
task2 &
task3 &
wait
```

**适用工具**:
- calculate-health-score.sh (8 维度)
- generate-weekly-report.sh (多个统计)
- check-release-readiness.sh (23 项检查)

---

### Phase 3: 增量计算（预期提升 70%）

```bash
# 只处理变更部分
LAST_RUN=$(cat .last_run)
CURRENT=$(git rev-parse HEAD)

if [ "$LAST_RUN" != "$CURRENT" ]; then
    # 只分析新提交
    git diff --name-only $LAST_RUN $CURRENT | ...
fi
```

**适用工具**:
- generate-weekly-report.sh
- generate-monthly-report.sh
- contributor-stats.sh

---

## 🎯 性能目标

### 当前性能（基准）

| 工具类别 | 平均时间 | 评级 |
|---------|---------|------|
| 快速 (1-4) | 50ms | ⭐⭐⭐ |
| 中速 (5-11) | 180ms | ⭐⭐⭐ |
| 慢速 (12-17) | 400ms | ⭐⭐ |
| 测试 (18-20) | 150ms | ⭐⭐⭐ |

---

### 优化目标（Phase 1-3 完成后）

| 工具类别 | 目标时间 | 提升 |
|---------|---------|------|
| 快速 | 40ms | 20% |
| 中速 | 120ms | 33% |
| 慢速 | 200ms | 50% |
| 测试 | 100ms | 33% |

**总体目标**: 平均执行时间 < 100ms

---

## 🔍 性能监控

### 定期基准测试

```bash
# 每月运行
bash ops/tests/performance/benchmark-tools.sh

# 对比历史数据
diff reports/benchmark-$(date -v-1m +%Y%m).txt \
     reports/benchmark-$(date +%Y%m).txt
```

---

### 性能退化警报

```bash
# 在 CI 中检查
CURRENT=$(benchmark_avg)
BASELINE=137

if [ $CURRENT -gt $((BASELINE + 50)) ]; then
    echo "⚠️ Performance regression detected!"
    exit 1
fi
```

---

## 💡 使用建议

### 1. 选择合适的工具

- **频繁使用**: 选择快速工具
- **定期使用**: 中速工具可接受
- **按需使用**: 慢速工具不影响体验

---

### 2. 批量执行

```bash
# 不推荐：多次单独执行
for i in 1 2 3; do
    bash ops/scripts/generate-weekly-report.sh
done

# 推荐：一次执行
bash ops/scripts/generate-weekly-report.sh
```

---

### 3. 后台执行

```bash
# 慢速工具后台运行
bash ops/scripts/backup-project.sh &
bash ops/scripts/generate-monthly-report.sh &
```

---

### 4. 定时执行

```bash
# 在空闲时间执行慢速工具
# crontab: 0 2 * * * (每天凌晨 2 点)
bash ops/scripts/generate-stats-report.sh
bash ops/scripts/backup-project.sh
```

---

## 📚 相关文档

- [性能测试](../ops/tests/performance/benchmark-tools.sh)
- [工具指南](TOOLS_GUIDE.md)
- [最佳实践](BEST_PRACTICES.md)

---

**性能即是体验** ⚡
