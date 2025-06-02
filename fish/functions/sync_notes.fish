function sync_notes --description 'Synchronize markdown files from source to destination directory with git auto-commit'
    __sync_notes_validate_args $argv; or return 1
    __sync_notes_setup_directories $argv[1] $argv[2]; or return 1
    __sync_notes_perform_initial_sync; or return 1
    __sync_notes_start_polling_loop
end

function __sync_notes_validate_args
    if test (count $argv) -lt 2
        echo "Usage: sync_notes <source_dir> <dest_dir>"
        return 1
    end
end

function __sync_notes_setup_directories
    set -g SOURCE_DIR $argv[1]
    set -g DEST_DIR $argv[2]
    
    # Ensure directories end with /
    if not string match -q "*/" $SOURCE_DIR
        set -g SOURCE_DIR "$SOURCE_DIR/"
    end
    if not string match -q "*/" $DEST_DIR
        set -g DEST_DIR "$DEST_DIR/"
    end
    
    # Validate source directory exists
    if not test -d $SOURCE_DIR
        echo "Error: Source directory '$SOURCE_DIR' does not exist"
        return 1
    end
    
    # Create destination directory if it doesn't exist
    mkdir -p $DEST_DIR
    
    # Determine git repo root (parent of content directory)
    set -g GIT_ROOT (dirname $DEST_DIR)
    
    # Validate git repo
    if not test -d "$GIT_ROOT/.git"
        echo "Warning: '$GIT_ROOT' is not a git repository"
        set -g GIT_ENABLED false
    else
        set -g GIT_ENABLED true
        echo "Git repository detected at: $GIT_ROOT"
    end
end

function __sync_notes_perform_initial_sync
    echo "Starting sync from '$SOURCE_DIR' to '$DEST_DIR'"
    echo "Performing initial sync..."
    
    rsync -av --delete --include="*.md" --include="*/" --exclude="*" "$SOURCE_DIR" "$DEST_DIR"
    
    if test $status -eq 0
        echo "Initial sync completed successfully"
    else
        echo "Initial sync failed with status: $status"
        return 1
    end
end

function __sync_notes_start_polling_loop
    # Initialize git timing variables (in seconds since epoch)
    set -g LAST_GIT_TIME 0
    set -g GIT_INTERVAL 1200  # 20 minutes in seconds
    
    echo "Starting polling watcher (checking every 5 seconds)..."
    
    # Create timestamp file for tracking changes
    touch /tmp/sync_notes_timestamp
    
    # Polling loop
    while true
        sleep 5
        
        if __sync_notes_check_for_changes
            __sync_notes_perform_sync; or continue
            __sync_notes_handle_git_operations
        end
    end
end

function __sync_notes_check_for_changes
    # Check if source directory has been modified recently
    set SOURCE_MODIFIED (find "$SOURCE_DIR" -name "*.md" -newer /tmp/sync_notes_timestamp 2>/dev/null | wc -l)
    test $SOURCE_MODIFIED -gt 0
end

function __sync_notes_perform_sync
    # Update timestamp file
    touch /tmp/sync_notes_timestamp
    echo "Changes detected, syncing..."
    
    rsync -av --delete --include="*.md" --include="*/" --exclude="*" "$SOURCE_DIR" "$DEST_DIR"
    
    if test $status -eq 0
        echo "Sync completed successfully"
    else
        echo "Sync failed (status: $status)"
        return 1
    end
end

function __sync_notes_handle_git_operations
    # Git operations (if enabled and enough time has passed)
    if test "$GIT_ENABLED" = "true"
        if __sync_notes_should_run_git_operation
            __sync_notes_git_commit_and_push
            set -g LAST_GIT_TIME (date +%s)
        else
            __sync_notes_show_git_wait_time
        end
    end
end

function __sync_notes_should_run_git_operation
    set CURRENT_TIME (date +%s)
    set TIME_DIFF (math $CURRENT_TIME - $LAST_GIT_TIME)
    test $TIME_DIFF -ge $GIT_INTERVAL
end

function __sync_notes_show_git_wait_time
    set CURRENT_TIME (date +%s)
    set TIME_DIFF (math $CURRENT_TIME - $LAST_GIT_TIME)
    set REMAINING_TIME (math $GIT_INTERVAL - $TIME_DIFF)
    set REMAINING_MINUTES (math $REMAINING_TIME / 60)
    echo "Git operation skipped (next check in ~$REMAINING_MINUTES minutes)"
end

function __sync_notes_git_commit_and_push
    echo "Checking for git changes..."
    
    # Change to git repo directory
    pushd "$GIT_ROOT" >/dev/null
    
    # Check if there are any changes
    if git diff --quiet; and git diff --cached --quiet
        echo "No git changes detected"
    else
        set COMMIT_DATE (date '+%Y-%m-%d %H:%M:%S')
        set COMMIT_MSG "note: automatic commit at $COMMIT_DATE"
        
        echo "Committing changes to git..."
        git add .
        git commit -m "$COMMIT_MSG"
        
        if test $status -eq 0
            echo "Git commit successful"
            
            echo "Pushing to remote..."
            git push
            
            if test $status -eq 0
                echo "Git push successful"
            else
                echo "Git push failed (status: $status)"
            end
        else
            echo "Git commit failed (status: $status)"
        end
    end
    
    # Return to previous directory
    popd >/dev/null
end
