# Git Hooks

This directory contains backup copies of Git hooks used in this repository.

## Pre-Push Hook

The `pre-push` hook performs linting on shell scripts before pushing:

- For regular shell scripts (.sh): Uses ShellCheck and Bashate
- For Zsh scripts (.zsh): Uses our custom Zsh linter

### Installation

To install the hook:

```bash
cp hooks-backup/pre-push .git/hooks/
chmod +x .git/hooks/pre-push
```

### Features

- Separate handling for Bash and Zsh scripts
- Custom linting for Zsh-specific syntax
- Helpful error messages and suggestions
- Skips symlinks and non-existent files