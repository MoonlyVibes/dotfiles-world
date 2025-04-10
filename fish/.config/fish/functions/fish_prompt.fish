function fish_prompt --description 'Write out the prompt'
    set -l last_status $status
    set -l normal (set_color normal)
    set -l status_color (set_color brgreen)
    set -l cwd_color (set_color --bold cyan)
    set -l vcs_color (set_color white)
    set -l prompt_status ""

    # Since we display the prompt on a new line, allow longer directory names
    set -q fish_prompt_pwd_dir_length; or set -lx fish_prompt_pwd_dir_length 0

    set -l suffix '>'

    # Root user prompt customization
    if functions -q fish_is_root_user; and fish_is_root_user
        if set -q fish_color_cwd_root
            set cwd_color (set_color $fish_color_cwd_root)
        end
        set suffix '#'
    end

    # Set prompt color on error
    if test $last_status -ne 0
        set status_color (set_color $fish_color_error)
    end

    # Output the prompt
    echo -s $cwd_color (prompt_pwd) $vcs_color (fish_vcs_prompt) $normal ' ' $prompt_status
    echo -n -s (set_color --bold) $status_color $suffix ' ' $normal
end
