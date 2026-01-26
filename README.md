# Homebrew

install homebrew, then brew install:

- git yadm antidote the_silver_searcher bat tig zoxide fzf tldr nvm dtrx
- eugene-babichenko/fixit/fixit


# dotfiles

use `yadm clone` to get dotfiles from github


# zsh

- config directory moved to .zsh/** by specifying a ZDOTHOME in ~/.zshenv
- configured in .zsh/.zshrc
- using antidote, configured via ~/.zsh/.zsh_plugins.txt
- using Powerlevel10k for prompt line
- using vim keybinds


# git


# tig, lazygit...


# Neovim

- vim with superpowers
- configured with lazyvim etc.
- `brew install nvim ripgrep fd lazygit imagemagick tectonic`
- also install `mmcd`` via `npm install -g @mermaid-js/mermaid-cli` for mermaid support


# bat

- replaces `cat`, aliased in .zsh/.zshrc
- configured via .config/bat/config


# tldr

- replaces man pages
- example `tldr ifconfig`


# fixit

- used to fix bungles in the terminal
- enabled in .zsh/.zshrc
- used by typing `fix` in the terminal after a failed command


# zoxide

- replaces `cd`, enabled in .zsh/.zshrc
- whenever you go go to a long path name, the directory is remembered and in future you can cd to the directory name and it will go to the match in history with the highest "weight"


# fzf

- used for fuzzy completion by zoxide
- also available in zsh using `**<TAB>` for fuzzy completion of file names, process ids, hostnames, environment vars, 


# the silver searcher

- use `ag` instead of `grep`


# nvm, nodejs, npm and safe-chain

- `nvm install 24`
- `nvm alias default 24`
- `curl -fsSL https://github.com/AikidoSec/safe-chain/releases/latest/download/install-safe-chain.sh | sh` to install safe-chain


# dtrx

- do the right extraction, unzip whatever you need without knowing specific commands


# tmux

for the tmux plugin manager to work, clone it:

- `git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm`

I'm using plugins to recover dead sessions after disconnect and to restart tmux on boot. I've also got an indicator in the right status bar that shows when the tmux prefix was pressed and tmux is awaiting input.

I'm also using the catppuccin theme for the tmux status line
