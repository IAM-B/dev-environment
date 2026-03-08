# Setup fzf
# ---------
if [[ ! "$PATH" == *"$HOME/.fzf/bin"* ]]; then
  PATH="${PATH:+${PATH}:}$HOME/.fzf/bin"
fi

# When ble.sh is loaded, use its fzf integration modules
# (standard fzf key-bindings don't work with ble.sh's readline replacement)
if [[ ${BLE_VERSION-} ]]; then
  ble-import -d integration/fzf-completion
  ble-import -d integration/fzf-key-bindings
else
  # fzf >= 0.48 supports --bash, older versions use the scripts
  if fzf --bash &>/dev/null; then
    eval "$(fzf --bash)"
  elif [ -f "$HOME/.fzf/shell/completion.bash" ]; then
    source "$HOME/.fzf/shell/completion.bash"
    source "$HOME/.fzf/shell/key-bindings.bash"
  elif [ -f /usr/share/fzf/completion.bash ]; then
    # Arch Linux / Fedora
    source /usr/share/fzf/completion.bash
    source /usr/share/fzf/key-bindings.bash
  elif [ -f /usr/share/doc/fzf/examples/key-bindings.bash ]; then
    # Debian / Ubuntu
    source /usr/share/doc/fzf/examples/key-bindings.bash
    [ -f /usr/share/doc/fzf/examples/completion.bash ] && source /usr/share/doc/fzf/examples/completion.bash
  fi
fi
