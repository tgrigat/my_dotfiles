function sync_notes --description 'Synchronize markdown files from source to destination directory with git auto-commit'
    # Check if we have the required arguments
    if test (count $argv) -lt 2
        echo "Usage: sync_notes <source_dir> <dest_dir>"
        return 1
    end
    
    set SOURCE_DIR $argv[1]
    set DEST_DIR $argv[2]
    
    # Ensure directories end with /
    if not string match -q "*/" $SOURCE_DIR
        set SOURCE_DIR "$SOURCE_DIR/"
    end
    if not string match -q "*/" $DEST_DIR
        set DEST_DIR "$DEST_DIR/"
    end
    
    # Validate source directory exists
    if not test -d $SOURCE_DIR
        echo "Error: Source directory '$SOURCE_DIR' does not exist"
        return 1
    end
    
    # Create destination directory if it doesn't exist
        mkdir -p $DEST_DIR
        
        # Determine git repo root (parent of content directory)
        set GIT_ROOT (dirname $DEST_DIR)
        
        # Validate git repo
        if not test -d "$GIT_ROOT/.git"
                echo "Warning: '$GIT_ROOT' is not a git repository"
                set GIT_ENABLED false
        else
                set GIT_ENABLED true
                echo "Git repository detected at: $GIT_ROOT"
        end
        
        echo "Starting sync from '$SOURCE_DIR' to '$DEST_DIR'"
        
        # Initial sync
        echo "Performing initial sync..."
        rsync -av --delete --include="*.md" --include="*/" --exclude="*" "$SOURCE_DIR" "$DEST_DIR"
        
        if test $status -eq 0
                echo "Initial sync completed successfully"
        else
                echo "Initial sync failed with status: $status"
                return 1
        end
        
        # Initialize git timing variables (in seconds since epoch)
        set LAST_GIT_TIME 0
        set GIT_INTERVAL 1200  # 20 minutes in seconds
        
        echo "Starting file watcher..."
        
        # Watch for changes
        inotifywait -m -r -e create,modify,delete,move "$SOURCE_DIR" --format '%w%f %e' 2>/dev/null | while read -l line
                if test -z "$line"
                        continue
                end
                
                set file_event (string split ' ' $line)
                set file $file_event[1]
                set event $file_event[2]
                
                if string match -q "*.md" $file
                        echo "Detected change: $file ($event)"
                        rsync -av --delete --include="*.md" --include="*/" --exclude="*" "$SOURCE_DIR" "$DEST_DIR"
                        
                        if test $status -eq 0
                                echo "Sync completed for: $file"
                        else
                                echo "Sync failed for: $file (status: $status)"
                                continue
                        end
                        
                        # Git operations (if enabled and enough time has passed)
                        if test "$GIT_ENABLED" = "true"
                                set CURRENT_TIME (date +%s)
                                set TIME_DIFF (math $CURRENT_TIME - $LAST_GIT_TIME)
                                
                                if test $TIME_DIFF -ge $GIT_INTERVAL
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
                                        
                                        # Update last git operation time
                                        set LAST_GIT_TIME $CURRENT_TIME
                                else
                                        set REMAINING_TIME (math $GIT_INTERVAL - $TIME_DIFF)
                                        set REMAINING_MINUTES (math $REMAINING_TIME / 60)
                                        echo "Git operation skipped (next check in ~$REMAINING_MINUTES minutes)"
                                end
                        end
                end
        end
end
