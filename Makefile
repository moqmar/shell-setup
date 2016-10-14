help:
	@echo "Usage: make plugins|clean|install|ssh-keygen"
plugins: clean
	git clone https://github.com/itchyny/lightline.vim.git lightline
	mv lightline/autoload lightline/plugin vim
	rm -rf lightline
clean:
	find vim -mindepth 1 -not -path 'vim/colors/*' -not -path vim/colors -not -path vim/vimrc -exec rm -rf {} \+
	rm -rf lightline
install:
	cp vim/vimrc ~/.vimrc
	cp -R vim ~/.vim
	rm -f ~/.vim/vimrc
	[ ! -d ~/.antigen ] && git clone https://github.com/zsh-users/antigen.git ~/.antigen || echo Antigen is already installed
	cat zshrc | sed 's@!!ICON!!@'"`cat icon`"'  @g' > ~/.zshrc
	echo >> ~/.zshrc
	cat zshrc.local >> ~/.zshrc
ssh-keygen:
	[ -d ~/.ssh ] || mkdir ~/.ssh
	[ -f ~/.ssh/id.pub ] && cat ~/.ssh/id.pub || (ssh-keygen -t rsa -b 4096 -N "" -f ~/.ssh/id && cat ~/.ssh/id.pub)