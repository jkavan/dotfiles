## Installation

I'm currently using [dotbot](https://github.com/anishathalye/dotbot) to automate the management of dotfiles.

I mostly use this on Manjaro and Debian Buster/Stretch, but it should be relatively easy to modify this to run on other OSes as well.

Running this on Stretch works for the most part, but certain vim plugins won't play nicely (at least coc-snippets) due to too old packages.

### Steps

1. Install required packages:
   1. `sudo pacman -S curl git neovim-nightly nodejs python3 python-pynvim tmux wget zsh` or `sudo apt install curl git python-neovim python3-neovim tmux zsh && curl -sL install-node.now.sh/lts | bash`
   1. Debian: install [neovim](https://github.com/neovim/neovim/wiki/Installing-Neovim) appimage or build from sources
1. `git clone https://github.com/jkavan/dotfiles ~/.dotfiles`
1. Run the dotfiles installation script: `./install`
1. Set zsh as the default shell
   1. `chsh -s $(which zsh)`

## Update

To update dotfiles, run `git pull && ./install`.

To update submodules, run `git submodule update --remote --init --recursive`.

## SSH-agent service

The SSH-agent service keeps track of user's keys and their passphrases. It makes it less cumbersome to use SSH keys with passphrases.

Start and enable the service:

```shell
systemctl --user start ssh-agent
systemctl --user enable ssh-agent
```

Once the service has started, run `ssh-add` to add your SSH keys into the SSH authentication agent.

## Dotfiles testing with Docker

The repository contains a Dockerfile that contains the latest Debian and these dotfiles.

It can be used to easily test these dotfiles in an isolated environment without affecting current setup.

Build a Docker image:

`docker build -t jkavan/dotfiles .`

Run the Docker image:

`docker run --rm -it jkavan/dotfiles`

If your `$TERM` differs from the one defined in the Dockerfile, you can override it:

`docker run --rm -it jkavan/dotfiles env TERM=tmux-256color`

After launching the container, run `vim`, so `coc.nvim` plugin will automatically download and install all additional coc-extensions.
