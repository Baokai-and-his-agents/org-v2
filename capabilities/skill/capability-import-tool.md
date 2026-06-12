# Skill: Capability Import Tool

**类型**：skill  
**创建**：2026-06-13  
**更新**：2026-06-13  
**复用次数**：1

## 🎯 用途

从 YAML 文件导入能力资产，支持冲突检测和多种解决策略。

## 📥 输入

- YAML 格式能力文件
- 冲突策略（skip/overwrite/rename）

## 📤 输出

- 导入的能力文件
- 冲突报告

## 🔄 步骤

```bash
# 预览导入
bash ops/scripts/import-capability.sh -f caps.yaml --dry-run

# 跳过已存在
bash ops/scripts/import-capability.sh -f caps.yaml --skip-existing

# 覆盖本地
bash ops/scripts/import-capability.sh -f caps.yaml --overwrite
```

## 💡 注意事项

- 冲突检测自动进行
- 支持 yq 或 fallback 解析器
- 验证文件完整性

_创建于任务 033_
