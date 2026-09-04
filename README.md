# opt-mgr

轻量级的 `/opt` 应用管理器，支持 GitHub 自动下载、解压安装与 COPR 打包。

## 特性

- 一键安装/更新：`tar.gz` / `jar` / `AppImage` / `rpm` / 二进制
- GitHub 集成：`--repo owner/repo --type` 自动匹配最新资产
- 架构自适应：`x86_64`/`amd64`、`aarch64`/`arm64` 同义匹配
- 桌面快捷方式、图标自动处理
- 批量检查/升级、回退、清理

## 安装

```bash
git clone https://github.com/Maomaokuxs/opt-mgr.git
cd opt-mgr
sudo ln -sf "$PWD/bin/opt-mgr" /usr/local/bin/opt-mgr
# 补全（可选）
sudo cp completions/bash/opt-mgr /usr/share/bash-completion/completions/opt-mgr
```

依赖：`bash`、`python3`、`curl`/`wget`

GitHub API 限流（60次/小时）建议配置 Token：
```bash
echo "ghp_xxx" > ~/.config/opt-mgr/github_token  # Fine-grained 无需勾选
```

## 用法

```
opt-mgr install  <应用名> [文件] [选项]     # 安装或更新
opt-mgr reinstall <应用名> [选项]            # 重装（保留配置）
opt-mgr remove   <应用名> [--purge]         # 卸载
opt-mgr conf     <应用名> --repo owner/repo [选项]  # 仅配置
opt-mgr list                                # 已管理应用
opt-mgr info     <应用名>                   # 详情 + 远端对比
opt-mgr check    [应用名]                   # 检查更新
opt-mgr upgrade  [应用名]                   # 升级
opt-mgr build    <应用名> [--repo] [--type 类型] [选项]  # 构建 COPR RPM
opt-mgr rollback <应用名>                   # 回退
```

**通用选项**（`install`/`conf`/`build`）：

- `--repo owner/repo` — GitHub 仓库
- `--type tar|jar|appimage|rpm` — 文件类型
- `--pattern 模式` — asset 匹配（默认按架构）
- `--icon 路径|URL` — 图标
- `--exec 前缀` — Exec 前缀，`{}` 占位

**支持类型：**

- `.tar.gz` / `.tgz` → 解压到 `/opt/<应用名>/`
- `.jar` → `java -jar` 启动
- `.rpm` → `dnf` 安装
- `.AppImage` → 复制到 `/opt/<应用名>/`
- 其他二进制 → 同上

## 示例

```bash
# 自动下载安装
opt-mgr install kazumi --repo Predidit/Kazumi --type tar

# 本地文件 + 图标 + 自定义启动
opt-mgr install hmcl ~/Downloads/HMCL-3.15.1.jar \
  --repo HMCL-dev/HMCL --icon ~/Downloads/hmcl.png \
  --exec 'java -Dglass.gtk.uiScale=1.5 -jar {}'

# 仅配置仓库
opt-mgr conf splayer --repo SPlayer-Dev/SPlayer --type rpm

# 批量升级
opt-mgr check
opt-mgr upgrade
```

## 目录

```
bin/opt-mgr                 # 主程序
completions/bash/opt-mgr    # bash 补全
```

## 许可

MIT
