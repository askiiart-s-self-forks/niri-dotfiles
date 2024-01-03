function bangbang --on-event fish_preexec
    set -l command $argv
    #if ( echo $commmand | grep -q '!!' )
    set -l last_command (history --max 2 | tail --lines 1 | string escape | string escape)
    echo $last_command
    set -l new_command (echo $command | sed -e "s/\!\!/$last_command/g")
    # TODO: Figure out how to replace the current command and run that instead
    echo "*** New command: $new_command ***"
end