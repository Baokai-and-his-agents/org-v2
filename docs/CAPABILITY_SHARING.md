# 能力共享指南

org-v2 支持跨项目能力共享，让不同组织实例之间可以学习和复用能力。

---

## 🎯 为什么需要能力共享

### 问题

每个 org-v2 实例独立积累能力，无法：
- 从其他组织学习
- 分享自己的最佳实践
- 避免重复造轮子

### 解决方案

**社区能力库** + **导入/导出机制**

---

## 📦 能力包格式

### 标准格式（YAML）

```yaml
# capability-package.yaml

metadata:
  name: "error-handling-patterns"
  version: "1.0.0"
  author: "your-org"
  description: "通用错误处理模式集合"
  tags: ["error", "handling", "debugging"]
  created: "2026-06-13"
  license: "MIT"
  
dependencies: []  # 依赖的其他能力包

capabilities:
  - type: skill
    path: skill/error-recovery.md
    content: |
      # Skill: 错误恢复流程
      
      **类型**：Skill
      ...
      
  - type: knowledge
    path: knowledge/common-error-patterns.md
    content: |
      # Knowledge: 常见错误模式
      
      **类型**：Knowledge
      ...

quality:
  rating: 5  # 1-5 星
  validation: "community"  # official/community/experimental
  usage_count: 42
  last_updated: "2026-06-13"
```

---

## 🔄 导出能力

### 使用脚本

```bash
# 导出单个能力
bash ops/scripts/export-capability.sh \
  --type skill \
  --name problem-driven-development \
  --output my-capability.yaml

# 导出整个类别
bash ops/scripts/export-capability.sh \
  --category skill \
  --output skills-bundle.yaml

# 导出所有能力
bash ops/scripts/export-capability.sh \
  --all \
  --output all-capabilities.yaml
```

### 输出文件

```
my-capability.yaml        # 单个能力包
├─ metadata
├─ capabilities
│  └─ skill/problem-driven-development.md
└─ quality
```

---

## 📥 导入能力

### 使用脚本

```bash
# 导入能力包
bash ops/scripts/import-capability.sh \
  --file community-capability.yaml \
  --dry-run  # 先预览

# 确认无误后实际导入
bash ops/scripts/import-capability.sh \
  --file community-capability.yaml
```

### 冲突处理

如果能力已存在：

```
⚠️ 冲突检测到：
  本地: skill/problem-driven-development.md (v1.0)
  导入: skill/problem-driven-development.md (v1.2)

选项：
1. 跳过（保留本地）
2. 覆盖（使用导入）
3. 重命名（保留两者）

请选择 [1/2/3]:
```

---

## 🌟 质量评级

### 评级标准

**⭐⭐⭐⭐⭐ 官方验证**
- org-v2 核心团队审核
- 广泛使用验证
- 完整文档和示例
- 长期维护

**⭐⭐⭐⭐ 社区验证**
- 多个组织使用
- 正面反馈多
- 文档完整
- 持续更新

**⭐⭐⭐ 实验性**
- 单一组织验证
- 基础文档
- 可能不稳定
- 需要改进

**⭐⭐ 草稿**
- 未经验证
- 文档不完整
- 仅供参考

**⭐ 存档**
- 已过时
- 不推荐使用

---

## 📚 社区能力库

### 目录结构

```
community-capabilities/
├── official/           # 官方验证能力
│   ├── skills/
│   ├── data/
│   └── knowledge/
├── community/          # 社区贡献能力
│   ├── by-domain/      # 按领域分类
│   │   ├── devops/
│   │   ├── data-science/
│   │   └── product/
│   └── by-author/      # 按作者分类
└── experimental/       # 实验性能力
```

### 浏览能力库

```bash
# 列出所有社区能力
bash ops/scripts/list-community-capabilities.sh

# 按类别筛选
bash ops/scripts/list-community-capabilities.sh --category skill

# 按评分筛选
bash ops/scripts/list-community-capabilities.sh --min-rating 4

# 搜索
bash ops/scripts/list-community-capabilities.sh --search "error"
```

