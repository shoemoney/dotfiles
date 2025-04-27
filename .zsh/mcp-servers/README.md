# MCP Servers Collection 🧠

This directory contains various MCP (Model Context Protocol) server implementations to enhance AI integration with your development workflow.

## Available Servers 🚀

### Laravel MCP
- **Description**: Tools for Laravel development in Cursor IDE
- **Repository**: [jsonallen/laravel-mcp](https://github.com/jsonallen/laravel-mcp)
- **Usage**: `cd /your/laravel/project && laravel-mcp`

## Setup Instructions 🛠️

1. **Install MCP**:
   ```bash
   pip install mcp-python-client
   ```

2. **Configure Your Environment**:
   - The `mcp-config.zsh` file in your dotfiles automatically sets up aliases and paths
   - Use the helper commands below to manage your MCP servers

## Helper Commands 💡

- `mcp-list`: List all available MCP servers
- `mcp-status`: Check the status of running MCP servers
- `mcp-restart`: Restart all MCP servers

## Adding New Servers 🔌

To add a new MCP server:

1. Clone the repository into this directory
2. Add the configuration to `mcp-config.zsh`
3. Create a runner script if needed

## Troubleshooting 🔍

If you encounter issues:

1. Check if the MCP package is installed: `pip list | grep mcp`
2. Verify your Laravel project path is correct
3. Run `mcp-status` to see if any servers are running
4. Check for error logs in the server output