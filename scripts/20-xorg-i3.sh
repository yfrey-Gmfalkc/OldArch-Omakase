#!/usr/bin/env bash
set -euo pipefail

PROFILE=${1:-all-in-one}

echo "[20] xorg + i3 (${PROFILE})"

sudo pacman -S --noconfirm --needed \
  xorg-server \
  xorg-xinit \
  xorg-xrandr \
  xorg-setxkbmap \
  xterm \
  i3-wm \
  i3status \
  dmenu \
  feh \
  picom \
  thunar \
  gvfs \
  sxiv

# Minimal, pretty themes (lightweight)
sudo pacman -S --noconfirm --needed \
  lxappearance \
  arc-gtk-theme \
  papirus-icon-theme \
  ttf-dejavu \
  ttf-liberation

# Start X into i3
if [[ ! -f "${HOME}/.xinitrc" ]]; then
  cat > "${HOME}/.xinitrc" <<'EOF'
# OldArch-Omakase
# Start i3
exec i3
EOF
fi

# i3 config (minimal aesthetic)
mkdir -p "${HOME}/.config/i3"
if [[ ! -f "${HOME}/.config/i3/config" ]]; then
  cat > "${HOME}/.config/i3/config" <<'EOF'
set $mod Mod4
font pango:DejaVu Sans Mono 10

# Terminal
bindsym $mod+Return exec xterm

# Launcher
bindsym $mod+d exec dmenu_run

# Basic window controls
bindsym $mod+q kill
bindsym $mod+f fullscreen toggle
bindsym $mod+space floating toggle

# Focus
bindsym $mod+h focus left
bindsym $mod+j focus down
bindsym $mod+k focus up
bindsym $mod+l focus right

# Move
bindsym $mod+Shift+h move left
bindsym $mod+Shift+j move down
bindsym $mod+Shift+k move up
bindsym $mod+Shift+l move right

# Workspaces
set $ws1 "1"
set $ws2 "2"
set $ws3 "3"
set $ws4 "4"
set $ws5 "5"

bindsym $mod+1 workspace $ws1
bindsym $mod+2 workspace $ws2
bindsym $mod+3 workspace $ws3
bindsym $mod+4 workspace $ws4
bindsym $mod+5 workspace $ws5

bindsym $mod+Shift+1 move container to workspace $ws1
bindsym $mod+Shift+2 move container to workspace $ws2
bindsym $mod+Shift+3 move container to workspace $ws3
bindsym $mod+Shift+4 move container to workspace $ws4
bindsym $mod+Shift+5 move container to workspace $ws5

# Status bar
bar {
  status_command i3status
  position top
}
EOF
fi

echo "OK"
