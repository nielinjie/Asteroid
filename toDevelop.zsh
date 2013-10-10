current=$(current_branch)
git checkout develop
git merge --no-ff feature/$1
git checkout $current
