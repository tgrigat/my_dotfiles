function remind_me
    # Parse arguments
    set -l options 'h/help' 'm/minutes='
    if not argparse -n remind_me $options -- $argv
        return 1
    end

    # Show help if requested
    if set -q _flag_help
        echo "Usage: remind_me [OPTIONS]"
        echo "Set a reminder for a specified number of minutes (default: 30)."
        echo ""
        echo "Options:"
        echo "  -m, --minutes <MINUTES>  Set the reminder for <MINUTES> minutes"
        echo "  -h, --help               Show this help message"
        return 0
    end

    # Default to 30 minutes if no argument provided
    set minutes 30

    # Use minutes from option if provided
    if set -q _flag_minutes
        set minutes $_flag_minutes
    end

    # Validate minutes is a number
    if not string match -qr '^\d+$' $minutes
        echo "❌ Error: Invalid minutes: '$minutes'"
        return 1
    end

    set seconds (math "$minutes * 60")

    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "⏰ Set a reminder for $minutes minutes from now."
    echo "📲 Will send notification when time is up."
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo ""

    # Countdown
    set total_seconds $seconds
    while test $total_seconds -gt 0
        sleep 1
        set total_seconds (math $total_seconds - 1)
        set min (math --scale=0 "$total_seconds / 60")
        set sec (math --scale=0 "$total_seconds - $min * 60")
        printf "\r⏳ Time remaining: %d:%02d" $min $sec
    end

    printf "\n\n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n"
    printf "⏰ Time's up! Sending notification...\n"
    printf "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n\n"

    # Send notification
    if test -z "$GOTIFY_TOKEN"
        echo "❌ Error: GOTIFY_TOKEN environment variable is not set"
        return 1
    end

    set notification_title "Reminder"
    set notification_message "Time for a break! You've been working for $minutes minutes."

    curl "https://notification.lumeny.io/message?token=$GOTIFY_TOKEN" \
         -F "title=$notification_title" \
         -F "message=$notification_message" \
         -F "priority=5" 2>/dev/null

    if test $status -eq 0
        echo "📲 Notification sent successfully!"
    else
        echo "❌ Failed to send notification"
        return 1
    end
end
