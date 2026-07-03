# bash completion for opt-mgr - 无需额外依赖
_opt_mgr_completion() {
    local cur prev
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"

    local commands="install update remove rollback skip unskip info list set-repo check upgrade cleanup clean"

    if [ "$COMP_CWORD" -eq 1 ]; then
        COMPREPLY=($(compgen -W "$commands" -- "$cur"))
        return
    fi

    local cmd="${COMP_WORDS[1]}"
    case "$cmd" in
        update|remove|rollback|skip|unskip|info|set-repo)
            if [ "$COMP_CWORD" -eq 2 ]; then
                local apps=()
                shopt -s nullglob
                for conf in "$HOME/.config/opt-mgr/"*.conf; do
                    apps+=("$(basename "$conf" .conf)")
                done
                shopt -u nullglob
                COMPREPLY=($(compgen -W "${apps[*]}" -- "$cur"))
            fi
            ;;
        install)
            COMPREPLY=($(compgen -f -- "$cur"))
            ;;
        check|upgrade)
            local apps=()
            shopt -s nullglob
            for conf in "$HOME/.config/opt-mgr/"*.conf; do
                apps+=("$(basename "$conf" .conf)")
            done
            shopt -u nullglob
            COMPREPLY=($(compgen -W "all ${apps[*]}" -- "$cur"))
            ;;
        clean)
            local apps=()
            shopt -s nullglob
            for conf in "$HOME/.config/opt-mgr/"*.conf; do
                apps+=("$(basename "$conf" .conf)")
            done
            shopt -u nullglob
            COMPREPLY=($(compgen -W "all ${apps[*]}" -- "$cur"))
            ;;
    esac
}

complete -F _opt_mgr_completion opt-mgr
