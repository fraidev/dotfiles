{ pkgs, ... }:

# macOS-only CLI extras. GUI apps live in gui.nix.
{
  home.packages = with pkgs; [
    lima
  ];
}
