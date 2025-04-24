# Zsh Linting Guide

This guide explains the Zsh linting setup in this dotfiles repository, designed to ensure high-quality, consistent Zsh scripts.

## Overview

The repository includes a custom Zsh linting system that provides:

1. **Dedicated Zsh linting**: Unlike ShellCheck (which primarily supports Bash), our linting tools are designed specifically for Zsh syntax and conventions.
2. **Automatic fixing**: Common issues can be fixed automatically with the included fixer tool.
3. **Pre-push checks**: The pre-push hook will check both Bash and Zsh scripts using the appropriate linters.

## Tools Included

### 1. `bin/zsh-lint`

A custom Zsh linting script that performs the following checks:

- **Syntax validation**: Verifies that the Zsh script contains valid syntax.
- **Shebang verification**: Checks for proper Zsh shebang line (#!/bin/zsh or #!/usr/bin/env zsh).
- **Style checks**: 
  - Detects trailing whitespace
  - Identifies tab usage (when spaces are preferred)
  - Finds lines longer than 100 characters
  - Ensures files end with a newline
- **Zsh-specific checks**:
  - Flags bash-specific syntax that doesn't work well in Zsh
  - Warns about potentially unquoted variables
- **Formatting checks** (if `shfmt` is installed):
  - Verifies consistent formatting according to Zsh style guidelines

Usage:
```bash
./bin/zsh-lint path/to/your/script.zsh
```

### 2. `bin/zsh-fix`

An automatic fixer for common Zsh script issues:

- **Adds proper shebang** if missing
- **Removes trailing whitespace**
- **Ensures files end with newline**
- **Formats code** using `shfmt` (if available)
- **Fixes variable references** to use `${VAR}` format instead of `$VAR`

Usage:
```bash
./bin/zsh-fix path/to/your/script.zsh
```

The fixer creates a backup of each file before modifying it (with .bak extension).

### 3. Updated Pre-Push Hook

The pre-push Git hook has been updated to:

- Use ShellCheck and Bashate for regular shell scripts (.sh, .bash)
- Use our custom Zsh linter for Zsh scripts (.zsh)
- Provide helpful error messages and fixing suggestions

## Best Practices for Zsh Scripts

1. **Always use the correct shebang**: `#!/bin/zsh` or `#!/usr/bin/env zsh`

2. **Use proper variable quoting**:
   ```zsh
   # Good
   echo "${MY_VAR}"
   
   # Avoid
   echo $MY_VAR
   ```

3. **Prefer spaces over tabs** for indentation (4 spaces recommended)

4. **Always end files with a newline**

5. **Use Zsh-specific features correctly**:
   ```zsh
   # String comparison in Zsh
   if [[ "${var}" == "value" ]]; then
     # ...
   fi
   ```

6. **Keep lines under 100 characters** when possible

7. **Add comments** for non-obvious code sections

8. **Use semantic whitespace** (blank lines between logical sections)

## Fixing Existing Scripts

To fix all Zsh scripts in the repository at once:

```bash
find . -name "*.zsh" -exec ./bin/zsh-fix {} \;
```

## Common Issues and Solutions

1. **ShellCheck reports issues in Zsh files**: This is expected as ShellCheck has limited Zsh support. Use our custom `zsh-lint` tool instead.

2. **Line too long errors**: Break long lines into multiple lines using Zsh line continuation (backslash at end of line).

3. **Variable quoting issues**: Always use `"${var}"` format for variable references.

4. **Inconsistent indentation**: Run `shfmt -i 4 -ln zsh -w script.zsh` to fix.

5. **Missing newline at end of file**: Run `echo "" >> script.zsh` or use the `zsh-fix` tool.

## Adding New Zsh Scripts

When adding new Zsh scripts:

1. Start with the proper shebang: `#!/bin/zsh`
2. Run `zsh-lint` to check for issues before committing
3. Follow the best practices outlined above
4. Use `zsh-fix` to automatically resolve common issues

## Environment-Specific Customizations

For scripts that need to work in different environments:

```zsh
# Check if a command exists before using it
if command -v some-command &>/dev/null; then
    # Use the command
fi

# Set default values for variables
: "${MY_VAR:=default_value}"
```