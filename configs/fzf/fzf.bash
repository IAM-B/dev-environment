# Setup fzf
# ---------
if [[ ! "$PATH" == *"$HOME/.fzf/bin"* ]]; then
  PATH="${PATH:+${PATH}:}$HOME/.fzf/bin"
fi

# fzf >= 0.48 supports --bash, older versions use the scripts
if fzf --bash &>/dev/null; then
  eval "$(fzf --bash)"
elif [ -f "$HOME/.fzf/shell/completion.bash" ]; then
  source "$HOME/.fzf/shell/completion.bash"
  source "$HOME/.fzf/shell/key-bindings.bash"
elif [ -f /usr/share/fzf/completion.bash ]; then
  source /usr/share/fzf/completion.bash
  source /usr/share/fzf/key-bindings.bash
fi
