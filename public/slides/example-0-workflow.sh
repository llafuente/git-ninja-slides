#!/bin/sh
set -ex

cd $(mktemp -d)
git init
echo "xxx" > untracked-file.txt
git status
echo "xxx" > tracked-file.txt
git add tracked-file.txt
git status

git commit -m "add tracked-file.txt"

echo "yyy" >> tracked-file.txt
git status

git diff

git stash

git status

git stash list
# NOTE: powershell require single quotes: git 'show stash@{0}'
git show stash@{0}

git stash pop
git status

git add tracked-file.txt
git status

git commit -m "update tracked-file.txt"

# shortcut, add everything in the working copy
echo "zzz" >> tracked-file.txt

git diff --no-pager

git commit -a -m "update again tracked-file.txt"

git log
