# Custom DevContainer Features

This repository contains custom [DevContainer Features](https://containers.dev/implementors/features/) to enhance your development environment using [Dev Containers](https://containers.dev/). These features help streamline container setup by installing essential tools and configurations out-of-the-box.

## Available Features

### 🔹 `nvim`

Installs the latest version of [Neovim](https://neovim.io/) within your development container.

- Adds Neovim to your container path
- Ensures runtime dependencies are installed

📄 [View README for `nvim`](./src/nvim/README.md)

---

### 🔹 `utils`

Creates a non-root user and installs common development utilities, such as:

- `curl`, `git`, `wget`, `unzip`, `sudo`, `ripgrep`, `fd`, `tmux`
- Adds a user with UID/GID and passwordless sudo access (if configured)

📄 [View README for `utils`](./src/utils/README.md)

---

## How to Use These Features

To use these features in your `.devcontainer/devcontainer.json` or `devcontainer-feature.json` file:

```json
{
  "features": {
    "ghcr.io/Diogo364/my-devcontainer-workflow/nvim:latest": {},
    "ghcr.io/Diogo364/my-devcontainer-workflow/utils:latest": {}
  }
}
```
