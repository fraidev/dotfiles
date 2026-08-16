{ lib, pkgs, ... }:

# Linux-only extras.
#
# Samba cannot use home-manager's systemd.user.services here: this host
# runs Nix under nix-user-chroot, so systemd --user (outside the chroot)
# cannot follow ~/.config/systemd/user/*.service -> /nix/store/... links.
# Activation writes a regular unit that starts bin/smbd-homelab instead.
{
  home.packages = with pkgs; [
    xclip
    samba
  ];

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
