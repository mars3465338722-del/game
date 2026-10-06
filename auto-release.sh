#!/bin/bash
# auto-release.sh — 提交改动并自动打版本标签

# 进入项目目录（如果脚本放在项目里，可以省略）
cd /d/Vibecoding/a3

# 检查是否有改动
if git diff --quiet && git diff --cached --quiet; then
    echo "没有需要提交的改动"
    exit 0
fi

# 自动生成提交信息（可以结合 agent 的输出，这里用时间戳兜底）
MSG="${1:-auto: 更新于 $(date '+%Y-%m-%d %H:%M')}"

git add .
git commit -m "$MSG"

# 自动递增版本号：找最新的 v* tag，然后 patch +1
LAST_TAG=$(git describe --tags --abbrev=0 2>/dev/null || echo "v0.0.0")
echo "当前版本: $LAST_TAG"

# 解析 vX.Y.Z 并 patch +1
VERSION=${LAST_TAG#v}
MAJOR=$(echo $VERSION | cut -d. -f1)
MINOR=$(echo $VERSION | cut -d. -f2)
PATCH=$(echo $VERSION | cut -d. -f3)
NEW_PATCH=$((PATCH + 1))
NEW_TAG="v${MAJOR}.${MINOR}.${NEW_PATCH}"

git tag -a "$NEW_TAG" -m "自动发布 $NEW_TAG"
echo "✅ 已提交并打标签: $NEW_TAG"
git log --oneline -3