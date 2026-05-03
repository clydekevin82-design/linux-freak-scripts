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
```

During install, you can choose the PC name used in wrapped command output.
After install, edit `~/.config/linux-freak/config` to change it. Set
`FREAK_RUN_MODE=quiet` there if you want wrapped installers to hide normal
output and only show the freaky progress lines.

## Uninstall

```sh
./scripts/freak-uninstall
```

The installer only touches a marked block in your shell rc file, plus files
under `~/.local/bin` and `~/.config/linux-freak`.
