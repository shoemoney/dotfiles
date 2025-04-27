#!/usr/bin/env zsh
# =============================================================================
# 🔒 Automatic File Backup System 🔒
# =============================================================================
# 🛡️ Creates daily backups of files before editing
# 📂 Stores backups in .backups folder with date-based naming
# 🧹 Manages backup retention automatically

# 🚀 Function to backup a file before editing
backup_file() {
    local file_path="$1"
    local current_dir=$(dirname "$file_path")
    local filename=$(basename "$file_path")
    local date_stamp=$(date +"%d-%m-%Y")
    local backup_dir="${current_dir}/.backups"
    local backup_path="${backup_dir}/${date_stamp}.${filename}"
    
    # 📂 Create backup directory if it doesn't exist
    if [[ ! -d "$backup_dir" ]]; then
        echo "🔹 Creating backup directory: ${backup_dir}"
        mkdir -p "$backup_dir"
    fi
    
    # 🛑 Skip if file doesn't exist
    if [[ ! -f "$file_path" ]]; then
        echo "⚠️ File does not exist: ${file_path}. Nothing to backup."
        return 0
    fi
    
    # 🔄 Create backup with permissions preserved
    cp -p "$file_path" "$backup_path"
    
    # ✅ Confirm backup was created
    if [[ -f "$backup_path" ]]; then
        echo "✅ Backup created: ${backup_path}"
    else
        echo "❌ Failed to create backup of: ${file_path}"
        return 1
    fi
    
    # 🧹 Cleanup old backups (keep only 5 most recent for each file)
    cleanup_old_backups "$filename" "$backup_dir"
    
    return 0
}

# 🧹 Function to clean up old backups
cleanup_old_backups() {
    local filename="$1"
    local backup_dir="$2"
    local max_backups=5
    
    # 📊 List all backups for this file, sorted by date (oldest first)
    local backups=($(ls -1t "${backup_dir}/"*".${filename}" 2>/dev/null))
    local backup_count=${#backups[@]}
    
    # 🗑️ Remove backups beyond the maximum count
    if [[ $backup_count -gt $max_backups ]]; then
        echo "🧹 Cleaning up old backups for: ${filename}"
        for ((i=$max_backups; i<$backup_count; i++)); do
            echo "🗑️ Removing old backup: ${backups[$i]}"
            rm "${backups[$i]}"
        done
    fi
}

# 🔧 Create aliases for common edit commands
alias vi="backup_file \$1 && nvim \$1"
alias vim="backup_file \$1 && nvim \$1"
alias nano="backup_file \$1 && nano \$1"
alias edit="backup_file \$1 && $EDITOR \$1"

# 📝 Define custom function for editing that includes backup
edit_with_backup() {
    if [[ -z "$1" ]]; then
        echo "⚠️ Usage: edit_with_backup <file_path>"
        return 1
    fi
    
    backup_file "$1" && $EDITOR "$1"
}

# 🔍 Export the function for use in other scripts
export -f backup_file
export -f cleanup_old_backups
export -f edit_with_backup

# 💡 Add convenient alias
alias bak="backup_file"
alias edit="edit_with_backup"

echo "🔒 File backup system loaded! Use 'edit' command to edit files with automatic backup."