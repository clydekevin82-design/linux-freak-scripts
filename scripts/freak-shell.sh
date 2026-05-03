#!/usr/bin/env sh
# Source this file from an interactive shell to enable linux-freak-scripts.

case ${-:-} in
  *i*) ;;
  *) return 0 2>/dev/null || exit 0 ;;
esac

export FREAK_SUDO_PROMPT=${FREAK_SUDO_PROMPT:-"password? be a good boy~ "}

config_file="${XDG_CONFIG_HOME:-"$HOME/.config"}/linux-freak/config"
if [ -r "$config_file" ]; then
  . "$config_file"
fi

if command -v freak-sudo >/dev/null 2>&1; then
  alias sudo='freak-sudo'
  alias please='freak-sudo'
  alias beg='freak-sudo'
fi

if command -v freak-run >/dev/null 2>&1; then
  alias goodboy='freak-run'

  for freak_cmd in apt apt-get dnf yum pacman zypper flatpak snap paru yay emerge nix brew; do
    if command -v "$freak_cmd" >/dev/null 2>&1; then
      alias "$freak_cmd=freak-run $freak_cmd"
    fi
  done
  unset freak_cmd
fi

alias confess='history | tail -20'
alias behave='printf "%s\n" "trying my best~"'
alias strut='printf "%s\n" "$USER on $(hostname): dangerously pretty and operational"'

if [ "${FREAK_PROMPT:-1}" != "0" ]; then
  if [ -n "${BASH_VERSION:-}" ]; then
    PS1='[\u@\h \W] ~♡ '
  elif [ -n "${ZSH_VERSION:-}" ]; then
    PROMPT='%n@%m %1~ ~♡ '
  fi
fi
