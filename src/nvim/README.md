# 🧩 Neovim DevContainer Feature

This [DevContainer Feature](https://containers.dev/implementors/features/) installs [Neovim](https://neovim.io/) from a specified tarball release and optionally clones a custom Neovim configuration.

## 🔧 What It Does

- Downloads and installs Neovim from a tar.gz archive.
- Optionally clones your Neovim configuration from a remote repository.
- Sets up Neovim in the specified user's `$HOME` directory.

## 🛠️ Options

| Option             | Type    | Default                                                                               | Description                                                |
| ------------------ | ------- | ------------------------------------------------------------------------------------- | ---------------------------------------------------------- |
| `nvimCloneConfig`  | boolean | `true`                                                                                | Whether to clone a Neovim configuration repository.        |
| `nvimConfigRepo`   | string  | `https://github.com/Diogo364/my-nvim.git`                                             | Git URL of the Neovim configuration to clone.              |
| `nvimConfigBranch` | string  | `lean`                                                                                | Branch to checkout in the Neovim configuration repository. |
| `home`             | string  | `/root`                                                                               | Target home directory where config should be cloned.       |
| `nvimInstaller`    | string  | `https://github.com/neovim/neovim/releases/download/v0.10.4/nvim-linux-x86_64.tar.gz` | URL of the Neovim tar.gz release to install.               |

## 🚀 Example Usage

Include this feature in your `.devcontainer/devcontainer.json`:

```json
{
  "features": {
    "ghcr.io/your-org-or-username/custom-devcontainer-features/nvim:latest": {
      "nvimCloneConfig": true,
      "nvimConfigRepo": "https://github.com/Diogo364/my-nvim.git",
      "nvimConfigBranch": "lean",
      "home": "/root",
      "nvimInstaller": "https://github.com/neovim/neovim/releases/downloa

```
