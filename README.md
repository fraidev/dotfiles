# Dotfiles

Cross-platform dotfiles for macOS and Linux. Packages managed by [Nix](https://nixos.org/) + [home-manager](https://github.com/nix-community/home-manager). No Homebrew, no apt.

![capture-demo](https://user-images.githubusercontent.com/25258368/181651042-ea7520e3-deb1-4a0e-858e-0a17f6d2ba5f.png)

## Layout

| Path | Purpose |
| --- | --- |
| `flake.nix` | Entry point — exposes `homeConfigurations.frai-mac` (aarch64-darwin) and `homeConfigurations.frai-linux` (x86_64-linux). |
| `nix/home.nix` | Shared CLI package list + home-manager settings. |
| `nix/darwin.nix` | macOS-only CLI extras (e.g. `lima`). |
| `nix/gui.nix` | macOS GUI apps + fonts (wezterm, obsidian, postman, ghidra). |
| `nix/linux.nix` | Linux-only extras (e.g. `xclip`). |
| `install.sh` | Bootstrap: installs Nix, runs home-manager switch, symlinks `*.symlink` files + `config/*`, applies macOS defaults. |
| `*.symlink`, `config/*` | Dotfiles symlinked into `$HOME` / `$HOME/.config` by `install.sh link`. |

## Install

```bash
xcode-select --install   # macOS only
git clone https://github.com/<you>/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh all
```

`install.sh all` runs, in order: `nix → home → link → terminfo → macos → rust → shell → git`.

## Sub-commands

```bash
./install.sh nix         # install Nix (Determinate installer)
./install.sh home        # nix run home-manager -- switch --flake .#felipe-{mac,linux}
./install.sh link        # symlink *.symlink → $HOME, config/* → ~/.config
./install.sh macos       # apply macOS defaults (Finder, key repeat, etc.)
./install.sh terminfo    # install tmux + xterm-256color-italic terminfo entries
./install.sh shell       # chsh to nix-provided zsh
./install.sh git         # write ~/.gitconfig-local
./install.sh rust        # install rustup (not in nixpkgs by design)
```

## Updating packages

Edit `nix/home.nix` (or `nix/darwin.nix` / `nix/gui.nix` / `nix/linux.nix`), then:

```bash
nix run home-manager/master -- switch --flake .#frai-mac     # macOS
nix run home-manager/master -- switch --flake .#frai-linux   # Linux
```

To bump pinned nixpkgs:

```bash
nix flake update
```

## GUI apps (macOS)

GUI apps and fonts live in `nix/gui.nix` and are only pulled in by `frai-mac`.
Linux (`frai-linux`) stays CLI-only.
