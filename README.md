# 横版卷轴动作游戏原型

单文件 HTML5 横版卷轴动作游戏原型：全部标记、样式与游戏逻辑写在一个 `index.html` 里，动画素材放在 `assets/` 下。

## 文件结构

```
assets/
├── player/                     # 玩家动画帧（子目录名 = 动作，1.png~N.png = 帧号）
│   ├── idle/                   # 待机
│   ├── walk/                   # 行走
│   ├── run/                    # 奔跑
│   ├── attack1/                # 攻击 1
│   ├── attack2/                # 攻击 2
│   ├── attack3/                # 攻击 3
│   ├── hurt/                   # 受击
│   ├── die/                    # 死亡
│   └── trans_idle_to_run/      # 待机→奔跑 过渡
├── enemies/
│   └── minotaur/               # 敌人（牛头怪）动画帧
│       ├── walk/               # 巡逻
│       ├── attack/             # 攻击
│       ├── hurt/               # 受击
│       └── die/                # 死亡
└── background/                 # 三层视差背景
    ├── bg_far.png              # 远景层
    ├── bg_mid.png              # 中景层
    └── bg_near.png             # 近景层
```

项目根目录：`index.html`（整个游戏：标记 + 样式 + 逻辑）+ `assets/`（素材）。

## 素材规格

玩家（帧号从 1.png 开始）：

| 动作 | 帧数 |
|---|---|
| idle | 8 |
| walk | 13 |
| run | 10 |
| attack1 | 12 |
| attack2 | 6 |
| attack3 | 8 |
| hurt | 4 |
| die | 10 |
| trans_idle_to_run | 3 |

敌人 minotaur：

| 动作 | 帧数 |
|---|---|
| walk | 6 |
| attack | 5 |
| hurt | 4 |
| die | 7 |

背景：三层图均为 2720×1152，各层在画布上横向循环平铺、无缝拼接。

## 操作说明

| 按键 | 功能 |
|---|---|
| A / D（或 ← / →） | 向左 / 向右移动 |
| 空格（或 ↑ / W） | 跳跃 |
| J / K / L | 攻击 1 / 攻击 2 / 攻击 3 |
| ~ | 切换调试模式 |
| R | 相机立刻对准玩家（调试用） |

## 关键参数

| 参数 | 值 | 说明 |
|---|---|---|
| 画布分辨率 | 1920 × 1080 | `CANVAS_W` / `CANVAS_H`，CSS 按 16:9 缩放到视口 |
| GROUND_Y | 540 | 平台顶面（`DEBUG.platformY`），角色站立线 |
| PLAYER_SCALE | 0.32 | 玩家帧（1024px）缩放后绘制高约 328px |
| ENEMY_SCALE | 0.32 | 敌人帧同样按 0.32 缩放 |
| WORLD_W | 2550 px | 世界宽，由 bg_near 原始宽 2720 按 1080 高比例得出；加载失败时兜底 4000 |
| 视差速度 | far 0.25 / mid 0.55 / near 1.0 | 各背景层随相机滚动的速度系数 |

## 运行方式

在项目根目录启动本地 HTTP 服务器，然后浏览器打开 `http://127.0.0.1:8000`：

- `python -m http.server 8000`
- 或 `npx serve`

不要直接双击 `index.html`：`file://` 协议下素材加载会失败。
