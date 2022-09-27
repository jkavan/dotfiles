# Preferred terminal for remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  #echo "Remote session is active so TERM has been set to xterm-256color"
  export TERM=xterm-256color
fi

# Append Ruby path if it's installed
if ! [ -x "$(command -v ruby)" ]; then
  #echo 'Ruby is not installed. Not appending $PATH.'
else
  PATH="$PATH:$(ruby -e 'print Gem.user_dir')/bin"
fi

export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"

# Set awsume alias and auto-complete function if installed
if which awsume &> /dev/null; then
  #AWSume alias to source the AWSume script
  alias awsume="source awsume"

  #Auto-Complete function for AWSume
  fpath=(~/.awsume/zsh-autocomplete/ $fpath)
fi
