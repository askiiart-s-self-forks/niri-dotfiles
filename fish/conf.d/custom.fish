if status is-interactive
    set -gx PATH $PATH ~/.cargo/bin/
    set -gx PATH $PATH /opt/clang-format-static
    set -x GPG_TTY (tty)
    set -x SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)
    set -x EDITOR nvim
    set -x DOCKER_HOST unix://$XDG_RUNTIME_DIR/docker.sock
    gpgconf --launch gpg-agent
    gpg-connect-agent updatestartuptty /bye
    # ctrl+backspace (^H in kitty)
    # for ctrl+delete: kill-word ([3;5~ in kitty)
    bind \cH backward-kill-path-component
    bind '[3;5~' kill-word
    set -x NIXPKGS_ALLOW_UNFREE 1
    set -x NIXPKGS_ALLOW_INSECURE 1
    set -x GTK_THEME Catppuccin-Mocha-Standard-Mauve-Dark
end