---

## 🤝 贡献能力

### 贡献流程

1. **准备能力**
   ```bash
   # 确保能力质量合格
   bash ops/scripts/check-capabilities.sh
   ```

2. **导出能力**
   ```bash
   bash ops/scripts/export-capability.sh \
     --type skill \
     --name your-skill \
     --output contribution.yaml
   ```

3. **添加元数据**
   - 完善 description
   - 添加 tags
   - 选择 license
   - 提供使用示例

4. **提交 PR**
   - Fork org-v2 repo
   - 添加到 community-capabilities/
   - 创建 Pull Request
   - 等待审核

---

## 📊 能力使用追踪

### 本地追踪

每次导入能力时：

```yaml
# 记录在 capabilities/IMPORTED.md

## 导入记录

- **名称**: error-handling-patterns
- **来源**: community/by-domain/devops/
- **导入时间**: 2026-06-13
- **版本**: 1.0.0
- **作者**: awesome-org
- **使用次数**: 3
- **最后使用**: 2026-06-15
```

### 社区统计

定期分享：
- 热门能力（下载最多）
- 高评分能力（4-5 星）
- 新增能力

---

## 🔒 安全注意事项

### 导入前检查

1. **来源可信**
   - 官方库优先
   - 检查作者信誉
   - 查看使用数量

2. **内容审查**
   - 不包含恶意代码
   - 不暴露敏感信息
   - 符合你的标准

3. **许可证兼容**
   - 检查 license 字段
   - 确保可以使用
   - 遵守许可条款

### 隔离测试

```bash
# 在独立分支测试
git checkout -b test-import

# 导入并测试
bash ops/scripts/import-capability.sh --file test.yaml

# 验证无问题后合并
git checkout main
git merge test-import
```

---

## 💡 最佳实践

### 导出时

1. **完善文档**
   - 清晰的用途说明
   - 详细的使用示例
   - 已知限制

2. **通用化**
   - 移除组织特定信息
   - 参数化可配置项
   - 保持简洁

3. **版本管理**
   - 使用语义化版本
   - 记录变更历史
   - 保持向后兼容

### 导入时

1. **理解后使用**
   - 阅读完整文档
   - 理解适用场景
   - 测试后采用

2. **本地化调整**
   - 适配自己的流程
   - 调整为组织术语
   - 补充特定内容

3. **反馈改进**
   - 报告问题
   - 分享改进
   - 贡献回社区

---

## 🎓 示例场景

### 场景 1：导入官方 skill

```bash
# 1. 浏览官方能力
bash ops/scripts/list-community-capabilities.sh \
  --category skill --rating 5

# 2. 预览导入
bash ops/scripts/import-capability.sh \
  --file community-capabilities/official/skills/code-review.yaml \
  --dry-run

# 3. 确认导入
bash ops/scripts/import-capability.sh \
  --file community-capabilities/official/skills/code-review.yaml

# 4. 验证
ls capabilities/skill/code-review.md
```

### 场景 2：分享自己的 knowledge

```bash
# 1. 导出能力
bash ops/scripts/export-capability.sh \
  --type knowledge \
  --name deployment-lessons \
  --output my-deployment-knowledge.yaml

# 2. 添加元数据
# 编辑 my-deployment-knowledge.yaml
# 完善 description, tags, examples

# 3. 提交到社区
# Fork → Add to community/ → PR

# 4. 等待社区反馈
```

---

## 📝 路线图

### v1.0（当前）
- ✅ 能力包格式定义
- ✅ 导入/导出脚本
- ✅ 质量评级系统
- ✅ 社区库结构

### v1.1（计划）
- 📋 Web 浏览界面
- 📋 自动更新检查
- 📋 依赖管理
- 📋 版本兼容性检查

### v2.0（愿景）
- 📋 能力市场
- 📋 付费能力支持
- 📋 自动化测试
- 📋 使用分析

---

_最后更新：2026-06-13_  
_版本：1.0_
