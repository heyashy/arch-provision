set -euo pipefail

source ./lib/packages.sh

echo "🐳 Setting up Docker & Docker Desktop on Arch..."

# --- 1. Install native Docker engine ---------------------------------

echo "📦 Installing docker and docker-buildx..."
install_pkg "docker"
install_pkg "docker-buildx"

echo "🔧 Enabling Docker system service..."
sudo systemctl enable --now docker.service

# --- 2. Add current user to docker group -----------------------------

# Ensure docker group exists
if ! getent group docker >/dev/null 2>&1; then
  echo "👥 docker group does not exist, creating..."
  sudo groupadd docker
fi

# Check system-level membership (not session-level)
if getent group docker | grep -q "\b$USER\b"; then
  echo "✔️ User '$USER' already in docker group."
else
  echo "👤 Adding $USER to docker group..."
  sudo usermod -aG docker "$USER"
  echo "⚠️ You must log out and log back in (or run 'newgrp docker') for this to take effect!"
fi

# --- 3. Remove standalone docker-compose (conflicts with Docker Desktop)

if pacman -Qi docker-compose >/dev/null 2>&1; then
  echo "⚠️ Removing docker-compose package (Docker Desktop provides Compose v2)..."
  sudo pacman -Rns --noconfirm docker-compose
else
  echo "✔️ docker-compose package not installed, nothing to remove."
fi

# --- 4. Install Docker Desktop from AUR ------------------------------

echo "🧱 Installing Docker Desktop (AUR: docker-desktop)..."

if ! command -v yay >/dev/null 2>&1; then
  echo "❌ 'yay' not found. Please install 'yay' first."
  exit 1
fi

if yay -Qi docker-desktop >/dev/null 2>&1; then
  echo "✔️ docker-desktop already installed."
else
  yay -Syu docker-desktop
fi

# --- 5. Enable Docker Desktop user service ---------------------------

echo "🔌 Enabling Docker Desktop user service (if available)..."

if systemctl --user list-unit-files | grep -q '^docker-desktop.service'; then
  systemctl --user enable --now docker-desktop
else
  echo "⚠️ docker-desktop.service not found yet."
  echo "   After re-login you can run:"
  echo "     systemctl --user enable --now docker-desktop"
fi

docker run hello-world
echo "🎉 Docker + Docker Desktop setup complete!"
echo "   → Use 'docker compose' (not 'docker-compose') from now on."
echo "   → Restart your session or run: newgrp docker"
echo "   → Start Docker Desktop with: docker-desktop"

newgrp docker
