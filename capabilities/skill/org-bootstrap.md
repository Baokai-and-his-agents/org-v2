# Skill: org-bootstrap

**类型**：skill  
**创建**：2026-06-12  
**更新**：2026-06-12  
**复用次数**：1

---

## 🎯 用途

从零搭建一个 AI 原生组织的最小可运行系统

---

## 📥 输入

- 组织目标（一句话）
- Owner 信息（姓名、角色）
- 组织类型（一人公司 / 小团队）

---

## 📤 输出

完整的组织运营仓库，包含：
- 核心文件（NOW.md, owner.md, agent-protocol.md）
- 目录结构（control/, ops/, capabilities/, products/）
- 自动化脚本（周报生成）
- CI 检查（结构验证）

---

## 🔄 使用流程

1. **创建仓库**
   ```bash
   mkdir org-name && cd org-name
   git init
   ```

2. **创建核心目录**
   ```bash
   mkdir -p control ops/{scripts,logs,heartbeats,reports,decisions,escalations}
   mkdir -p capabilities/{skill,data,knowledge} products .github/workflows
   ```

3. **创建核心文件**（按检查清单）

4. **配置自动化**
   - 复制 weekly-report.sh
   - 配置 GitHub Actions

5. **初始提交**
   ```bash
   git add -A
   git commit -m "Initial commit: org bootstrap"
   ```

---

## ✅ 检查清单

### 核心文件
- [ ] README.md（极简入口，<50 行）
- [ ] NOW.md（单一工作台）
- [ ] control/owner.md（Owner 控制面板）
- [ ] ops/agent-protocol.md（Agent 工作协议）
- [ ] capabilities/INDEX.md（能力资产索引）
- [ ] capabilities/TEMPLATE.md（能力模板）
- [ ] products/portfolio.md（产品组合）
- [ ] ops/resource-requests.md（资源请求）

### 自动化
- [ ] ops/scripts/weekly-report.sh（周报生成）
- [ ] .github/workflows/check.yml（结构检查）
- [ ] .github/workflows/weekly-report.yml（自动周报）

### 目录结构
- [ ] control/（Owner 控制层）
- [ ] ops/（日常运营）
  - [ ] scripts/（脚本）
  - [ ] logs/（工作日志）
  - [ ] heartbeats/（巡检记录）
  - [ ] reports/（周报）
  - [ ] decisions/（决策记录）
  - [ ] escalations/（升级事项）
- [ ] capabilities/（能力资产）
  - [ ] skill/（工作方法）
  - [ ] data/（结构化事实）
  - [ ] knowledge/（经验案例）
- [ ] products/（产品索引）

---

## 📝 示例

### 成功案例

**组织**：org-v2（本仓库）

**输入**：
- 目标：建立可度量、可改进的 AI 原生组织
- Owner：Baokai
- 类型：一人公司

**输出**：
- 13 个核心文件
- 3 层目录结构
- 1 个自动化脚本
- 2 个 CI 检查

**时间**：30 分钟

---

## 🔗 相关能力

- data/org-structure-template（组织结构模板）
- knowledge/org-design-decisions（设计决策记录）

---

## 📌 维护说明

- 更新频率：每季度（或重大调整时）
- 负责人：Owner
- 模板位置：本 skill 作为模板

---

## 📊 使用记录

| 日期 | 组织 | 结果 | 备注 |
|------|------|------|------|
| 2026-06-12 | org-v2 | ✅ | 首次创建，约 30 分钟 |
