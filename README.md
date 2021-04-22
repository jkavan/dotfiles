## Installation

I'm currently using [dotbot](https://github.com/anishathalye/dotbot) to automate the installation process.

I mostly use this on Manjaro and Debian Stretch/Buster, but it should be relatively easy to modify to run on other OSes as well.

### Requirements

| Required packages     |
| --------------------- |
| Git                   |
| Zsh                   |
| Neovim                |
| Tmux                  |
| curl                  |
| NodeJS (for coc.nvim) |

### Steps

1. Install the required packages
   1. `sudo pacman -S git zsh neovim tmux curl` or `sudo apt install git zsh neovim tmux curl`
   1. `curl -sL install-node.now.sh/lts | bash`
1. `git clone https://github.com/jkavan/dotfiles ~/.dotfiles`
1. Run the installation script: `./install`
1. Set zsh as the default shell
   1. `chsh -s $(which zsh)`

### Optional

#### Debian 9: Install packages from backports

The packages on Debian 9 are too old, so I recommend to install tmux and neovim from backports.

```shell
echo 'deb http://deb.debian.org/debian stretch-backports main contrib non-free' | sudo tee -a /etc/apt/sources.list
sudo apt update
sudo apt install neovim tmux -t stretch-backports
```

## Update

To update dotfiles, run `git pull && ./install`.
To update submodules, run `git submodule update --remote --init --recursive`.

## Enable and start the SSH-agent service

```shell
systemctl --user start ssh-agent
systemctl --user enable ssh-agent
```
