set -euo pipefail

source ./lib/packages.sh

echo "🚀 Installing Lua"
install_pkg "lua"
install_pkg "luarocks"

echo "🚀 Installing Node"
install_pkg "nodejs"
install_pkg "npm"
node --version
npm --version
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash

echo "🚀 Golang"
wget https://go.dev/dl/go1.25.4.linux-amd64.tar.gz
sudo rm -rf /usr/local/go | true
sudo tar -C /usr/local -xzf go1.25.4.linux-amd64.tar.gz
echo "..Cleaning up"
rm ./go1.25.4.linux-amd64.tar.gz

echo "🚀 Install uv"
curl -LsSf https://astral.sh/uv/install.sh | sh
