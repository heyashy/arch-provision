set -euo pipefail

source ./lib/packages.sh
echo "🚀 Starting ZSH / Oh-My-Zsh / Starship setup on Arch..."
# --- 1. Install required packages -------------------------------------

install_pkg "zsh"
install_pkg "git"
install_pkg "curl"
install_pkg "starship"

# --- 2. Install Oh-My-Zsh ---------------------------------------------

if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "💿 Installing Oh-My-Zsh..."
  export RUNZSH=no      # don't auto-launch zsh during install
  export KEEP_ZSHRC=yes # don't overwrite your dotfile
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
  echo "✔️ Oh-My-Zsh already installed."
fi

# --- 3. Ensure starship is initialized --------------------------------

if ! grep -q "eval \"\$(starship init zsh)\"" "$HOME/.zshrc"; then
  echo "✨ Adding Starship init to ~/.zshrc..."
  echo 'eval "$(starship init zsh)"' >>"$HOME/.zshrc"
else
  echo "✔️ Starship already configured in ~/.zshrc."
fi

# --- 4. Change default shell to zsh -----------------------------------

if [ "$SHELL" != "/usr/bin/zsh" ]; then
  echo "🔄 Changing default shell to zsh..."
  chsh -s /usr/bin/zsh
else
  echo "✔️ Default shell already set to zsh."
fi

echo "🎉 All done! Open a new terminal to enjoy your shiny ZSH setup."
