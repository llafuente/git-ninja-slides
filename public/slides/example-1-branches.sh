#!/bin/sh

# this example resume the last example, workflow first
set -ex
git lg

git branch develop
git branch feature-XXX

git branch -a

git lg

echo "this is a feature and its bug free!" > feature-XXX.md
git add feature-XXX.md
git commit -m "feature-XXX wip"

git checkout develop
echo "develop-file" > develop-file.md
git add develop-file.md
git commit -m "add develop-file.md"

git checkout feature-XXX
echo "moarrr!!" > feature-XXX.md
git add feature-XXX.md
git commit -m "#closes feature-XXX"

git lg

git merge develop

# NOTE current branch can't be removed
git checkout develop
git branch -D feature-XXX

git lg
