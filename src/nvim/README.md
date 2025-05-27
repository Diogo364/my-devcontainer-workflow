
# Neovim (nvim)

A feature to install Neovim building from source

## Example Usage

```json
"features": {
    "ghcr.io/Diogo364/my-devcontainer-workflow/nvim:0": {}
}
```

## Options

| Options Id | Description | Type | Default Value |
|-----|-----|-----|-----|
| nvimCloneConfig | Flag if should clone neovim configuration repo | boolean | true |
| nvimConfigRepo | URL to neovim configuration | string | https://github.com/Diogo364/my-nvim.git |
| nvimConfigBranch | Branch to fetch neovim configuration | string | lean |
| home | User HOME path | string | /root |
| nvimInstaller | Link to tar.gz neovim installer. | string | https://github.com/neovim/neovim/releases/download/v0.10.4/nvim-linux-x86_64.tar.gz |



---

_Note: This file was auto-generated from the [devcontainer-feature.json](https://github.com/Diogo364/my-devcontainer-workflow/blob/main/src/nvim/devcontainer-feature.json).  Add additional notes to a `NOTES.md`._
