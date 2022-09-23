cd ~

git clone -b main git@github.com:Vivien-lelouette/dotfiles.git .dotfiles

cd ~/.dotfiles

stow emacs kmonad fonts trackball

sudo sh ~/.nixos-configuration/scripts/deploy-keyd.sh

