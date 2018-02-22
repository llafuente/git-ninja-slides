#!bin/sh

cd $(mktemp -d)

git init

git remote add origin 'https://github.com/llafuente/git-slides-test'

pre-commit install

cat <<DELIM | tee .pre-commit-config.yaml
repos:
-   repo: https://github.com/llafuente/git-slides-test
    sha: v0.9.4
    hooks:
    -   id: trailing-whitespace
        name: Trim Trailing Whitespace
        description: This hook trims trailing whitespace.
        entry: trailing-whitespace-fixer
        language: python
        types: [text]

DELIM

cat <<DELIM | tee README.md

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse eu dolor condimentum, bibendum nisl vel, placerat ligula.
Ut vulputate mattis accumsan. Morbi vel maximus enim. Aenean vel sem quis arcu malesuada gravida vel nec ante.

Donec sed pharetra sem, vitae lacinia est. Aenean velit nisi, tincidunt eu odio vitae, scelerisque dictum velit. Phasellus a nulla eget
augue blandit maximus. Aenean vel mollis nunc. Phasellus at nisl sed diam feugiat luctus. Etiam a efficitur massa. Cras quis augue ut arcu tempor
vulputate. Fusce massa tortor, vehicula et leo et, tristique luctus dolor. Quisque vulputate pharetra quam at interdum. In sit amet imperdiet lectus.
Pellentesque sit amet lacus massa.

DELIM

git add README.md
git commit -m "first"

cat README.md
