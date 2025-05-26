# 🧩 Custom Utils DevContainer Feature

This [DevContainer Feature](https://containers.dev/implementors/features/) installs a set of common development utilities and optionally configures a non-root user, making your development environment ready-to-go for a variety of workflows.

## 🔧 What It Does

- Optionally upgrades system packages (`apt upgrade`)
- Installs useful CLI tools like `fd`, `ripgrep`, `tmux`, and `npm`
- Creates a non-root user with configurable UID/GID

## 🛠️ Options

| Option            | Type    | Default        | Description                                                                     |
| ----------------- | ------- | -------------- | ------------------------------------------------------------------------------- |
| `upgradePackages` | boolean | `true`         | Whether to upgrade all OS packages (`apt upgrade`).                             |
| `username`        | string  | `devcontainer` | Name of the non-root user to create. Use `"none"` to skip user creation.        |
| `userUid`         | string  | `1001`         | UID for the non-root user.                                                      |
| `userGid`         | string  | `1001`         | GID for the non-root user.                                                      |
| `installFD`       | boolean | `true`         | Install [`fd`](https://github.com/sharkdp/fd), a simple, fast file finder.      |
| `installRG`       | boolean | `true`         | Install [`ripgrep`](https://github.com/BurntSushi/ripgrep), a line search tool. |
| `installNPM`      | boolean | `true`         | Install Node.js and `npm`.                                                      |
| `installTMUX`     | boolean | `true`         | Install [`tmux`](https://github.com/tmux/tmux), a terminal multiplexer.         |

## 🚀 Example Usage

Include this feature in your `.devcontainer/devcontainer.json`:

```json
{
  "features": {
    "ghcr.io/your-org-or-username/custom-devcontainer-features/utils:latest": {
      "upgradePackages": true,
      "username": "devcontainer",
      "userUid": "1001",
      "userGid": "1001",
      "installFD": true,
      "installRG": true,
      "installNPM": true,
      "installTMUX": true
    }
  }
}
```
