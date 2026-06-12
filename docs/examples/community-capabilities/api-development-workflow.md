# 社区能力示例：API 开发工作流

**贡献者**：org-v2 团队  
**场景**：RESTful API 开发的标准流程  
**适用**：后端开发团队

---

## 🎯 用途

标准化 API 开发流程，从设计到部署的完整工作流。

## 📋 工作流步骤

### 1. API 设计（Design）

```bash
# 创建任务
cat > ops/tasks/XXX-api-design.md << TASK
# 任务：设计用户 API

**目标**：设计 RESTful 用户管理 API

## 输入
- 业务需求文档
- 数据模型设计

## 输出
- OpenAPI 规范文件
- API 设计文档

## 验收标准
- OpenAPI 3.0 格式
- 包含所有 CRUD 端点
- 包含错误响应
TASK
```

### 2. API 实现（Implement）

```bash
# 实现 API
# 根据 OpenAPI 规范实现端点
# 编写单元测试

# 验证
npm test  # 或其他测试命令
```

### 3. API 文档（Document）

```bash
# 生成文档
npx redoc-cli bundle openapi.yaml -o docs/api.html

# 或使用 Swagger UI
npx swagger-ui-watcher openapi.yaml
```

### 4. API 测试（Test）

```bash
# 集成测试
newman run postman-collection.json

# 性能测试
ab -n 1000 -c 10 http://localhost:3000/api/users
```

### 5. 能力沉淀（Deposit）

```bash
# 沉淀可复用能力
cat > capabilities/skill/api-development.md << CAP
# Skill: API Development Workflow

**类型**：skill
**创建**：YYYY-MM-DD

## 🎯 用途
RESTful API 标准开发流程

## 📥 输入
- 需求文档
- 数据模型

## 📤 输出
- OpenAPI 规范
- 实现代码
- 测试用例
- API 文档

## 🔄 步骤
1. 设计 API（OpenAPI）
2. 实现端点
3. 编写测试
4. 生成文档
5. 性能验证
CAP
```

---

## 💡 复用价值

- **标准化**：团队统一流程
- **质量保障**：每步都有验证
- **文档同步**：代码即文档
- **持续改进**：流程可迭代

---

## 🔗 相关能力

- problem-driven-development
- quality-check-automation
- milestone-review-process

---

_这是一个社区能力示例，展示如何在实际项目中应用 org-v2_
