function run_until_success
    set -l cmd $argv
    
    if test (count $argv) -eq 0
        echo "Usage: run_until_success <command> [args...]"
        return 1
    end
    
    set -l attempt 1
    
    while true
        echo "Attempt $attempt: Running '$cmd'"
        
        if eval $cmd
            echo "Success on attempt $attempt!"
            return 0
        else
            echo "Failed on attempt $attempt (exit code: $status)"
            set attempt (math $attempt + 1)
            sleep 1  # Optional: wait 1 second between attempts
        end
    end
end
