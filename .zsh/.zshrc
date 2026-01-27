# source antidote
source $(brew --prefix)/opt/antidote/share/antidote/antidote.zsh

# initialize plugins statically with ${ZDOTDIR:-~}/.zsh_plugins.txt
antidote load


# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# To customize prompt, run `p10k configure` or edit ~/.zsh/.p10k.zsh.
[[ ! -f ~/.zsh/.p10k.zsh ]] || source ~/.zsh/.p10k.zsh


# enable vim keybinds
bindkey -v

# bind k and j for VI mode
# bindkey -M vicmd 'k' history-substring-search-up
# bindkey -M vicmd 'j' history-substring-search-down

# set nvim as default editor
export EDITOR=nvim

# alias vim to nvim
alias vim="nvim"

# use bat instead of cat
alias cat="bat"

# better 'cd' functionality
eval "$(zoxide init --cmd cd zsh)"

# fzf key bindings and fuzzy completion
source <(fzf --zsh)

# fix shell typos and other mistakes
eval "$(fixit init zsh)"


# Load NVM installed via Homebrew
export NVM_DIR="$HOME/.nvm"
[ -s "$(brew --prefix nvm)/nvm.sh" ] && \. "$(brew --prefix nvm)/nvm.sh"
[ -s "$(brew --prefix nvm)/etc/bash_completion.d/nvm" ] && \. "$(brew --prefix nvm)/etc/bash_completion.d/nvm"


source ~/.safe-chain/scripts/init-posix.sh # Safe-chain Zsh initialization script

# Source all files in a host-specific directory
HOST_CONFIG_DIR=~/.zsh/hosts/$HOST
if [ -d "$HOST_CONFIG_DIR" ]; then
  for file in "$HOST_CONFIG_DIR"/*; do
    if [ -f "$file" ]; then
      source "$file"
    fi
  done
fi

