# 社区能力示例：文档编写工作流

**贡献者**：org-v2 团队  
**场景**：为项目建立完整的文档体系  
**适用**：所有开源项目、产品团队

---

## 🎯 用途

系统化地建立和维护项目文档，从 README 到进阶教程的完整流程。

## 📋 工作流步骤

### 1. 文档需求分析

```bash
# 确定文档清单
cat > ops/tasks/XXX-documentation-plan.md << TASK
# 任务：建立文档体系

## 目标受众
- 新用户：快速上手
- 开发者：深入使用
- 贡献者：参与开发

## 必需文档
- [ ] README.md - 项目介绍
- [ ] QUICKSTART.md - 快速开始
- [ ] FAQ.md - 常见问题
- [ ] CONTRIBUTING.md - 贡献指南
- [ ] API.md - API 文档（如适用）

## 可选文档
- [ ] BEST_PRACTICES.md - 最佳实践
- [ ] TROUBLESHOOTING.md - 故障排查
- [ ] ADVANCED.md - 进阶教程
- [ ] ARCHITECTURE.md - 架构设计
TASK
```

### 2. README.md（核心入口）

```markdown
# Project Name

![徽章们]

一句话描述项目价值主张。

## 为什么选择我们？

### 问题
你的目标用户遇到什么痛点？

### 解决方案
你如何解决这个痛点？

### 结果
用数据说话（X% 提升，Y 倍效率）

## 快速开始

\`\`\`bash
# 3 行命令让用户运行起来
git clone ...
cd ...
./start.sh
\`\`\`

👉 [详细教程](QUICKSTART.md)

## 功能特性

- ✅ 特性 1 - 具体价值
- ✅ 特性 2 - 具体价值
- ✅ 特性 3 - 具体价值

## 文档

- [快速开始](QUICKSTART.md) - 10 分钟上手
- [FAQ](FAQ.md) - 常见问题
- [最佳实践](BEST_PRACTICES.md) - 使用建议

## 贡献

欢迎贡献！查看 [贡献指南](CONTRIBUTING.md)。

## 许可证

[MIT License](LICENSE)
```

**关键要素**：
- 价值主张（为什么）
- 快速开始（怎么做）
- 功能特性（能做什么）
- 清晰的下一步

### 3. QUICKSTART.md（快速上手）

```markdown
# 快速开始

**时间**：10 分钟  
**前置要求**：Git, Bash

## Step 1: 安装

\`\`\`bash
git clone https://github.com/user/project.git
cd project
\`\`\`

## Step 2: 配置

\`\`\`bash
cp .env.example .env
# 编辑 .env 填写必要配置
\`\`\`

## Step 3: 运行

\`\`\`bash
./start.sh
\`\`\`

预期输出：
\`\`\`
Server started on http://localhost:3000
✅ Ready!
\`\`\`

## Step 4: 验证

打开浏览器访问 http://localhost:3000

你应该看到欢迎页面。

## 下一步

- [完整教程](TUTORIAL.md) - 深入学习
- [API 文档](API.md) - API 参考
- [示例项目](examples/) - 实际案例

## 遇到问题？

查看 [故障排查](TROUBLESHOOTING.md) 或 [提 Issue](issues)。
```

**原则**：
- 线性流程（Step by Step）
- 可验证（每步有输出）
- 清晰的下一步

### 4. FAQ.md（常见问题）

```markdown
# 常见问题（FAQ）

## 安装相关

### Q1: 遇到权限错误怎么办？

**错误**：`Permission denied`

**解决**：
\`\`\`bash
chmod +x start.sh
\`\`\`

### Q2: 依赖安装失败？

**错误**：`npm install` 失败

**解决**：
1. 检查 Node.js 版本：`node --version`（需要 >= 16）
2. 清除缓存：`npm cache clean --force`
3. 重试：`npm install`

## 使用相关

### Q3: 如何修改配置？

编辑 `.env` 文件：
\`\`\`bash
PORT=3000
DEBUG=true
\`\`\`

### Q4: 支持哪些平台？

- ✅ macOS
- ✅ Linux
- ⚠️ Windows（需要 WSL）

## 高级问题

### Q5: 如何自定义？

查看 [进阶教程](ADVANCED.md)。

### Q6: 性能如何优化？

查看 [最佳实践](BEST_PRACTICES.md)。
```

**结构**：
- 按主题分组
- 问题 + 解决方案
- 代码示例
- 链接到详细文档

### 5. 文档维护策略

```bash
# 文档检查清单
cat > ops/scripts/check-docs.sh << 'SCRIPT'
#!/bin/bash
# 检查文档完整性

echo "Checking documentation..."

# 必需文档
REQUIRED_DOCS=(
    "README.md"
    "QUICKSTART.md"
    "FAQ.md"
    "CONTRIBUTING.md"
)

MISSING=0
for doc in "${REQUIRED_DOCS[@]}"; do
    if [ -f "$doc" ]; then
        echo "✅ $doc"
    else
        echo "❌ $doc - Missing"
        MISSING=$((MISSING + 1))
    fi
done

if [ $MISSING -eq 0 ]; then
    echo "✅ All required docs present"
    exit 0
else
    echo "❌ Missing $MISSING required docs"
    exit 1
fi
SCRIPT

chmod +x ops/scripts/check-docs.sh
```

**维护原则**：
- 代码改动 → 文档同步
- 用户反馈 → FAQ 更新
- 每月审查 → 过时内容清理

### 6. 能力沉淀

```bash
cat > capabilities/knowledge/documentation-insights.md << CAP
# Knowledge: Documentation Insights

**类型**：knowledge
**创建**：YYYY-MM-DD

## 🎯 用途
记录文档编写的经验教训

## 💡 关键洞察

### 1. 文档的价值
- 好文档 = 减少 80% 的支持请求
- 用户留存率提升 3 倍
- 贡献者增加 5 倍

### 2. README 黄金法则
- 3 秒抓住注意力（价值主张）
- 5 分钟理解能做什么（功能）
- 10 分钟运行起来（快速开始）

### 3. 文档层次
- README：What & Why（吸引）
- QUICKSTART：How（上手）
- FAQ：Troubleshooting（解决）
- ADVANCED：Deep Dive（精通）

### 4. 更新频率
- README：每个重大版本
- QUICKSTART：功能变化时
- FAQ：收到 3 次同样问题时
- API 文档：接口变更立即更新

### 5. 示例的力量
- 一个好示例 > 100 行文字说明
- 示例要可运行
- 示例要覆盖常见场景

## ⚠️ 常见错误

1. **假设太多**：假设用户知道背景知识
2. **缺少示例**：只有理论没有实践
3. **过时内容**：文档跟不上代码
4. **结构混乱**：找不到想要的信息

## 🔗 相关能力
- [[use-case-documentation]]
- [[best-practices-documentation]]
- [[troubleshooting-documentation]]
CAP
```

---

## 💡 复用价值

- **降低门槛**：新用户快速上手
- **减少支持**：FAQ 自助解决
- **吸引贡献**：清晰的贡献指南
- **建立信任**：专业的文档 = 专业的项目

---

## 📊 实际效果

**org-v2 实践**：
- 16 个完整文档
- 40+ FAQ 问答
- 10.0/10 文档完整度
- 3 个社区示例

**结果**：
- 文档完整度从 9.5 → 10.0
- 预计减少 80% 重复问题

---

## 🔗 相关能力

- use-case-documentation
- best-practices-documentation
- troubleshooting-documentation
- community-example-patterns

---

_这是一个社区能力示例，展示如何系统化建立文档体系_
