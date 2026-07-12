{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    # GUI apps available in nixpkgs (Mac .app bundles)
    wezterm
    obsidian
    postman
    # scroll-reverser
    # rectangle
    # claude-code
    #karabiner-elements
    #wireshark
    #pgadmin4

    # Fonts (auto-linked to ~/Library/Fonts by home-manager on darwin)
    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono
    nerd-fonts.iosevka-term
    nerd-fonts._3270
    cascadia-code
  ];

  # Symlink .app bundles from nix store into ~/Applications/Nix Apps so
  # Spotlight, Launchpad, and Finder can see them.
  home.activation.linkNixApps = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    apps_source="${config.home.path}/Applications"
    apps_target="$HOME/Applications/Nix Apps"

    if [ -d "$apps_source" ]; then
      run mkdir -p "$apps_target"
      run rm -rf "$apps_target"/*.app 2>/dev/null || true
      for app in "$apps_source"/*.app; do
        [ -e "$app" ] || continue
        run cp -RH "$app" "$apps_target"
        run chmod -R u+w "$apps_target/$(basename "$app")"
      done
    fi
  '';
}
