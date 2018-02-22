#!/bin/sh

git init

# add origin
git remote add origin 'http://www.github.com/llafuente/git-repo3'

# rename origin
git remote set-url origin git@github.com:llafuente/*.git

# push!
git push origin master # first time
git push # the rest of your life!
