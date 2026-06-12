# Knowledge: 跨平台脚本兼容性

**类型**：knowledge  
**创建**：2026-06-12  
**更新**：2026-06-12  
**复用次数**：1

---

## 🎯 问题

Bash 脚本在 macOS 和 Linux 环境下的兼容性问题，特别是 `sed` 命令的差异。

---

## 📊 常见差异

### 1. sed -i 命令

**macOS（BSD sed）**：
```bash
sed -i '' 's/old/new/g' file.txt
```
需要空字符串 `''` 作为备份文件扩展名参数。

**Linux（GNU sed）**：
```bash
sed -i 's/old/new/g' file.txt
```
直接使用 `-i`，不需要额外参数。

### 2. date 命令

**macOS**：
```bash
date -v-7d +%Y-%m-%d  # 7 天前
```

**Linux**：
```bash
date -d '7 days ago' +%Y-%m-%d
```

### 3. find 命令

**macOS**：
```bash
find . -mtime -7  # 最近 7 天修改的文件
```

**Linux**：
```bash
find . -newermt '7 days ago'  # 或使用 -mtime
```

---

## 💡 通用解决方案

### 方案 1：OS 检测

```bash
#!/bin/bash

# 检测操作系统
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    IS_LINUX=true
elif [[ "$OSTYPE" == "darwin"* ]]; then
    IS_LINUX=false
else
    echo "Unsupported OS: $OSTYPE"
    exit 1
fi

# 根据 OS 使用不同命令
if [ "$IS_LINUX" = true ]; then
    sed -i 's/old/new/g' file.txt
else
    sed -i '' 's/old/new/g' file.txt
fi
```

### 方案 2：统一接口函数

```bash
# 跨平台 sed
portable_sed() {
    local pattern="$1"
    local file="$2"
    
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        sed -i "$pattern" "$file"
    else
        sed -i '' "$pattern" "$file"
    fi
}

# 使用
portable_sed 's/old/new/g' file.txt
```

### 方案 3：避免 -i，使用临时文件

```bash
# 跨平台通用方案
sed 's/old/new/g' file.txt > file.txt.tmp
mv file.txt.tmp file.txt
```

---

## ✅ 推荐做法

1. **优先使用方案 1（OS 检测）**
   - 明确、直观
   - 易于维护
   - 性能最好

2. **CI/CD 环境注意**
   - GitHub Actions 默认运行在 Ubuntu（Linux）
   - 本地开发可能在 macOS
   - 必须测试两个环境

3. **文档说明**
   - 在 README 说明兼容性
   - 示例使用哪个 OS
   - 已知限制

---

## 📝 实际案例

### 案例 1：duty-check.sh 修复

**问题**：脚本在 GitHub Actions（Linux）上失败

**原因**：
```bash
# macOS 写法
sed -i '' "s/pattern/replacement/g" file
```

**修复**：
```bash
if [ "$IS_LINUX" = true ]; then
    sed -i "s/pattern/replacement/g" file
else
    sed -i '' "s/pattern/replacement/g" file
fi
```

**结果**：✅ 两个平台都工作

---

## 🔗 相关能力

- skill/duty-check（使用了此 knowledge）
- skill/org-bootstrap（可能需要跨平台）

---

## 📚 参考资源

- GNU sed vs BSD sed 差异
- Bash OSTYPE 变量文档
- GitHub Actions Ubuntu 环境

---

## 📊 使用记录

| 日期 | 场景 | 结果 |
|------|------|------|
| 2026-06-12 | duty-check.sh Linux 兼容 | ✅ 修复成功 |
