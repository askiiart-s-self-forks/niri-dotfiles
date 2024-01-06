function bangbang --on-event fish_preexec
    set -l command $argv
    set -l last_command (history --max 1)
    set -l new_command (echo $command | sed -e "s/\!\!/$last_command/g")
    # TODO: Figure out how to replace the current command and run that instead
    echo "*** New command: $new_command ***"
end