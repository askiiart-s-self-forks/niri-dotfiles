fish_add_path .cargo/bin/
set -x GPG_TTY (tty)
set -x SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)
set -x EDITOR nvim
set -x DOCKER_HOST unix:///run/user/1000/docker.sock
