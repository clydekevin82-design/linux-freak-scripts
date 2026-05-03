# linux-freak-scripts

Opt-in shell seasoning for Linux. It adds a little freak factor without
patching PAM, changing `/etc/sudoers`, or making permanent system-wide edits.

## What it does

- Adds `freak-sudo`, a tiny wrapper around `sudo` with a custom prompt:
  `password? be a good boy~`
- Adds `freak-run`, a wrapper for commands that shows progress as:
  `[be a good boy for PC-NAME while he installs~ 42%]`
- Wraps common installers/package managers when they exist: `apt`, `apt-get`,
  `dnf`, `yum`, `pacman`, `zypper`, `flatpak`, `snap`, `paru`, `yay`,
  `emerge`, `nix`, and `brew`.
- Optionally aliases `sudo` to use that prompt in interactive shells.
- Makes `sudo apt install ...` and similar package-manager invocations use the
  progress wrapper too.
- Adds a few playful aliases like `please`, `beg`, and `confess`.
- Adds a small prompt flourish when enabled.
- Adds `ollama-freak`, a local Ollama roleplay launcher that uses your
  linux-freak config as scene context.

## Install

```sh
./scripts/freak-install
```

Restart your shell, or run:

```sh
. ~/.config/linux-freak/freak-shell.sh
```

## Try it first

```sh
./scripts/freak-factor preview
./scripts/freak-sudo -v
./scripts/freak-run printf 'Installing 69%%\n'
./scripts/ollama-freak --prompt-only
```

Add `--info` after the package manager when you want normal package output
plus the freak progress line:

```sh
sudo apt --info install cowsay
apt --info install cowsay
```

During install, you can choose the PC name used in wrapped command output.
You can also choose the roleplay pairing preference used by `ollama-freak`:
`M/M`, `F/F`, `M/F`, or `F/M`.
After install, edit `~/.config/linux-freak/config` to change it. The default
wrapper mode hides normal installer output and updates one progress line in
place. Set `FREAK_RUN_MODE=soft` if you want normal command output too, or
`FREAK_RUN_STYLE=line` if you want every percent update on its own line.

## Ollama roleplay

```sh
ollama-freak
```

It asks what the model should call you, lists installed Ollama models by
number, creates a local session model named `linux-freak-roleplay`, and starts
an interactive chat. The linux-freak strings are given as reference context,
not as lines the model should randomly imitate. The launcher hides
`linux-freak-roleplay` from the picker so you do not accidentally build a new
roleplay model on top of its own older prompt. It starts Ollama with
`--think=false` by default so thinking-capable models answer directly, hides
Ollama setup chatter, and clears the setup questions before chat starts.
Override the session model name with:

```sh
OLLAMA_FREAK_SESSION_MODEL=my-freak-session ollama-freak
```

Override thinking mode with:

```sh
OLLAMA_FREAK_THINK=true ollama-freak
```

Keep the setup questions on screen with:

```sh
OLLAMA_FREAK_CLEAR_SETUP=0 ollama-freak
```

## Uninstall

```sh
./scripts/freak-uninstall
```

The installer only touches a marked block in your shell rc file, plus files
under `~/.local/bin` and `~/.config/linux-freak`.
