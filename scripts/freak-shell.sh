#!/usr/bin/env sh
# Source this file from an interactive shell to enable linux-freak-scripts.

case ${-:-} in
  *i*) ;;
  *) return 0 2>/dev/null || exit 0 ;;
esac

export FREAK_SUDO_PROMPT=${FREAK_SUDO_PROMPT:-"password? be a good boy~ "}
export FREAK_RUN_CONFESS_FILE=${FREAK_RUN_CONFESS_FILE:-"${XDG_RUNTIME_DIR:-${TMPDIR:-/tmp}}/freak-run-confess.${USER:-user}.$$"}

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

  for freak_cmd in apt apt-get add-apt-repository dnf yum pacman zypper flatpak snap paru yay emerge nix brew; do
    if command -v "$freak_cmd" >/dev/null 2>&1; then
      alias "$freak_cmd=FREAK_RUN_MODE=quiet FREAK_RUN_STYLE=inline FREAK_RUN_KEEP_GOING=1 freak-run $freak_cmd"
    fi
  done
  unset freak_cmd
fi

_freak_confess_errors() {
  [ -n "${FREAK_RUN_CONFESS_FILE:-}" ] || return 0
  [ -s "$FREAK_RUN_CONFESS_FILE" ] || return 0

  while IFS= read -r freak_line; do
    [ -n "$freak_line" ] || continue
    printf '%s\n' "$freak_line"
  done < "$FREAK_RUN_CONFESS_FILE"
  : > "$FREAK_RUN_CONFESS_FILE"
}

if [ -n "${BASH_VERSION:-}" ]; then
  case ";${PROMPT_COMMAND:-};" in
    *";_freak_confess_errors;"*) ;;
    *) PROMPT_COMMAND="_freak_confess_errors${PROMPT_COMMAND:+; $PROMPT_COMMAND}" ;;
  esac
elif [ -n "${ZSH_VERSION:-}" ]; then
  autoload -Uz add-zsh-hook 2>/dev/null || true
  if command -v add-zsh-hook >/dev/null 2>&1; then
    add-zsh-hook precmd _freak_confess_errors
  else
    eval 'case " ${precmd_functions[*]-} " in
      *" _freak_confess_errors "*) ;;
      *) precmd_functions=(${precmd_functions[@]-} _freak_confess_errors) ;;
    esac'
  fi
fi

alias confess='history | tail -20'
alias behave='printf "%s\n" "trying my best~"'
alias strut='printf "%s\n" "$USER on $(hostname): dangerously pretty and operational"'

if command -v freak-finger >/dev/null 2>&1; then
  alias finger='freak-finger'
  alias touchid='freak-finger verify'
  alias unlock='freak-finger lock'
fi

if [ "${FREAK_PROMPT:-1}" != "0" ]; then
  if [ -n "${BASH_VERSION:-}" ]; then
    if [ -z "${NO_COLOR:-}" ]; then
      PS1='\[\033[38;5;218m\][\[\033[38;5;225m\]\u@\h \W\[\033[38;5;218m\]] ~♡ \[\033[0m\]'
    else
      PS1='[\u@\h \W] ~♡ '
    fi
  elif [ -n "${ZSH_VERSION:-}" ]; then
    if [ -z "${NO_COLOR:-}" ]; then
      PROMPT='%F{218}[%F{225}%n@%m %1~%F{218}] ~♡ %f'
    else
      PROMPT='%n@%m %1~ ~♡ '
    fi
  fi
fi
