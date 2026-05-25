# OldArch-Omakase

A minimal, reproducible **Arch Linux “omakase”** setup to revive old/low-end PCs (e.g., Intel Atom + 2GB RAM) for **students and developers**.

This project is designed to be applied **after** you install a minimal Arch base with `archinstall`.

## Why this exists
Modern workflows don’t *have* to require modern hardware. This repo aims to provide:
- **Good defaults** (“omakase”) for old machines
- **Fast + stable** Xorg-based setup (Wayland is not the goal)
- A **pretty, minimal aesthetic** without GPU-heavy compositing
- A reproducible bootstrap flow: scripts + profiles + docs

## Target hardware (first-class)
Acer Aspire One KV60 / similar netbooks:
- CPU: Intel Atom N270 (1.6 GHz)
- RAM: 2 GB DDR2
- Display: 1024×600
- GPU: Intel GMA 950 / 945GSE
- Disk: 160 GB HDD
- Wi‑Fi: 802.11b/g

## Design choices (defaults)
- **Xorg** + lightweight WM (default: i3)
- **startx** (lighter than a display manager)
- **linux-lts** kernel
- **zram** enabled by default (helps with 2GB RAM)

## Quick start
1) Install Arch base using `archinstall` (no DE).
2) Boot into your new system.
3) Run:

```bash
sudo pacman -Syu --noconfirm
sudo pacman -S --noconfirm git

git clone https://github.com/yfrey-Gmfalkc/OldArch-Omakase.git
cd OldArch-Omakase
chmod +x bootstrap.sh
./bootstrap.sh --profile all-in-one
```

## Profiles
- `all-in-one`: one profile containing a practical student + developer baseline for low-end machines.

## Repo layout
- `bootstrap.sh`: main entrypoint
- `profiles/*`: package lists and config by profile
- `scripts/*`: ordered steps (easy debugging)
- `docs/*`: hardware notes, troubleshooting, performance tuning

## Notes on “pretty but light”
We keep the system aesthetic using:
- simple GTK themes and icon packs
- i3bar/polybar-like minimal bars (lightweight)
- **no heavy compositor by default**

## License
MIT License. See `LICENSE`.
