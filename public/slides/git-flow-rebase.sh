#!/bin/sh

cd $(mktemp -d)

git init
git flow init -d
# we are on master
git flow feature start XXX

echo "git flow file" > flow-file.md
git add flow-file.md
git commit -m "add flow-file.md"

git checkout develop
echo "develop changes" > develop-file.md
git add develop-file.md
git commit -m "modify develop-file.md"

echo "git flow file" > flow-file2.md
git add flow-file2.md
git commit -m "add flow-file2.md"

git checkout feature/XXX
git flow feature finish -rS XXX


git lg
