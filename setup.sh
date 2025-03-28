#automatically switch to zsh
chsh -s `which zsh`


cp vimrc ~/.vimrc

if [ ! -d ~/.vim/autoload/plug.vim ]; then
   curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
     https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi
vim +PluginInstall +qall

~/.vim/plugged/fzf/install

#TODO: script to differentiate between macosx and Linux configs

mkdir -p $HOME/.local/bin
cat zshrc_additions >> $HOME/.zshrc

mkdir -p ~/.vim/colors
cp diff_colors.vim ~/.vim/colors
cp gitconfig ~/.gitconfig
cp tmux.conf ~/.tmux.conf

#install homebrew
#/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

