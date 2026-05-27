{ config, pkgs, lib, ... }:

# Editor / (neo)vim tooling: the editor itself, parsers, and language servers.
{
  home.packages = with pkgs; [
    neovim
    tree-sitter           # CLI + grammars for nvim-treesitter
    lua-language-server   # LSP for editing the nvim lua config
  ];
}
