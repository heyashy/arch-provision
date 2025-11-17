set -euo pipefail

echo "arch-provision"
source ./setup_kitty.sh
source ./setup_shell_utils.sh
source ./setup_shell.sh
source ./setup_languages.sh
source ./setup_neovim.sh

# after install this docker script will logout the user from the current session
# Has to be last as it newgrp docker will affect the current session
source ./setup_docker.sh
