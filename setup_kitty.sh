set -euo pipefail

source ./lib/packages.sh

echo "🚀 Setting up kitty terminal on Arch..."

install_pkg "kitty"
gsettings set org.gnome.desktop.default-applications.terminal exec-arg '--single-instance'
gsettings set org.gnome.desktop.default-applications.terminal exec 'kitty'
