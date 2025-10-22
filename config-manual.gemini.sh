#!/bin/bash

# ssh keys
ssh-keygen -t ed25519 -C $email
# start agent and add key
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
# export to github 
cat ~/.ssh/id_ed25519.pub
# test the key
ssh -T git@github.com

# generate and configure gpg
gpg --full-generate-key
gpg --list-secret-keys --keyid-format=long
# export to github
gpg --armor --export $gpg-key-id

# configure git
git config --global user.name $name
git config --global user.email $email

git config --global user.signingkey $gpg-key-id
git config --global commit.gpgsign true
git config --global core.editor "emacs -nw"

git init --bare $home/.dotfiles

alias configshortcut='/usr/bin/git --git-dir=$home/.dotfiles --work-tree=$home'

configshortcut config --local status.showUntrackedFiles no

echo "alias configshortcut='/usr/bin/git --git-dir=$home/.dotfiles --work-tree=$home'" >> ~/.bashrc

configshortcut add ~/.gitconfig

configshortcut commit -S -m "init commit: add .gitconfig"

configshortcut remote add origin git@github.com:$github_username/$dotfiles_repo_name.git

configshortcut push --set-upstream origin main

use $configshortcut to add other files
