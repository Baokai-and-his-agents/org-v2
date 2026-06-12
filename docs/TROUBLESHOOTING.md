# 故障排查指南

遇到问题？这里是常见问题的解决方案。

---

## 🔍 快速诊断

### 第一步：运行健康检查

```bash
bash ops/scripts/calculate-health-score.sh
```

健康度 < 7.0？查看建议的改进方向。

---

### 第二步：查看近期变更

```bash
git log --oneline -10
git status
```

最近的修改可能导致问题。

---

### 第三步：运行质量检查

```bash
bash ops/scripts/check-capabilities.sh
```

能力文件格式问题？

---

## ⚠️ 常见问题

### 1. 脚本无法执行

**症状**：
```
bash: ops/scripts/xxx.sh: Permission denied
```

**原因**：脚本没有执行权限

**解决**：
```bash
chmod +x ops/scripts/*.sh
```

或单个脚本：
```bash
chmod +x ops/scripts/duty-check.sh
```

---

### 2. 能力质量检查失败

**症状**：
```
❌ Capability quality check failed
需要改进: 3 个能力
```

**原因**：能力文件缺少必要字段

**解决**：
1. 查看具体错误
```bash
bash ops/scripts/check-capabilities.sh
```

2. 对照模板补全缺失字段
```markdown
**类型**：skill/data/knowledge/system
**创建**：YYYY-MM-DD
**更新**：YYYY-MM-DD
**复用次数**：N

## 🎯 用途
...
```

3. 重新运行检查确认

---

### 3. Git 提交被 CI 阻塞

**症状**：
```
GitHub Actions: quality-check ❌ Failed
```

**原因**：能力质量检查未通过

**解决**：
1. 查看 CI 日志具体错误
2. 本地修复问题
3. 本地运行检查确认通过
```bash
bash ops/scripts/check-capabilities.sh
```
4. 重新提交

---

### 4. 找不到能力文件

**症状**：
```bash
bash ops/scripts/search-capability.sh debugging
找到 0 个匹配的能力
```

**原因**：
- 能力未创建
- 搜索关键词不匹配
- 文件位置错误

**解决**：
```bash
# 1. 检查能力是否存在
ls capabilities/

# 2. 尝试更宽松的搜索
bash ops/scripts/search-capability.sh -i debug

# 3. 搜索所有能力
find capabilities -name "*.md" -type f

# 4. 查看能力索引
cat capabilities/INDEX.md
```

---

### 5. 导入能力冲突

**症状**：
```
⚠️  冲突检测到: skill/xxx.md
```

**原因**：本地已存在同名能力

**解决方案**：

**选项 1：跳过已存在**
```bash
bash ops/scripts/import-capability.sh \
  -f capability.yaml --skip-existing
```

**选项 2：覆盖本地**
```bash
bash ops/scripts/import-capability.sh \
  -f capability.yaml --overwrite
```

**选项 3：重命名导入**
```bash
bash ops/scripts/import-capability.sh \
  -f capability.yaml --rename
```

---

### 6. NOW.md 与实际不同步

**症状**：NOW.md 显示旧任务，但实际已完成

**原因**：忘记更新 NOW.md

**解决**：
```bash
# 手动更新
vi NOW.md

# 或重新生成（如果有脚本）
# bash ops/scripts/update-now.sh
```

**预防**：
- 任务完成后立即更新 NOW.md
- 或创建自动化脚本

---

### 7. 健康度评分异常

**症状**：某个维度评分突然下降

**诊断**：
```bash
# 运行详细健康检查
bash ops/scripts/calculate-health-score.sh

# 检查各维度的具体指标
```

**常见原因**：
- 删除了关键文件
- CI 配置损坏
- 能力文件减少

**解决**：根据具体维度检查相应文件

---

### 8. 周报生成失败

**症状**：
```
bash ops/scripts/generate-weekly-report.sh
错误: ...
```

**可能原因**：

**Git 历史不足**：
```bash
# 检查 commit 数量
git log --oneline | wc -l
```

**日期命令不兼容**：
- macOS 使用 `date -v`
- Linux 使用 `date -d`

**解决**：
脚本已兼容两种系统，如仍有问题：
```bash
# 手动指定日期
bash ops/scripts/generate-weekly-report.sh \
  --since="2026-06-06"
```

---

### 9. 导出能力文件过大

**症状**：
```
导出文件: 50MB
```

**原因**：包含二进制文件或大量内容

**解决**：

**只导出需要的**：
```bash
# 单个能力
bash ops/scripts/export-capability.sh \
  -t skill -n xxx -o xxx.yaml

# 特定类别
bash ops/scripts/export-capability.sh \
  -c skill -o skills-only.yaml
```

**检查大文件**：
```bash
find capabilities -name "*.md" -exec du -h {} \; | sort -h
```

---

### 10. 跨平台兼容性问题

**症状**：脚本在 Linux 上运行正常，macOS 上失败

**常见差异**：

**date 命令**：
```bash
# macOS
date -v-7d +%Y-%m-%d

# Linux
date -d "-7 days" +%Y-%m-%d
```

**解决**：使用条件判断
```bash
if [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS
else
    # Linux
fi
```

**sed 行为**：
```bash
# macOS 需要 ''
sed -i '' 's/old/new/' file

# Linux 不需要
sed -i 's/old/new/' file
```

---

## 🐛 调试技巧

### 启用详细输出

```bash
# Bash 脚本
bash -x ops/scripts/xxx.sh

# 或在脚本开头添加
set -x
```

---

### 检查脚本变量

在脚本中添加：
```bash
echo "DEBUG: var=$var"
```

---

### 逐行执行

```bash
# 复制脚本内容
# 逐行粘贴到终端执行
# 观察每步输出
```

---

## 🆘 仍然无法解决？

### 1. 搜索已知问题

```bash
# 在 Issues 中搜索
https://github.com/Baokai-and-his-agents/org-v2/issues
```

---

### 2. 查看 Discussions

```bash
# 社区可能已经讨论过
https://github.com/Baokai-and-his-agents/org-v2/discussions
```

---

### 3. 创建详细的 Issue

**包含**：
- 问题描述
- 复现步骤
- 预期行为 vs 实际行为
- 系统环境（OS、Shell、版本）
- 错误日志
- 已尝试的解决方案

**模板**：
```markdown
### 问题描述
[清晰描述问题]

### 复现步骤
1. 
2. 
3. 

### 预期 vs 实际
- 预期：...
- 实际：...

### 环境
- OS: macOS 14.0
- Shell: zsh
- org-v2 版本: commit xxx

### 错误日志
\`\`\`
[粘贴完整错误信息]
\`\`\`

### 已尝试
- [x] 运行健康检查
- [x] 查看近期 commit
- [ ] ...
```

---

## 📚 相关资源

- [FAQ](./FAQ.md) - 常见问题快速答案
- [最佳实践](./BEST_PRACTICES.md) - 避免常见问题
- [Contributing](../CONTRIBUTING.md) - 贡献指南
- [GitHub Issues](https://github.com/Baokai-and-his-agents/org-v2/issues) - 已知问题

---

_最后更新：2026-06-13_  
_持续补充中，欢迎贡献你遇到的问题和解决方案_
