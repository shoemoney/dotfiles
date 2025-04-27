#!/usr/bin/env zsh
# =============================================================================
# 🧠 MCP (Model Context Protocol) Configuration 🧠
# =============================================================================
# 🔌 Setup for various MCP servers for AI-enhanced development
# 🚀 Configures paths, aliases and helper functions

# 📂 Define MCP server paths
export MCP_SERVERS_DIR="$HOME/dotfiles/.zsh/mcp-servers"

# 🔄 Laravel MCP Configuration
export LARAVEL_MCP_PATH="$MCP_SERVERS_DIR/laravel-mcp"
alias laravel-mcp="LARAVEL_PATH=\$PWD $MCP_SERVERS_DIR/run-laravel-mcp.sh"

# 🌟 Helper function to list all available MCP servers
mcp-list() {
  echo "🧠 Available MCP Servers:"
  echo "==================================================="
  echo "💻 Laravel MCP: laravel-mcp"
  echo "   - Tools for Laravel development in Cursor IDE"
  echo "   - Usage: cd /your/laravel/project && laravel-mcp"
  echo ""
  echo "🔍 Use any alias above to start the corresponding MCP server"
}

# 🚀 Helper function to show MCP server status
mcp-status() {
  echo "🔍 Checking MCP server status..."
  
  # Check if the mcp command is available
  if ! command -v mcp &> /dev/null; then
    echo "❌ MCP not installed. Install with: pip install model-context-protocol"
    return 1
  fi
  
  # Check running MCP servers
  local running_servers=$(ps aux | grep "[m]cp run" | wc -l)
  
  if [ "$running_servers" -gt 0 ]; then
    echo "✅ MCP servers running: $running_servers"
    ps aux | grep "[m]cp run" | awk '{print "   - " $NF}'
  else
    echo "❌ No MCP servers currently running"
  fi
}

# 🛠️ Helper function to restart MCP servers
mcp-restart() {
  echo "🔄 Restarting MCP servers..."
  pkill -f "mcp run" || echo "No running MCP servers found."
  echo "✅ All MCP servers stopped. Start them manually as needed."
}

# 📋 Print helpful message when this file is sourced
echo "🧠 MCP configuration loaded. Type 'mcp-list' to see available servers."