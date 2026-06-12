# 社区能力示例

这里展示如何在实际项目中使用 org-v2 的能力管理系统。

**更新**：2026-06-13

---

## 📚 示例列表

### 1. [API 开发工作流](api-development-workflow.md)
**场景**：RESTful API 标准开发流程  
**适用**：后端开发团队

**包含**：
- OpenAPI 规范设计
- 端点实现
- 测试策略
- 文档生成
- 能力沉淀

**价值**：标准化 API 开发，提升质量

---

### 2. [数据库迁移工作流](database-migration-workflow.md)
**场景**：生产数据库安全迁移  
**适用**：运维团队、DBA

**包含**：
- 迁移计划
- 测试验证
- 回滚脚本
- 生产执行
- 监控策略

**价值**：高风险操作的安全流程，零事故

---

### 3. [代码审查检查清单](code-review-checklist.md)
**场景**：Pull Request 代码审查  
**适用**：所有开发团队

**包含**：
- 功能正确性（4 项）
- 代码质量（4 项）
- 测试覆盖（4 项）
- 文档更新（4 项）
- 安全性（5 项）
- 性能（4 项）

**价值**：标准化审查流程，提升代码质量

---

### 4. [测试策略](testing-strategy.md)
**场景**：建立完整测试体系  
**适用**：所有开发团队

**包含**：
- 单元测试（70%）
- 集成测试（20%）
- 性能测试（10%）
- CI 集成
- 测试金字塔原则

**价值**：系统化测试方法，100% 通过率

---

### 5. [文档编写工作流](documentation-workflow.md)
**场景**：建立完整文档体系  
**适用**：所有开源项目、产品团队

**包含**：
- README 黄金法则
- QUICKSTART 结构
- FAQ 编写
- 文档维护策略
- 更新频率指南

**价值**：降低 80% 支持请求，提升 3 倍留存

---

## 🎯 如何使用这些示例

### Step 1: 阅读示例
浏览完整工作流，了解每个步骤

### Step 2: 复制到项目
将能力复制到你的 `capabilities/` 目录

```bash
# 示例：复制 API 开发工作流
cp docs/examples/community-capabilities/api-development-workflow.md \
   capabilities/skill/api-development.md
```

### Step 3: 按需调整
根据团队实际情况修改

- 调整步骤顺序
- 添加团队特定要求
- 修改工具选择

### Step 4: 持续改进
使用后根据反馈优化

```bash
# 更新复用次数
vim capabilities/skill/api-development.md
# 修改：复用次数：1 → 2
```

---

## 💡 贡献你的能力示例

欢迎分享你的能力！

### 什么是好的示例？

✅ **真实场景**：团队常遇到的问题  
✅ **完整流程**：从开始到结束  
✅ **可执行**：包含实际代码/命令  
✅ **有价值**：解决痛点，提升效率

### 贡献步骤

1. **Fork 仓库**
   ```bash
   git clone https://github.com/your-username/org-v2.git
   ```

2. **创建示例**
   ```bash
   # 使用模板
   cp docs/examples/community-capabilities/TEMPLATE.md \
      docs/examples/community-capabilities/your-example.md
   
   # 编写内容
   vim docs/examples/community-capabilities/your-example.md
   ```

3. **更新索引**
   在本 README 添加你的示例

4. **提交 PR**
   ```bash
   git add .
   git commit -m "Add example: Your Example Name"
   git push
   ```

5. **等待 review**
   维护者会审查并合并

### 示例模板结构

```markdown
# 社区能力示例：[名称]

**贡献者**：你的名字  
**场景**：什么场景  
**适用**：什么团队

---

## 🎯 用途
一句话说明

## 📋 工作流步骤
详细步骤 + 代码示例

## 💡 复用价值
为什么有用

## 📊 实际效果
数据验证（如有）

## 🔗 相关能力
链接到相关能力
```

---

## 📊 示例统计

- **总数**：5 个
- **覆盖领域**：开发、运维、质量、文档
- **贡献者**：org-v2 团队（欢迎社区贡献）
- **最后更新**：2026-06-13

---

## 🎓 学习路径

**新手**：
1. 阅读 [代码审查检查清单](code-review-checklist.md)（最简单）
2. 尝试 [文档编写工作流](documentation-workflow.md)（立即可用）

**进阶**：
3. 学习 [API 开发工作流](api-development-workflow.md)（标准流程）
4. 掌握 [测试策略](testing-strategy.md)（质量保障）

**高级**：
5. 实践 [数据库迁移工作流](database-migration-workflow.md)（高风险操作）

---

## 🔗 相关资源

- [能力模板](../../../capabilities/TEMPLATE.md) - 创建能力的标准格式
- [贡献指南](../../../CONTRIBUTING.md) - 如何贡献
- [最佳实践](../../BEST_PRACTICES.md) - 使用建议

---

## ❓ 常见问题

### Q1: 这些示例可以直接用吗？

可以，但建议根据你的实际情况调整。

### Q2: 如何贡献新示例？

按照上面的"贡献步骤"操作，欢迎提 PR！

### Q3: 示例会更新吗？

会。我们会根据反馈持续改进。

### Q4: 能否用于商业项目？

可以，MIT License 允许商业使用。

---

**社区贡献让 org-v2 更强大！** 🌟

期待你的能力示例！
