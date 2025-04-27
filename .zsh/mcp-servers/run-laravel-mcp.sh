#!/bin/bash
# =============================================================================
# 🚀 Laravel MCP Server Runner 🚀
# =============================================================================
# 🛠️ Runs the Laravel MCP server for Cursor IDE integration
# 🔄 Automatically configures paths and dependencies

# 🔍 Check if required environment variables are set
if [ -z "$LARAVEL_PATH" ]; then
  echo "⚠️ LARAVEL_PATH not set. Please specify your Laravel project path."
  echo "Example: export LARAVEL_PATH=/path/to/your/laravel/project"
  exit 1
fi

# 📂 Get the absolute path to this script's directory
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
MCP_SERVER_PATH="$SCRIPT_DIR/laravel-mcp/server.py"

# 🔍 Verify the server script exists
if [ ! -f "$MCP_SERVER_PATH" ]; then
  echo "❌ Error: Laravel MCP server not found at $MCP_SERVER_PATH"
  exit 1
fi

# 💡 Print configuration info
echo "🚀 Starting Laravel MCP Server"
echo "📂 Laravel Project: $LARAVEL_PATH"
echo "🛠️ MCP Server Path: $MCP_SERVER_PATH"

# 🎮 Run the MCP server
if command -v ~/.local/bin/mcp &> /dev/null; then
  echo "🔌 Using local MCP installation"
  ~/.local/bin/mcp run "$MCP_SERVER_PATH"
elif command -v mcp &> /dev/null; then
  echo "🔌 Using system MCP installation"
  mcp run "$MCP_SERVER_PATH"
else
  echo "❌ Error: MCP command not found. Please install MCP first."
  echo "💡 Tip: Install with 'pip install model-context-protocol'"
  exit 1
fi