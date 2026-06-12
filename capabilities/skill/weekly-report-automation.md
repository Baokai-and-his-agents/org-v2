# Skill: Weekly Report Automation

**类型**：skill  
**创建**：2026-06-13  
**更新**：2026-06-13  
**复用次数**：2+

## 🎯 用途

自动生成周报，包含 Git 统计、任务完成情况、能力沉淀等。

## 📥 输入

- 时间范围（默认 7 天）
- 输出格式（Markdown/JSON）

## 📤 输出

- 周报文件（Markdown 或 JSON）
- Git 统计数据
- 任务完成列表

## 🔄 步骤

```bash
# 默认 7 天
bash ops/scripts/generate-weekly-report.sh

# 自定义天数
bash ops/scripts/generate-weekly-report.sh -d 14

# JSON 格式
bash ops/scripts/generate-weekly-report.sh -f json -o report.json
```

## 💡 注意事项

- 跨平台兼容（macOS/Linux）
- 自动提取任务编号
- 统计 commits/files/LOC

_创建于任务 035_
