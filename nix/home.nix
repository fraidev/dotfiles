{ config, pkgs, lib, ... }:

let
  # Absolute path to this dotfiles checkout on the real filesystem.
  dotfiles = "${config.home.homeDirectory}/dotfiles";
  # Live symlink straight back into the repo (edits apply without a rebuild),
  # mirroring the old `install.sh link` behaviour.
  link = path: config.lib.file.mkOutOfStoreSymlink "${dotfiles}/${path}";
in
{
  imports = [ ./editor.nix ];

  home.stateVersion = "24.11";

  programs.home-manager.enable = true;

  # *.symlink files -> ~/.<name>  (was: find -name '*.symlink' in install.sh)
  home.file = {
    ".zshrc".source = link "zsh/zshrc.symlink";
    ".zshenv".source = link "zsh/zshenv.symlink";
    ".zprofile".source = link "zsh/zprofile.symlink";
    ".tmux.conf".source = link "tmux/tmux.conf.symlink";
    ".gitconfig".source = link "git/gitconfig.symlink";
    ".gitignore_global".source = link "git/gitignore_global.symlink";
    ".rgrc".source = link "rgrc.symlink";
  };

  # config/* dirs -> ~/.config/<name>  (was: symlink config/* in install.sh)
  xdg.configFile = {
    "nvim".source = link "config/nvim";
    "wezterm".source = link "config/wezterm";
    "alacritty".source = link "config/alacritty";
    "ghostty".source = link "config/ghostty";
    "kitty".source = link "config/kitty";
    "rio".source = link "config/rio";
  };

  home.packages = with pkgs; [
    bat
    cloc
    fd
    fzf
    gh
    git
    gnupg
    gnugrep
    gnused
    highlight
    htop
    jq
    fastfetch
    python3
    ripgrep
    shellcheck
    tmux
    tree
    wdiff
    wget
    zsh
    lazygit
    nodejs_24
    beam27Packages.erlang
    beam27Packages.elixir_1_20
    go
    kubectl
    k9s
    postgresql
    cmake
    llvm
    lld
    coreutils
    # localstack
    ngrok
    parallel
    ffmpeg
    uv
    rtk
  ];
}
