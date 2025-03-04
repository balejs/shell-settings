#automatically switch to zsh

#install oh-my-zsh
##NOTE: you need to exit from the shell that spawns automatically for the config to complete
#sh -c "$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

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

