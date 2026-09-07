{ config, lib, pkgs, ... }:

# Linux-only extras.
#
# Samba cannot use home-manager's systemd.user.services here: this host
# runs Nix under nix-user-chroot, so systemd --user (outside the chroot)
# cannot follow ~/.config/systemd/user/*.service -> /nix/store/... links.
# Activation writes a regular unit that starts bin/smbd-homelab instead.
#
# Login shell stays /bin/bash (no root needed to chsh). Interactive bash
# execs bin/host-zsh so the session is Nix zsh on the real host. Packages
# come from ~/.local/bin wraps + command_not_found_handler. Use nix-enter
# only when you need a mounted /nix (that namespace breaks sudo).
{
  home.packages = with pkgs; [
    xclip
    samba
  ];

  home.sessionVariables.SHELL = "${config.home.homeDirectory}/dotfiles/bin/host-zsh";

  home.activation.hostRelinkHm = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    if [ -x "$HOME/dotfiles/bin/host-relink-hm" ]; then
      run "$HOME/dotfiles/bin/host-relink-hm" || true
    fi
  '';

  home.activation.nixSyncWraps = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    if [ -x "$HOME/dotfiles/bin/nix-sync-wraps" ]; then
      run "$HOME/dotfiles/bin/nix-sync-wraps" || true
    fi
  '';

  home.activation.smbdUnit = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    unit_dir="$HOME/.config/systemd/user"
    unit="$unit_dir/smbd.service"
    run mkdir -p "$unit_dir/default.target.wants"
    # Regular file (not a /nix/store symlink) so host systemd can read it.
    # Write then mv so a running daemon-reload never sees a missing unit.
    run cp "$HOME/dotfiles/nix/smbd.service" "$unit.new"
    run chmod 644 "$unit.new"
    run mv -f "$unit.new" "$unit"
    if [ ! -e "$unit_dir/default.target.wants/smbd.service" ]; then
      run ln -s "$unit" "$unit_dir/default.target.wants/smbd.service"
    fi
    if command -v systemctl >/dev/null; then
      run systemctl --user daemon-reload || true
      run systemctl --user restart smbd.service || true
    fi
  '';
}
