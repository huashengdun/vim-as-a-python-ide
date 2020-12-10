# vim-as-a-python-ide

### Dependencies
```
$ sudo apt install curl vim exuberant-ctags git

$ sudo apt install python3-pip
$ pip3 install pep8 flake8 pyflakes isort pynvim jedi

$ sudo apt install nodejs npm
$ sudo npm install -g jslint tern
```

### Installation
```
$ git clone https://github.com/huashengdun/vim-as-a-python-ide.git
$ cd vim-as-a-python-ide
$ cp vimrc ~/.vimrc
$ vim
```

### Management
```
:PlugUpdate <plugin>     # Only update <plugin>
:PlugUpdate              # Update all plugins
:PlugUpgrade             # Upgrade vim-plug itself

:source %                # Reload .vimrc
:PlugInstall             # Install plugins added
```

### References
1. https://github.com/fisadev/fisa-vim-config -- fisa-vim-config
1. https://github.com/junegunn/vim-plug -- vim-plug
