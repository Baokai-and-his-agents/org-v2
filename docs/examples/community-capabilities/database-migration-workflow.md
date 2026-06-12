# 社区能力示例：数据库迁移工作流

**贡献者**：org-v2 团队  
**场景**：生产数据库迁移的安全流程  
**适用**：运维团队、DBA

---

## 🎯 用途

安全执行生产数据库迁移，包含完整的回滚计划。

## 📋 工作流步骤

### 1. 迁移计划（Plan）

```bash
# 创建迁移任务
cat > ops/tasks/XXX-db-migration.md << TASK
# 任务：用户表添加邮箱字段

## 背景
- 新功能需要邮箱验证
- 影响 100 万用户记录

## 迁移步骤
1. 添加 email 字段（可空）
2. 批量填充历史数据
3. 添加唯一索引
4. 修改字段为非空

## 风险
- 大表操作可能锁表
- 索引创建耗时

## 回滚计划
1. 删除索引
2. 删除字段
TASK
```

### 2. 测试环境验证（Test）

```bash
# 在测试环境执行
mysql -h test-db < migration-001.sql

# 验证数据
mysql -h test-db -e "SELECT COUNT(*) FROM users WHERE email IS NULL"

# 性能测试
mysqlslap --query="SELECT * FROM users WHERE email = 'test@example.com'" --concurrency=50 --iterations=100
```

### 3. 创建回滚脚本（Rollback）

```sql
-- rollback-001.sql
DROP INDEX idx_users_email ON users;
ALTER TABLE users DROP COLUMN email;
```

### 4. 生产执行（Execute）

```bash
# 在维护窗口执行
# 1. 备份
mysqldump users > backup-users-$(date +%Y%m%d).sql

# 2. 执行迁移
mysql -h prod-db < migration-001.sql

# 3. 验证
mysql -h prod-db -e "SHOW CREATE TABLE users"

# 4. 监控
watch -n 1 'mysql -h prod-db -e "SHOW PROCESSLIST"'
```

### 5. 能力沉淀（Deposit）

```bash
cat > capabilities/skill/database-migration.md << CAP
# Skill: Safe Database Migration

**类型**：skill
**创建**：YYYY-MM-DD

## 🎯 用途
生产数据库安全迁移流程

## 📥 输入
- 迁移需求
- 数据量估算

## 📤 输出
- 迁移脚本
- 回滚脚本
- 验证结果

## 🔄 步骤
1. 编写迁移计划
2. 测试环境验证
3. 创建回滚脚本
4. 生产备份
5. 执行迁移
6. 验证结果
7. 监控性能

## ⚠️ 注意
- 永远先备份
- 永远有回滚计划
- 大表操作分批次
- 维护窗口执行
CAP
```

---

## 💡 关键原则

1. **永远先备份**
2. **永远有回滚计划**
3. **测试环境先验证**
4. **生产操作要监控**

---

_这是一个社区能力示例，展示高风险操作的标准流程_
