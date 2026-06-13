#!/bin/bash
# 项目初始化指导

cat << 'WELCOME'
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 Welcome to org-v2!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

AI-Native Organization Framework
让 AI 协作更高效，能力沉淀更系统

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Quick Start (10 minutes):

1️⃣  读一读
   cat QUICKSTART.md

2️⃣  跑一跑
   bash ops/scripts/duty-check.sh

3️⃣  试一试
   bash ops/scripts/search-capability.sh "test"

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🎯 First Steps:

1. 查看当前状态
   bash ops/scripts/calculate-health-score.sh

2. 浏览现有能力
   ls capabilities/skill/
   ls capabilities/knowledge/

3. 创建第一个任务
   cp ops/tasks/TEMPLATE.md ops/tasks/001-my-first-task.md
   vim ops/tasks/001-my-first-task.md

4. 完成任务后沉淀能力
   cp capabilities/TEMPLATE.md capabilities/skill/my-first-skill.md
   vim capabilities/skill/my-first-skill.md

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📚 Learn More:

- FAQ: cat FAQ.md
- Tools: cat docs/TOOLS_QUICK_REFERENCE.md
- Examples: ls docs/examples/community-capabilities/
- Overview: cat docs/PROJECT_OVERVIEW.md

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🔧 Available Tools (17):

Capability Management (7):
  • export, import, search, check
  • usage stats, dependencies, heatmap

Reporting & Monitoring (7):
  • weekly/monthly reports, stats report
  • health score, duty check
  • contributor stats, release readiness

Testing (3):
  • unit, integration, performance

Run any tool:
  bash ops/scripts/<tool-name>.sh

See all: ls ops/scripts/

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

💡 Tips:

✅ Start simple - one task at a time
✅ Force capability deposition - ask "can I reuse this?"
✅ Link capabilities - use [[capability-name]] syntax
✅ Run tests often - bash ops/tests/test-capability-quality.sh
✅ Check health regularly - bash ops/scripts/calculate-health-score.sh

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🎊 You're Ready!

Start your first task and watch your capability library grow!

Need help? Check FAQ.md or open an issue on GitHub.

Happy building! 🚀

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
WELCOME
