#!/bin/sh

# this example resume the last example, workflow first
set -ex
git lg

git branch develop
git branch feature-001

git branch -a

git lg

git checkout feature-001
echo "this is a feature and its bug free" > feature-001.md
git add feature-001.md
git commit -m "feature-001 wip"

git checkout develop
echo "develop-file" > develop-file.md
git add develop-file.md
git commit -m "add develop-file.md"

git checkout feature-001
echo "continue working on feature 001" > feature-001.md
git commit -a -m "#closes feature-001"

git lg

git checkout develop
git rebase feature-001

# NOTE current branch can't be removed
git branch -D feature-001

git lg
