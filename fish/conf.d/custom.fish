fish_add_path .cargo/bin/
set -x GPG_TTY (tty)
set -x SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)
set -x EDITOR nvim
