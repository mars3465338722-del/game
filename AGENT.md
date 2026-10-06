# Agent 工作规范

## 项目位置
D:\Vibecoding\a3

## 每次修改代码后必须执行

1. 确认改动完成、无语法错误
2. 在终端运行自动发布脚本（用 bash 的绝对路径）：
   D:\Git\bin\bash.exe auto-release.sh "简要描述本次改动"
3. 脚本会自动完成：git add → commit → 打递增版本标签
4. 完成后汇报：本次版本号、改动了哪些文件

## 禁止事项
- 不要手动 git push（未配置远程仓库）
- 不要修改 auto-release.sh 本身
- 不要删除 .git 目录

## 项目简介
纯 HTML/CSS/JS 浏览器小游戏，入口 index.html，资源在 assets/。