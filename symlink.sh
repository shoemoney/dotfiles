#!/bin/sh -eu
# =============================================================================
# 🔗 Dotfiles Symlink Setup 🔗
# =============================================================================
# 🏠 Creates symlinks from dotfiles repository to home directory
# 🛠️ Links configuration files and bin directory executables

basepath=$(cd "$(dirname "$0")" || exit; pwd)

# symlink dotfiles into ~
# Use an array for better handling
for file in .*; do
    if [ "${file}" != "." ] && [ "${file}" != ".." ] && \
       [ "${file}" != ".git" ]; then
        ln -sf "${basepath}/${file}" ~
    fi
done

# symlink binaries into ~/bin
mkdir -p ~/bin
# Use proper globbing in loop instead of variable
for file in bin/*; do
    ln -sf "${basepath}/${file}" ~/bin
done