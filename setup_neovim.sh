set -euo pipefail

source ./lib/packages.sh
echo "🚀 SInstalling requirments: tmux, fd, lazygit, fzf, ripgrep, wl-clipboard"

#yay -Syu --needed --noconfirm tmux fd lazygit fzf ripgrep fd wl-clipboard
install_pkg "tmux"
install_pkg "fd"
install_pkg "lazygit"
install_pkg "fzf"
install_pkg "ripgrep"
install_pkg "wl-clipboard"

echo "🚀 Installing Neovim"
install_pkg "neovim"
