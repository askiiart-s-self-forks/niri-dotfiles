if status is-interactive
    # Stuff be used in init for any shell

    # docker/podman stuff
    #alias docker="sudo docker"
    #alias docker="podman"
    alias dcompose="docker compose up -d --remove-orphans"
    alias ddu="docker compose down && dcompose"
    alias adb="sudo adb" # Needed on Fedora, not on Debian, IDK about other distros

    alias ls="ls --color=auto -CF"
    alias ll="ls -l"
    alias la="ls -a"

    # lol
    alias please="sudo"
    alias pwease="please"
    alias pls="please"

    # kitty stuff
    if [ $TERM = "xterm-kitty" ]
        alias icat="kitten icat"
        alias s="kitten ssh"
    else
        alias icat="wezterm imgcat"
        alias s="ssh"
    end

    # NixOS
    if type -q nixos-rebuild
        alias nrs="sudo NIXPKGS_ALLOW_INSECURE=1 nixos-rebuild switch --upgrade-all"
        alias nrb="sudo NIXPKGS_ALLOW_INSECURE=1 nixos-rebuild build --upgrade-all"
        alias nrs-rb="sudo NIXPKGS_ALLOW_INSECURE=1 nixos-rebuild switch --upgrade-all --rollback"
        alias nrb-rb="sudo NIXPKGS_ALLOW_INSECURE=1 nixos-rebuild build --upgrade-all --rollback"
        alias hms="NIXPKGS_ALLOW_INSECURE=1 home-manager switch"
        alias hmb="NIXPKGS_ALLOW_INSECURE=1 home-manager build"
    end


    # git
    alias git-us="git submodule update --init --recursive"

    # switch between SSH and HTTPS remotes
    alias git-remote-switch="python3 -c \"import subprocess

remote = subprocess.getoutput('git branch -vv')
remote = remote[remote.find('[') + 1 : remote.find('/')]
old_url = subprocess.getoutput(f'git remote get-url {remote}')

if old_url.startswith('https://'):
    new_url = old_url[8:]
    new_url = new_url[: new_url.find('/')] + ':' + new_url[new_url.find('/') + 1 :]
    new_url = f'git@{new_url}'
else:
    new_url = old_url[4:]
    new_url = new_url.replace(':', '/')
    new_url = f'https://{new_url}'

exit(subprocess.getstatusoutput(f'git remote set-url {remote} {new_url}')[0])\""

    # misc
    alias py-add-venv="set PATH $(pwd)/.venv/bin/:$PATH"
end
