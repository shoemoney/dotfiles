#!/bin/zsh
# =============================================================================
# 🌐 Environment Variable Configuration 🌐
# =============================================================================
# 🔧 Sets up environment variables and paths
# 🔌 Configures development tools and environments

export TMPDIR="/tmp"
export TZ="AMERICA/CHICAGO"
export MAKE_MODE="unix"
export LANG="en.UTF-8"
export PATH="/bin:/Users/shoemoney/.pyenv/shims:/opt/homebrew/bin:/opt/homebrew/sbin:/Applications/IntelliJ IDEA CE.app/Contents/MacOS:/Applications/PhpStorm.app/Contents/MacOS:/Users/shoemoney/.composer/vendor/bin:/Users/shoemoney/.bin:/usr/local/bin:/usr/bin:/usr/local/sbin:/Users/shoemoney/.local/share/zinit/plugins/starship---starship:/Users/shoemoney/.penv/bin:/Users/shoemoney/.local/share/zinit/polaris/bin:/System/Cryptexes/App/usr/bin:/bin:/usr/sbin:/sbin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/local/bin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/bin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/appleinternal/bin:/opt/X11/bin:/Library/Apple/usr/bin:/usr/local/MacGPG2/bin:/usr/local/zfs/bin:/Users/shoemoney/.local/share/zinit/plugins/zpm-zsh---colors/bin:/opt/homebrew/Cellar/python@3.13/3.13.3/bin"
export CPPFLAGS="-I/opt/homebrew/opt/openjdk@17/include" # for java

# Initialize homebrew environment
if [ -f /opt/homebrew/bin/brew ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)" || true
fi

# Initialize pyenv
if command -v pyenv &>/dev/null; then
    eval "$(pyenv init -)" || true
fi

# for volta
# Set Volta home if it exists
export VOLTA_HOME="${HOME}/.volta"
# Add Volta to path if it exists
if [ -d "${VOLTA_HOME}" ]; then
    export PATH="${VOLTA_HOME}/bin:${PATH}"
fi

# Initialize z (directory jumper)
if command -v brew &>/dev/null && brew --prefix z &>/dev/null; then
    . "$(brew --prefix z)/etc/profile.d/z.sh" || true
fi

#eval "$(direnv hook zsh)" # for direnv

# Set colors for ls and completion
export LS_COLORS='di=36:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
zstyle ':completion:*' list-colors 'di=36' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'

# End of environment configuration

ulimit -n 1024 # avoid "Too many open files"
