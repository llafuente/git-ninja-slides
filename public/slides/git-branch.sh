git branch # display local branches
git branch -a # display local&remote branches

git branch <BRANCH_NAME> # create local branch
git branch -D <BRANCH_NAME> # delete local branch
git push --delete origin <BRANCH_NAME> # delete remote branch

git checkout <BRANCH_NAME> # move to a branch

# rebuild a branch, discard local, track remote
git branch -D <BRANCH_NAME>
git branch -t <BRANCH_NAME> origin/<BRANCH_NAME> # branch tracking

git fetch --prune origin # clear local branches

git rev-parse --abbrev-ref HEAD # get current branch
