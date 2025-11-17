set -euo pipefail

source ./lib/packages.sh
echo "🚀 SInstalling requirments: tmux, fd, lazygit, fzf, ripgrep, wl-clipboard"
install_pkg "lolcat"
install_pkg "figlet"
install_pkg "bat"
install_pkg "fastfetch"
install_pkg "btop"
install_pkg "cowsay"
yay -Syu --noconfirm visual-studio-code-bin
fastfetch
