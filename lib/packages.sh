set -euo pipefail

# --- Functions ---------------------------------------------------------

install_pkg() {
  local pkg="$1"
  if ! pacman -Qi "$pkg" >/dev/null 2>&1; then
    echo "📦 Installing $pkg..."
    sudo pacman -S --noconfirm "$pkg"
  else
    echo "✔️ $pkg already installed."
  fi
}
