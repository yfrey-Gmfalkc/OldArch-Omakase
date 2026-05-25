#!/usr/bin/env bash
set -euo pipefail

PROFILE=${1:-all-in-one}

echo "[10] base packages (${PROFILE})"

sudo pacman -Syu --noconfirm

# Essentials
sudo pacman -S --noconfirm --needed \
  base-devel \
  git \
  curl \
  wget \
  vim \
  neovim \
  tmux \
  openssh \
  networkmanager \
  iwd \
  man-db man-pages \
  unzip zip \
  p7zip \
  htop \
  fastfetch \
  mesa \
  linux-lts \
  linux-lts-headers \
  intel-ucode

# Enable network manager (safe default)
sudo systemctl enable NetworkManager

# SSH service not enabled by default (user can enable later)

# Basic git defaults (user should set name/email later)
if ! git config --global init.defaultBranch >/dev/null 2>&1; then
  git config --global init.defaultBranch main
fi

# Ensure user dirs
sudo pacman -S --noconfirm --needed xdg-user-dirs
xdg-user-dirs-update || true

echo "OK"
