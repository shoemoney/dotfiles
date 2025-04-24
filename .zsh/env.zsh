export TMPDIR="/tmp"
export TZ="AMERICA/CHICAGO"
export MAKE_MODE="unix"
export LANG="en.UTF-8"
export PATH="/bin:/Users/shoemoney/.pyenv/shims:/opt/homebrew/bin:/opt/homebrew/sbin:/Applications/IntelliJ IDEA CE.app/Contents/MacOS:/Applications/PhpStorm.app/Contents/MacOS:/Users/shoemoney/.composer/vendor/bin:/Users/shoemoney/.bin:/usr/local/bin:/usr/bin:/usr/local/sbin:/Users/shoemoney/.local/share/zinit/plugins/starship---starship:/Users/shoemoney/.penv/bin:/Users/shoemoney/.local/share/zinit/polaris/bin:/System/Cryptexes/App/usr/bin:/bin:/usr/sbin:/sbin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/local/bin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/bin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/appleinternal/bin:/opt/X11/bin:/Library/Apple/usr/bin:/usr/local/MacGPG2/bin:/usr/local/zfs/bin:/Users/shoemoney/.local/share/zinit/plugins/zpm-zsh---colors/bin:/opt/homebrew/Cellar/python@3.13/3.13.3/bin"
export CPPFLAGS="-I/opt/homebrew/opt/openjdk@17/include" # for java

eval "$(/opt/homebrew/bin/brew shellenv)" # for homebrew
eval "$(pyenv init -)" # for pyenv

# for volta
#export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"

. $(brew --prefix z)/etc/profile.d/z.sh # for z

#eval "$(direnv hook zsh)" # for direnv

export LS_COLORS='di=36:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
zstyle ':completion:*' list-colors 'di=36' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'

ulimit -n 1024 # avoid "Too many open files"
