#!/usr/bin/env bash
set -euo pipefail

# Basic environment checks for old hardware.

echo "[00] checks"

RAM_MB=$(awk '/MemTotal/ {print int($2/1024)}' /proc/meminfo)
echo "Detected RAM: ${RAM_MB} MB"
if (( RAM_MB < 1800 )); then
  echo "WARNING: <2GB RAM detected. This setup targets ~2GB+ and will be tight." >&2
fi

if ! lspci >/dev/null 2>&1; then
  echo "Installing pciutils (for lspci)..."
  sudo pacman -S --noconfirm pciutils
fi

echo "GPU info:"
lspci | grep -Ei 'vga|3d|display' || true

echo "OK"
