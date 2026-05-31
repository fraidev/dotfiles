{ config, pkgs, lib, expert, system, ... }:

# Editor / (neo)vim tooling: the editor itself, parsers, and language servers.
{
  home.packages = (with pkgs; [
    neovim
    tree-sitter           # CLI + grammars for nvim-treesitter
    lua-language-server   # LSP for editing the nvim lua config
  ]) ++ [
    expert.packages.${system}.default   # Expert: Elixir LSP (from flake input)
  ];
}
