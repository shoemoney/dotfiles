#!/usr/bin/env zsh
# =============================================================================
# 🚀 PATH Configuration 🚀
# =============================================================================
# 🛣️ Optimize your PATH for maximum productivity
# 🔍 Carefully ordered for proper precedence

# 🏠 User-specific paths (highest priority)
PATH="$HOME/bin:$PATH"               # 📂 Personal binaries
PATH="$HOME/.bin:$PATH"              # 📂 Additional personal binaries
PATH="$HOME/.local/bin:$PATH"        # 📂 Local user binaries
PATH="$HOME/.cargo/bin:$PATH"        # 🦀 Rust/Cargo binaries
PATH="$HOME/.penv/bin:$PATH"         # 🐍 Python environment binaries

# 🐍 Source Python environment if available
if [ -f "$HOME/.penv/bin/activate" ]; then
  source "$HOME/.penv/bin/activate"  # 🚀 Activate Python environment
fi

# 🍺 Homebrew paths (high priority)
PATH="/opt/homebrew/bin:$PATH"       # 🍺 Homebrew binaries
PATH="/opt/homebrew/sbin:$PATH"      # 🍺 Homebrew system binaries
PATH="/opt/homebrew/opt/coreutils/libexec/gnubin:$PATH" # 🛠️ GNU core utilities
PATH="/opt/homebrew/opt/python/libexec/bin:$PATH"       # 🐍 Homebrew Python
PATH="/opt/homebrew/opt/node/bin:$PATH"                 # 📦 Homebrew Node.js

# 💾 System paths (medium priority)
PATH="/usr/local/bin:$PATH"          # 📦 Local binaries
PATH="/usr/local/Cellar/redis/7.2.5/bin:$PATH"  # 🔄 Redis
PATH="/usr/local/lib/python3.9:$PATH"  # 🐍 Python libraries

# 🔧 System paths (lower priority)
PATH="/usr/bin:$PATH"                # 🖥️ System binaries
PATH="/usr/sbin:$PATH"               # 🔧 System admin binaries

# 🔍 Ensure critical tools are available in PATH
# GitHub CLI
if [ -f "/opt/homebrew/bin/gh" ]; then
  export GH_PATH="/opt/homebrew/bin/gh"
fi

# Neovim
if [ -f "/opt/homebrew/bin/nvim" ]; then
  export NVIM_PATH="/opt/homebrew/bin/nvim"
  export EDITOR="/opt/homebrew/bin/nvim"
  export VISUAL="/opt/homebrew/bin/nvim"
fi

# 🔄 Export the final PATH
export PATH