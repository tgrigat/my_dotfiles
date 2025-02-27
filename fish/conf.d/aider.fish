# aider specific settings

set -x AIDER_DARK_MODE true
set -x AIDER_AUTO_COMMITS false
set -x AIDER_GITIGNORE false
set -x AIDER_VIM true
# set -x AIDER_SONNET true
# set -x AIDER_DEEPSEEK true
set -x AIDER_SUGGEST_SHELL_COMMANDS false
set -x AIDER_MODEL anthropic/claude-3.7-sonnet
# alias aider="aider --model openrouter/anthropic/claude-3.5-sonnet"
alias aider="aider --model sonnet"
