#!/bin/bash
# =============================================================================
# 🛠️ Shell Aliases and Functions 🛠️
# =============================================================================
# 🔧 Provides helpful aliases and functions for daily shell usage
# 🚀 Makes common operations faster and more convenient
# 💡 Organized by category for better maintainability

# System aliases
alias dmesg='sudo demsg'
alias s="source ~/.zshrc"
alias ls="gls --color=auto" # require `brew install coreutils`
alias ll="ls -l"
alias la="ls -a"
alias lla="ll -a"
alias vi="vim"
alias more="less"
alias cat="bat --theme=base16"
alias ip-release="sudo ipconfig set en0 BOOTP"
alias ip-new="sudo ipconfig set en0 DHCP"
alias cp="cp -p"
alias mkdir="mkdir -p"
alias find="find -E"
alias x="exit"

# Repository navigation (require `brew install ghq peco`)
gi() {
    cd "$(ghq root)/$(ghq list | peco --query "$*")" || return
}

# Function for getting repositories
gg() {
    ghq get -u -p "$1" && cd "$(ghq root)/github.com/${_}" || return
}

# Function for viewing repo in browser (require `brew install ghq peco`)
gho() {
    gh repo view --web "$(ghq list | peco --query "$*" | cut -d "/" -f2,3)"
}

# Git and GitHub related aliases
alias ghb="gh repo view --web"
alias mv="mv -i"
alias rm="mv2trash"
alias grm="/usr/local/bin/grm" # overwite "git rm" alias from git.plugin.zsh, require `brew install coreutils`
alias mysql="mysql --pager='less -S -n -i -F -X' --auto-rehash"
alias pstorm="phpstorm"
alias chm="open -a \"Google Chrome\""
alias atom="open -a /Applications/Atom.app/Contents/MacOS/Atom"
alias diff="colordiff"
alias ydla="youtube-dl -x --audio-format=mp3"
alias ydlv="youtube-dl --format=mp4"

# Function to move file to iTunes import folder
it() {
    mv "$1" ~/Music/iTunes/iTunes\ Media/Automatically\ Add\ to\ iTunes.localized/
}

# Function to clean up old cask versions
brew-cask-cleanup() {
    for c in /usr/local/Caskroom/*; do
        mapfile -t vl < <(ls -t "${c}")
        for v in "${vl[@]:1}"; do
            grm -rf "${c}/${v}"
        done
    done
}

# Function for QuickLook preview
ql() {
    qlmanage -p "$@" >& /dev/null
}

alias tree="tree -N"

# Function to convert date to timestamp
date-to-time() {
    date -j -f "%Y-%m-%d %H:%M:%S" "$1" +%s
}

# Function to convert timestamp to date
time-to-date() {
    date -r "$1" +"%Y-%m-%d %H:%M:%S"
}

# Function for syntax highlighting clipboard contents
hl() {
    pbpaste | highlight -O rtf -S "$1" -s "molokai" -k "Menlo" -K 24 | pbcopy
}

# Development aliases
alias psy="psysh"
alias sed="gsed"
alias sf="bin/console"
alias pu="bin/phpunit --stop-on-failure"
alias chrome='open -a "Google Chrome"'
alias zenn-slug="php -r 'echo substr(md5(uniqid()), 0, 14);' | pbcopy"

# Function to add BOM to a file
add-bom() {
    echo -ne "\xef\xbb\xbf" | cat - "$1" > "$1.bom.csv"
}

# System convenience aliases
alias beep='for i in {1..3}; do afplay /System/Library/Sounds/Glass.aiff; done'
alias rm='rm -Rf'
#gcp 'git add .* && git commit -m $1 || git commit -m \'wip\' '
alias rm='sudo rm -rf'
alias top='btm -b'
alias vim='nvim'
alias vi='nvim'
alias icloud='cd ~/Library/Mobile\ Documents/com\~apple\~CloudDocs/'
alias '?'='gh copilot explain'
alias '??'='gh copilot suggest'
#alias pull='gh pull --rebase'
#alias push='gh push --force'
#alias fu='gcp && push ||pull && gcp'