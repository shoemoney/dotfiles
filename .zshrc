#!/usr/bin/env zsh
# =============================================================================
# 🚀 High-Performance ZSH Configuration 🚀
# =============================================================================
# 🔋 Optimized for speed, productivity, and developer happiness
# 🧰 Modular design with lazy-loading and performance optimizations

# Terminal and environment setup
if [[ "$TERM" == "xterm-ghostty" || "$TERM" == "ghostty" ]]; then
  export TERM="xterm-256color"
fi

# Prevent duplicate compinit calls
skip_global_compinit=1

# History configuration
HISTSIZE=90000
SAVEHIST=90000
HISTFILE=~/.zsh_history

# Load plugin manager
ZINIT_HOME="${HOME}/.zinit/bin"
if [[ -f "${ZINIT_HOME}/zinit.zsh" ]]; then
  source "${ZINIT_HOME}/zinit.zsh"
  autoload -Uz _zinit
  (( ${+_comps} )) && _comps[zinit]=_zinit
else
  echo "⚠️  Zinit not found. Installing..."
  mkdir -p "${HOME}/.zinit"
  git clone https://github.com/zdharma-continuum/zinit.git "${HOME}/.zinit/bin"
  source "${ZINIT_HOME}/zinit.zsh"
  autoload -Uz _zinit
  (( ${+_comps} )) && _comps[zinit]=_zinit
fi

# Essential plugins with turbo mode
# Define a function to safely load zinit plugins
load_plugin() {
  local plugin_name=$1
  local plugin_type=${2:-light}  # Default to light loading
  
  if [[ -n "$plugin_name" ]]; then
    if [[ "$plugin_type" == "load" ]]; then
      zinit load "$plugin_name" 2>/dev/null || echo "⚠️  Plugin $plugin_name not loaded"
    else
      zinit light "$plugin_name" 2>/dev/null || echo "⚠️  Plugin $plugin_name not loaded"
    fi
  fi
}

# Load essential plugins, failing gracefully if they don't exist
load_plugin "zsh-users/zsh-autosuggestions"
load_plugin "zdharma-continuum/fast-syntax-highlighting"
load_plugin "zdharma-continuum/history-search-multi-word" "load"
load_plugin "zsh-users/zsh-completions"
load_plugin "chrissicool/zsh-256color"

# Optimized completion initialization
autoload -Uz compinit
if [[ -n ${ZDOTDIR:-$HOME}/.zcompdump(#qN.mh+24) ]]; then
  compinit
else
  compinit -C
fi

# Source critical config files with lazy loading
# Core configuration first
[[ -f ~/.zsh/setops.zsh ]] && source ~/.zsh/setops.zsh
[[ -f ~/.zsh/zstyle.zsh ]] && source ~/.zsh/zstyle.zsh

# UI and interaction
[[ -f ~/.zsh/key_bindings.zsh ]] && source ~/.zsh/key_bindings.zsh
[[ -f ~/.zsh/prompt.zsh ]] && source ~/.zsh/prompt.zsh

# Additional functionality
[[ -f ~/.zsh/mcp-config.zsh ]] && source ~/.zsh/mcp-config.zsh

# Load other config files if they exist
for config_file in ~/.zsh/*.zsh; do
  config_name=$(basename "$config_file")
  if [[ "$config_name" != "setops.zsh" && \
        "$config_name" != "zstyle.zsh" && \
        "$config_name" != "key_bindings.zsh" && \
        "$config_name" != "prompt.zsh" && \
        "$config_name" != "mcp-config.zsh" ]]; then
    source "$config_file"
  fi
done

# Create utility functions file if it doesn't exist
if [[ ! -f ~/.zsh/utility_functions.zsh ]]; then
  mkdir -p ~/.zsh
  cat > ~/.zsh/utility_functions.zsh << 'EOF'
#!/bin/zsh
# =============================================================================
# 🛠️  Utility Functions 🛠️
# =============================================================================
# 🔧 Helper functions to make life easier
# 🚀 Utils for DNS, performance tracking, and system management

# Function to flush DNS cache based on macOS version
flush_dns() {
    local LONGVERSION=$(sw_vers -productVersion)
    local MINOR=$(echo $LONGVERSION | cut -d. -f2)
    local UPDATE=$(echo $LONGVERSION | cut -d. -f3)
    local FLUSH

    if (( $MINOR < 7 )) ; then 
        FLUSH="dscacheutil -flushcache"
    elif (( $MINOR < 10 )) ; then
        FLUSH="killall -HUP mDNSResponder"
    elif (( $MINOR == 10 )) ; then
        if (( $UPDATE < 4 )) ; then
            FLUSH="discoveryutil mdnsflushcache"
        else
            FLUSH="killall -HUP mDNSResponder"
        fi
    else
        echo "VERSION $LONGVERSION"
        FLUSH="killall -HUP mDNSResponder"
        echo "¯\_(ツ)_/¯"
    fi

    echo "Flushing DNS Cache for $LONGVERSION"
    echo "$FLUSH #(งツ)ว"
    eval $FLUSH
}

# Command execution timer setup
timer_start() {
  TIMER=${TIMER:-$SECONDS}
}

timer_stop() {
  if [[ $TIMER ]]; then
    timer_show=$(($SECONDS - $TIMER))
    unset TIMER
    if [[ $timer_show -ge 3 ]]; then
      echo "${fg[cyan]}>>> Execution time: ${timer_show}s${reset_color}"
    fi
  fi
}

autoload -Uz add-zsh-hook
add-zsh-hook preexec timer_start
add-zsh-hook precmd timer_stop
EOF
fi

# Initialize timer for command execution time tracking
timer=${timer:-$SECONDS}

# Source utility functions
[[ -f ~/.zsh/utility_functions.zsh ]] && source ~/.zsh/utility_functions.zsh

# Source git automation scripts
if [[ -f ~/.zsh/scripts/git_autocommit.zsh ]]; then
  source ~/.zsh/scripts/git_autocommit.zsh
fi

# Source file backup system
if [[ -f ~/.zsh/scripts/file_backup.zsh ]]; then
  source ~/.zsh/scripts/file_backup.zsh
fi
