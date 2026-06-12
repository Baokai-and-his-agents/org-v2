# Skill: Capability Export Tool

**类型**：skill  
**创建**：2026-06-13  
**更新**：2026-06-13  
**复用次数**：1

## 🎯 用途

将能力资产导出为 YAML 格式，用于分享、备份或跨项目迁移。

## 📥 输入

- 导出范围（单个/类别/全部）
- 输出文件路径

## 📤 输出

- YAML 格式能力文件
- 包含完整元数据和内容

## 🔄 步骤

```bash
# 导出单个
bash ops/scripts/export-capability.sh -t skill -n problem-driven-development -o output.yaml

# 导出类别
bash ops/scripts/export-capability.sh -c skill -o all-skills.yaml

# 导出全部
bash ops/scripts/export-capability.sh -a -o all-caps.yaml
```

## 💡 注意事项

- YAML 格式便于解析
- 保留完整元数据
- 支持批量导出
- 文件编码 UTF-8

_创建于任务 032_
