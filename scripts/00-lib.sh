clone_or_update_repo() {
    local url=$1
    local branch=$2
    local destination=$3

    if [ -d "$destination/.git" ]; then
        cd "$destination" || exit
        git fetch --quiet
        git checkout --quiet "$branch"
        git pull --quiet origin "$branch"
		cd -
    else
        echo "Cloning repository from $url to $destination..."
        git clone --quiet --depth 1 --branch "$branch" "$url" "$destination"
    fi
}
