if status is-interactive
    set -gx PATH $PATH ~/.cargo/bin/
    set -gx PATH $PATH /opt/clang-format-static
    set -x GPG_TTY (tty)
    set -x SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)
    set -x EDITOR nvim
    #set -x DOCKER_HOST unix://$XDG_RUNTIME_DIR/docker.sock
    gpgconf --launch gpg-agent
    gpg-connect-agent updatestartuptty /bye
    # ctrl+backspace (^H in kitty)
    # for ctrl+delete: kill-word ([3;5~ in kitty)
    bind \cH backward-kill-path-component
    bind '[3;5~' kill-word
    set -x NIXPKGS_ALLOW_UNFREE 1
    set -x NIXPKGS_ALLOW_INSECURE 1
    set -x GTK_THEME Catppuccin-Mocha-Standard-Mauve-Dark
    # XDG variables
    set -x XDG_DATA_HOME ~/.local/share
    set -x XDG_CONFIG_HOME ~/.config
    set -x XDG_STATE_HOME ~/.local/state
    if not [ -d /tmp/$UID-runtime-dir ]
        mkdir /tmp/$UID-runtime-dir
    end
    set -x XDG_RUNTIME_DIR /tmp/runtime-dir
end
