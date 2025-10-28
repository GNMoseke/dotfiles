function review
    # TODO: allow this to be overriden by an env var or something, for now it's pretty
    # consistent across machines since I generally only do PR review on work machines
    set -l review_root_dir "$HOME/Work/pr-reviews"
    set -l pr_list_full_info (gh pr ls --json headRefName,number,title,body --search "user-review-requested:@me")
    set -l pr_num (echo "$pr_list_full_info" | jq -r '.[] | ((.number | tostring) + ": " + .title)' | fzf --preview 'echo {}' | cut -d':' -f 1)
    echo "$pr_num"
    set -l pr_branch_name (echo "$pr_list_full_info" | jq -r --arg v "$pr_num" 'first(.[] | select((.number | tostring) == $v)).headRefName')
    set -l pr_description (echo "$pr_list_full_info" | jq -r --arg v "$pr_num" 'first(.[] | select((.number | tostring) == $v)).body')

    # swap to jj workspace for review, checkout relevant branch
    set -l repo_name (basename "$(pwd)")
    mkdir -p "$review_root_dir/$repo_name"
    set -l review_dir "$review_root_dir/$repo_name/$pr_num-review"
    echo "$pr_branch_name"
    jj workspace add -r "remote_bookmarks($pr_branch_name)" --name "$pr_num-review" "$review_dir"
    cd "$review_dir"
    jj describe -m "Initial review of $pr_num"

    # Split tmux pane, show full `jj diff` from base ref on left and open a new jj change in vim on the
    # right
    # FIXME: this assumes that PRs always are targeting main, which is generally fair, but
    # I'd like to make this smart enough to get the diff from any generic base branch
    # (template fork_point() function seems correct but I can't get it to do what I
    # expect, maybe still thinking too much in git terms)
    tmux split-window -b -h "jj diff --from 'trunk()' --to @; read -P 'Press enter to continue (this will close the diff pane)'"
    # NOTE: .pr-description.md is globally gitignored
    echo -e "$pr_description" >> .pr-description.md
    nvim -c "set wrap" .pr-description.md

    # Make comments as changes in vim directly, saved on the new change. When vim exits,
    # show another `jj diff` of just the most recent change, with additional surrounding
    # context.
    # TODO: maybe automate parsing those comments into some way to submit to github?
    jj diff --context 5

    # NOTE: choosing *not* to remove review workspace, `jj workspace forget review` because
    # I want to be able to go back to that review workspace and pull new changes when they
    # are added. May change this in the future or do something smarter.
    cd -
end
