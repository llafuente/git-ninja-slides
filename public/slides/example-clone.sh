#!/bin/sh

# clone the entire repo, repeat: everything!
# To develop
git clone <remote>

# Shalow clone
# For CI/CD, just one level history
git clone --depth 1 <remote>

# Fetch all files from a shalow clone
git fetch --unshallow
