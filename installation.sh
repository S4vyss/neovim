#!/bin/bash

# Check the operating system
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    # Install Neovim on Linux
    sudo apt-get update
    sudo apt-get install neovim

elif [[ "$OSTYPE" == "msys" ]]; then
    # Install Neovim on Windows using scoop (assuming scoop is installed)
    scoop install neovim

else
    echo "Unsupported operating system. Please install Neovim manually."
    exit 1
fi

# Clone the Neovim configuration repository
git clone <GitHub-Repository-URL> ~/.config/nvim

# Install the Mason plugin manager (if it's not already installed)
if ! command -v mason &> /dev/null; then
    git clone https://github.com/ChristianChiarulli/mason.git ~/.config/nvim/mason
    echo 'export PATH="$HOME/.config/nvim/mason:$PATH"' >> ~/.bashrc
    source ~/.bashrc
fi

# Install all plugins managed by Mason
mason install

# Open Neovim and let Mason manage the plugins
nvim +PackerCompile +PackerInstall +qall

