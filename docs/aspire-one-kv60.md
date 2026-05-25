## Acer Aspire One KV60 notes

### Hardware
- Intel Atom N270 (1.6 GHz)
- 2GB DDR2
- 1024×600
- Intel GMA 950 / 945GSE
- 160GB HDD
- Wi‑Fi 802.11b/g
- Bluetooth + webcam present

### Known constraints
- Prefer **Xorg**; Wayland compositors (Hyprland) are not realistic on GMA 950.
- HDD is slow: keep pacman cache small, avoid heavy background services.
- 2GB RAM: enable zram; avoid heavy IDEs by default.

### Recommended workflow
- Use `neovim` + LSP for coding.
- Use Firefox + uBlock Origin for study.
- Use Zathura for PDFs.

