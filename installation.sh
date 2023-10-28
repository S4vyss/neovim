#!/bin/bash

# Check the operating system
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    # Install Neovim on Linux
    sudo apt-get update
    sudo apt-get install neovim

    # Move the Neovim configuration directory to the appropriate location
    mv ~/neovim ~/.config/nvim

elif [[ "$OSTYPE" == "msys" ]]; then
    if ! command -v scoop &> /dev/null; then
        iex (new-object net.webclient).downloadstring('https://get.scoop.sh')
    fi
    
    scoop install neovim

    # Move the Neovim configuration directory to the appropriate location
    move ~\neovim ~/.config\nvim

else
    echo "Unsupported operating system. Please install Neovim manually."
    exit 1
fi

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
