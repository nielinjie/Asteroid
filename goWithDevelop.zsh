current=$(current_branch)
git checkout feature/$1
git merge develop
git checkout $current
