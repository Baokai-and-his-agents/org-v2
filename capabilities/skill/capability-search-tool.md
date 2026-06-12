# Skill: Capability Search Tool

**类型**：skill  
**创建**：2026-06-13  
**更新**：2026-06-13  
**复用次数**：3+

## 🎯 用途

全文搜索能力资产，快速定位需要的能力。

## 📥 输入

- 搜索关键词
- 可选：类型筛选、详细模式

## 📤 输出

- 匹配的能力列表
- 匹配位置和上下文

## 🔄 步骤

```bash
# 基础搜索
bash ops/scripts/search-capability.sh keyword

# 详细模式
bash ops/scripts/search-capability.sh -v keyword

# 类型筛选
bash ops/scripts/search-capability.sh -t skill keyword
```

## 💡 注意事项

- 支持全文搜索
- 高亮匹配内容
- 可按类型筛选

_创建于任务 034_
