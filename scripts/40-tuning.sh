#!/usr/bin/env bash
set -euo pipefail

PROFILE=${1:-all-in-one}

echo "[40] tuning (${PROFILE})"

# zram (systemd-zram-generator is simple)
# Note: On some older installs this package may not exist; we'll attempt and continue.
if sudo pacman -Ss --quiet '^systemd-zram-generator$' >/dev/null 2>&1; then
  sudo pacman -S --noconfirm --needed systemd-zram-generator
  sudo mkdir -p /etc/systemd
  if [[ ! -f /etc/systemd/zram-generator.conf ]]; then
    sudo tee /etc/systemd/zram-generator.conf >/dev/null <<'EOF'
[zram0]
zram-size = min(ram / 2, 1024)
compression-algorithm = zstd
swap-priority = 100
EOF
  fi
else
  echo "NOTE: systemd-zram-generator not found in repos; skipping zram auto-setup." >&2
fi

# Pacman: keep cache small on HDD
if [[ ! -d /etc/pacman.d/hooks ]]; then
  sudo mkdir -p /etc/pacman.d/hooks
fi
if [[ ! -f /etc/pacman.d/hooks/clean_package_cache.hook ]]; then
  sudo tee /etc/pacman.d/hooks/clean_package_cache.hook >/dev/null <<'EOF'
[Trigger]
Operation = Upgrade
Operation = Install
Operation = Remove
Type = Package
Target = *

[Action]
Description = Keep pacman cache small (paccache -r)
When = PostTransaction
Exec = /usr/bin/paccache -r
Depends = pacman-contrib
EOF
fi
sudo pacman -S --noconfirm --needed pacman-contrib

echo "OK"
