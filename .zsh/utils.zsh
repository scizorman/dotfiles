kas(){
    type "${1:?too few arguments}" &> /dev/null
}

# Returns true if cwd is in git repository
is_git_repo(){
    git rev-parse --is-inside-work-tree &> /dev/null
    return $status
}
