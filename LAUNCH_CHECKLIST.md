# 发布检查清单

**版本**: v0.9.0 → v1.0.0  
**日期**: 待定

---

## ✅ 技术就绪（100%）

- [x] 20 个工具全部运行
- [x] 42 个测试全部通过
- [x] CI/CD 配置完成
- [x] 代码质量检查通过
- [x] 性能基准达标（137ms）

---

## ✅ 文档就绪（100%）

- [x] README 完整
- [x] QUICKSTART 清晰
- [x] FAQ 全面（40+ 问答）
- [x] 25 个文档完整
- [x] 工具文档齐全

---

## ✅ 社区就绪（100%）

- [x] CONTRIBUTING 指南
- [x] CODE_OF_CONDUCT
- [x] Issue 模板（3 个）
- [x] PR 模板
- [x] SECURITY 政策

---

## ⚠️ 市场准备（40%）

- [ ] 启用 GitHub Discussions
- [ ] 发布公告（HN/Twitter）
- [ ] 邀请 beta 用户（5-10）
- [ ] 准备演示视频
- [ ] 社交媒体账号

---

## 🎯 发布步骤

### 1. 最终检查

```bash
bash ops/scripts/check-release-readiness.sh
bash ops/tests/test-capability-quality.sh
bash ops/scripts/calculate-health-score.sh
```

### 2. 创建备份

```bash
bash ops/scripts/backup-project.sh backups/pre-launch
```

### 3. 版本升级

```bash
# 更新版本号
sed -i '' 's/v0.9.0/v1.0.0/g' README.md
git tag v1.0.0
git push --tags
```

### 4. 启用 Discussions

- GitHub → Settings → Features → Discussions ✓

### 5. 发布公告

**HN 标题**: "Show HN: org-v2 – AI-native organization framework"

**Twitter**: "🚀 Launched org-v2: Make AI collaboration 7x more efficient through forced capability deposition"

### 6. 邀请用户

- 发送邀请邮件给 5-10 个目标用户
- 附上 QUICKSTART 链接

---

## 📊 发布标准

### v1.0.0 标准

- [ ] 10+ GitHub stars
- [ ] 5+ active users
- [ ] 3+ contributors
- [ ] 1 success story
- [ ] User feedback collected

**预计时间**: 1-2 个月

---

## 🔄 发布后

### Week 1
- 监控用户反馈
- 回答 Issues
- 修复紧急 bugs

### Week 2-4
- 根据反馈迭代
- 完善文档
- 添加示例

### Month 2-3
- 稳定版本
- 准备 v1.5

---

**准备就绪，等待发布！** 🚀
