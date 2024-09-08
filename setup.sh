#automatically switch to zsh

#install oh-my-zsh
##NOTE: you need to exit from the shell that spawns automatically for the config to complete
sh -c "$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"

if [ ! -d ~/.vim/bundle/Vundle.vim ]; then
  git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi
vim +PluginInstall +qall

~/.vim/bundle/fzf/install

#TODO: script to differentiate between macosx and Linux configs

mkdir -p $HOME/.local/bin
cat zshrc_additions >> $HOME/.zshrc

cp vimrc ~/.vimrc
mkdir -p ~/.vim/colors
cp diff_colors.vim ~/.vim/colors
cp gitconfig ~/.gitconfig
cp tmux.conf ~/.tmux.conf
