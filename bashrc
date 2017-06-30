export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

if [ "$PS1" != "" -a "${STARTED_TMUX:-x}" = x -a "${SSH_TTY:-x}" != x ]
then
    STARTED_TMUX=1; export STARTED_TMUX
    sleep 1
    (
	(
	    tmux has-session -t remote && tmux attach-session -t remote
	) || (
        [[ -d ~/.weechat ]] || mkdir ~/.weechat
	    tmux new-session -s remote weechat-curses
	)
    ) && exit 0
    echo "tmux failed to start"
fi
