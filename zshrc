# Magic functions make pasting to terminal ridiculously slow.
DISABLE_MAGIC_FUNCTIONS=true

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

export DEFAULT_USER="$USER"

#ZSH_TMUX_AUTOSTART=true
#ZSH_TMUX_AUTOCONNECT=false
# Set list of themes to load
# Setting this variable when ZSH_THEME=random
# cause zsh load theme from this variable instead of
# looking in ~/.oh-my-zsh/themes/
# An empty array have no effect
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
 HIST_STAMPS="mm/dd/yyyy"
 HISTFILE="${HOME}/.zsh_history/$(hostname -f)"
 HISTSIZE=1000000
 SAVEHIST=1000000

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  colored-man-pages
  docker
  docker-compose
  #git
  zsh-syntax-highlighting
  zsh-autosuggestions
  #tmux
  #cake
  #composer
  #taskwarrior
  highlite
  terraform
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LANG=en_US.UTF-8
en_fi_supported=$(locale -a | grep 'en_FI' | wc -l)
if [[ $en_fi_supported -gt 0 ]]; then
  export LC_CTYPE=en_US.UTF-8
  export LC_NUMERIC=en_FI.UTF-8
  export LC_TIME=en_FI.UTF-8
  export LC_COLLATE=en_FI.UTF-8
  export LC_MONETARY=en_FI.UTF-8
  export LC_MESSAGES=en_US.UTF-8
  export LC_PAPER=en_FI.UTF-8
  export LC_NAME=en_FI.UTF-8
  export LC_ADDRESS=en_FI.UTF-8
  export LC_TELEPHONE=en_FI.UTF-8
  export LC_MEASUREMENT=en_FI.UTF-8
  export LC_IDENTIFICATION=en_FI.UTF-8
else
  export LC_ALL=en_US.UTF-8
fi

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Use neovim instead of vim if installed
if which nvim &> /dev/null; then
  alias vim=nvim
  export EDITOR=nvim
fi

# Enable vi-mode
set -o vi

# Change cursor shape based on the shell's insert/normal mode
function zle-line-init zle-keymap-select {
    if [ $KEYMAP = vicmd ]; then
        # the command mode for vi
        echo -ne "\e[2 q"
    else
        # the insert mode for vi
        echo -ne "\e[5 q"
    fi
}
zle -N zle-line-init
zle -N zle-keymap-select

# Enable fzf if it's installed
if [ -f ~/.fzf.zsh ]; then
  # Load FZF
  source ~/.fzf.zsh

  # Show preview window when running Alt+C to change directory
  export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -100'"

  # Load FZF ZSH tab completion plugin if it exists
  # It adds FZF to all tab completions overriding the default menu
  FZF_TAB_COMPLETION_PATH=~/.fzf-tab-completion/zsh/fzf-zsh-completion.sh
  if [ -f $FZF_TAB_COMPLETION_PATH ]; then
    source $FZF_TAB_COMPLETION_PATH
    zstyle ':completion:*' fzf-search-display true
  fi

  _fzf_comprun() {
    local command=$1
    shift

    case "$command" in
      cd) fzf "$@" --preview 'tree -C {} | head -200' ;;
      export|unset) fzf "$@" --preview "eval 'echo \$'{}" ;;
      vim) fzf "$@" --preview 'cat {} | head -20' ;;
      *)  fzf "$@" ;;
    esac
  }

  # Run `fzf_apropos` to search available commands/descriptions and display their man pages
  function fzf_apropos() {
    apropos '' | fzf --preview-window=up:50% --preview 'echo {} | cut -f 1 -d " " | xargs man' | cut -f 1 -d " "
  }

  # Use `fd` with FZF if installed
  if which fd &> /dev/null; then
    export FZF_DEFAULT_COMMAND='fd --type f'

    _fzf_compgen_path() {
      fd --hidden --follow --exclude ".git" . "$1"
    }

    # Use fd to generate the list for directory completion
    _fzf_compgen_dir() {
      fd --type d --hidden --follow --exclude ".git" . "$1"
    }
  fi
fi

## Fix Mobaxterm home & end keys
# Commented out, since I don't use Mobaxterm anymore
#bindkey '^[[1~' beginning-of-line
#bindkey '^[[4~' end-of-line

# Fix Vim home & end keys. There are also 2 lines in tmux.conf that are required.
bindkey "\eOH" beginning-of-line
bindkey "\eOF" end-of-line

# Fix home and end keys in insert mode
bindkey -M viins "\e[F" end-of-line
bindkey -M viins "\e[H" beginning-of-line

# Fix home and end keys in normal mode
bindkey -M vicmd "\e[F" end-of-line
bindkey -M vicmd "\e[H" beginning-of-line

# Fix backspace key
bindkey "^?" backward-delete-char

# Fix reverse menu complete
bindkey '\e[Z' reverse-menu-complete

# Map undo to u
bindkey -M vicmd "u" undo

# Map Ctrl+v to edit line in Vim
bindkey -M vicmd "^V" edit-command-line

# Map Ctrl+Backspace to delete word
bindkey -M viins "^H" backward-kill-word

# Fix delete key
bindkey '\e[3~' delete-char

# Remove the delay moving between insert/normal mode
export KEYTIMEOUT=1

bindkey -M viins "\e[1;5D" vi-backward-blank-word
bindkey -M viins "\e[1;5C" vi-forward-blank-word

# Copies the shrug emoji to clipboard. Very important
alias dunnolol='echo -n "¯\\_(ツ)_/¯" | xclip -selection clipboard'

# Initialize the completion system
autoload -Uz compinit && compinit

# Enable completion for Kitty if installed
if which kitty &> /dev/null; then
  kitty + complete setup zsh | source /dev/stdin
fi

# Enable completion for Flux if installed
if which flux &> /dev/null; then
  command -v flux >/dev/null && . <(flux completion zsh)
fi

# Enable kubectl and kubectx completion and set short aliases
if which kubectl &> /dev/null; then
  # Enable completion for kubectl
  source <(kubectl completion zsh)
  alias k=kubectl
  if which kubectx &> /dev/null; then alias kx=kubectx; fi
fi

# Enable completion for Molecule if installed
if which molecule &> /dev/null; then
  eval "$(_MOLECULE_COMPLETE=source molecule)"
fi

# Use lsd instead of ls if installed
if which lsd &> /dev/null; then
  alias ls="lsd"
else
  # Otherwise set fancy dir colors for directory listing
  d=.dir_colors
  test -r $d && eval "$(dircolors $d)"
fi

# Git aliases
function git_status() {
  if [ -z "$(git status --porcelain)" ]; then
    echo "Working dir clean"
  else
    vim -c 'G | only' -c 'normal gu'
  fi
}
# Short Git status
alias gs="git status -sb"
# Use Vim Fugitive for Git
alias gsv=git_status

# Use fuzzy search for completion if there are no matches
zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 1 numeric

# Enable IP address completion
zstyle ':completion:*' use-ip true

# cd will never select the parent directory (e.g.: cd ../<TAB>):
zstyle ':completion:*:cd:*' ignore-parents parent pwd

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

