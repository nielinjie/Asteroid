current=$(current_branch)
git checkout master 
git merge --no-ff develop
git checkout $current
