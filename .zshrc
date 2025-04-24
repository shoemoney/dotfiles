# Fix for terminal issues - must happen before anything else
if [[ "$TERM" == "xterm-ghostty" || "$TERM" == "ghostty" ]]; then
  export TERM="xterm-256color"
fi

# Suppress "You have new mail" message
export MAILCHECK=0

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Fix for Powerlevel10k instant prompt warnings
typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet

### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh" || echo "couldnt source zinit"
# Only activate python env if it exists and we're in an interactive shell
if [[ -f "$HOME/.penv/bin/activate" && -o interactive ]]; then
  source "$HOME/.penv/bin/activate" >/dev/null 2>&1
fi
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    Aloxaf/fzf-tab \


    zinit light zpm-zsh/colors
setopt autocd
zinit light zsh-users/zsh-autosuggestions
zinit light zdharma/fast-syntax-highlighting
zinit load zdharma/history-search-multi-word
# Don't load other prompts when using Starship
# Load starship theme - Enabled by default
# line 1: `starship` binary as command, from github release
# line 2: starship setup at clone(create init.zsh, completion)
# line 3: pull behavior same as clone, source init.zsh
zinit ice as"command" from"gh-r" \
          atclone"./starship init zsh > init.zsh; ./starship completions zsh > _starship" \
          atpull"%atclone" src"init.zsh"
zinit light starship/starship

# Disabled themes - uncomment to enable
# # Load powerlevel10k theme
# zinit ice depth"1" # git clone depth
# zinit light romkatv/powerlevel10k
# 
# # Load pure theme
# zinit ice pick"async.zsh" src"pure.zsh" # with zsh-async library that's bundled with it.
# zinit light sindresorhus/pure

# show colorful
zinit light chrissicool/zsh-256color

# some additional plugins
zinit snippet OMZP::git
zinit snippet OMZP::composer
zinit light supercrabtree/k

# theming
zinit snippet OMZL::git.zsh # zinit theming system depends on this
zinit snippet OMZL::theme-and-appearance.zsh # some themes depends on this
zinit snippet OMZL::spectrum.zsh # some themes depends on this
# https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
#zinit snippet OMZT::robbyrussell

setopt NO_NOMATCH

# make case-insensitive
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# enable to select completions by cursor
zstyle ':completion:*:default' menu select=1

# Ensure tab completion works properly
bindkey '\t' complete-word       # Tab
bindkey '^[[Z' reverse-menu-complete  # Shift+Tab

# change select-word-style
autoload -Uz select-word-style
select-word-style bash
WORDCHARS=''

# read additional config
source ~/.zsh/env.zsh
source ~/.zsh/alias.zsh
source ~/.zsh/secret.zsh
source ~/.zsh/key_bindings.zsh       # Load keyboard bindings for better terminal support
source ~/.zsh/completion_style.zsh   # Load enhanced tab completion styling
source ~/.zsh/fzf-config.zsh         # Load FZF and tab completion enhancements
source ~/.zsh/terminal_enhancements.zsh  # Load advanced terminal features
source ~/.zsh/env_detector.zsh       # Load environment detector for status bar
source ~/.zsh/productivity.zsh       # Load productivity tracking system
source ~/.zsh/cool_aliases.zsh       # Load awesome aliases and functions
source ~/.zsh/smart-cd.zsh           # Load enhanced directory navigation
source ~/.zsh/mcp-config.zsh         # Load MCP server configuration
source ~/.zsh/welcome.zsh            # Load beautiful welcome screen
# The following lines have been added by Docker Desktop to enable Docker CLI completions.
fpath=(/Users/shoemoney/.docker/completions $fpath)
autoload -Uz compinit
compinit
# Removed undefined function reference

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# bun completions
[ -s "/Users/shoemoney/.bun/_bun" ] && source "/Users/shoemoney/.bun/_bun" >/dev/null 2>&1

# This section was moved to the top of the file
