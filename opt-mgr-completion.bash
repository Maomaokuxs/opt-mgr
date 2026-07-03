# bash completion for opt-mgr
# 安装: source ~/.local/bin/opt-mgr-completion.bash

_opt_mgr_completion() {
    local cur prev words cword
    _init_completion || return

    local commands="install update remove rollback skip unskip info list set-repo check upgrade cleanup"

    if [ "$cword" -eq 1 ]; then
        COMPREPLY=($(compgen -W "$commands" -- "$cur"))
        return
    fi

    local cmd="${words[1]}"
    case "$cmd" in
        update|remove|rollback|skip|unskip|info|set-repo)
            if [ "$cword" -eq 2 ]; then
                # 列出所有已管理的应用名
                local apps=()
                for conf in "$HOME/.config/opt-mgr/"*.conf; do
                    [ -f "$conf" ] || continue
                    apps+=("$(basename "$conf" .conf)")
                done
                COMPREPLY=($(compgen -W "${apps[*]}" -- "$cur"))
            fi
            ;;
        install)
            if [ "$cword" -eq 2 ]; then
                COMPREPLY=($(compgen -f -- "$cur"))
            fi
            ;;
        check|upgrade)
            # 可选的应用名
            local apps=()
            for conf in "$HOME/.config/opt-mgr/"*.conf; do
                [ -f "$conf" ] || continue
                apps+=("$(basename "$conf" .conf)")
            done
            COMPREPLY=($(compgen -W "${apps[*]}" -- "$cur"))
            ;;
    esac
}

complete -F _opt_mgr_completion opt-mgr
