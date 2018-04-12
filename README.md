# vim-as-a-python-ide

### Features
* Python 2 and Python 3 supported, base on your vim compile options.
* Python syntax checking suppored, use flake8 as a checker.
* Python auto completion supported, use plugin vim-jedi. 
* Virtualenv suppored, use plugin vim-virtualenv.
* JavaScipt syntax checking supported, use jslint as a checker.

### Dependencies
```
$ sudo apt-get install curl vim exuberant-ctags git
$ sudo pip install pep8 flake8 pyflakes isort
```

### Installation
```
$ git clone https://github.com/huashengdun/vim-as-a-python-ide.git
$ cd vim-as-a-python-ide
$ cp vimrc ~/.vimrc
$ vim
```

### Update & Upgrade
```
$ vim                    # Commands below are run in vim command mode
:PlugUpdate <plugin>     # Only update plugin
:PlugUpdate              # Update all plugins
:PlugUpgrade             # Upgrade vim-plug itself
```
