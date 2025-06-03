function wait_then_execute
    if test (count $argv) -eq 0
        echo "Usage: wait-and-execute <command>"
        return 1
    end
    
    set execute_command $argv
    set selected_process (ps -eo pid,cmd --no-headers | fzf)
    
    if test -z "$selected_process"
        echo "No process selected."
        return 1
    end
    
    set pid (string split -f1 ' ' $selected_process)
    set process_name (string sub --start (math (string length $pid) + 2) $selected_process | string trim)
    
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "🎯 Selected process:"
    echo "   PID: $pid"
    echo "   Command: $process_name"
    echo "🚀 Will execute: $execute_command"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo ""
    
    set seconds 0
    while kill -0 $pid 2>/dev/null
        sleep 1
        set seconds (math $seconds + 1)
        
        # Use integer division to get whole numbers
        set min (math --scale=0 "$seconds / 60")
        set sec (math --scale=0 "$seconds - $min * 60")
        
        printf "\r⏳ Waiting... %d:%02d" $min $sec
    end
    
    printf "\n\n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n"
    printf "✅ Process finished! Executing command...\n"
    printf "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n\n"
    eval $execute_command
end
