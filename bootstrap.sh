#!/usr/bin/env bash
set -euo pipefail

# OldArch-Omakase bootstrap
# Apply on a fresh Arch install (installed via archinstall).

PROFILE="all-in-one"

usage() {
  cat <<'EOF'
Usage: ./bootstrap.sh [--profile all-in-one]

This script is intended for old/low-end hardware.
Run it as a regular user with sudo access.

Examples:
  ./bootstrap.sh --profile all-in-one
EOF
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --profile)
      PROFILE="$2"; shift 2 ;;
    -h|--help)
      usage; exit 0 ;;
    *)
      echo "Unknown argument: $1" >&2
      usage
      exit 2
      ;;
  esac
done

if [[ "$PROFILE" != "all-in-one" ]]; then
  echo "Unsupported profile: $PROFILE" >&2
  echo "Supported: all-in-one" >&2
  exit 2
fi

if [[ "${EUID}" -eq 0 ]]; then
  echo "Do not run as root. Run as a normal user with sudo." >&2
  exit 1
fi

if ! command -v sudo >/dev/null 2>&1; then
  echo "sudo not found. Install and configure sudo first." >&2
  exit 1
fi

if ! sudo -n true 2>/dev/null; then
  echo "Sudo requires a password or is not configured for your user." >&2
  echo "Re-run and enter your password when prompted." >&2
fi

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

bash "${ROOT_DIR}/scripts/00-checks.sh"
bash "${ROOT_DIR}/scripts/10-base.sh" "${PROFILE}"
bash "${ROOT_DIR}/scripts/20-xorg-i3.sh" "${PROFILE}"
bash "${ROOT_DIR}/scripts/40-tuning.sh" "${PROFILE}"
bash "${ROOT_DIR}/scripts/90-final.sh" "${PROFILE}"

echo
echo "Done. Reboot recommended."
