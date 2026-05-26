{ config, pkgs, lib, ... }:

{
  home.stateVersion = "24.11";

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    bat
    cloc
    delta
    entr
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
    neovim
    python3
    ripgrep
    shellcheck
    tmux
    tree
    vim
    wdiff
    wget
    zsh
    lua-language-server
    lazygit
    nodejs_22
    opam
    go
    kubectl
    k9s
    cmake
    llvm
    lld
    trash-cli
    noti
    coreutils
    zoxide
  ];
}
