#!/bin/sh
# Claude Code SessionStart hook: error if the handbook is unreadable, warn if it can't sync.
# A missing clone is caught by the guard in the settings.json command (see README).
dir=$(cd "$(dirname "$0")/.." && pwd)

emit() { # $1: message to the user, $2: context for Claude
  printf '{"systemMessage":"%s","hookSpecificOutput":{"hookEventName":"SessionStart","additionalContext":"%s"}}\n' "$1" "$2"
}

if [ ! -r "$dir/AGENTS.md" ] || [ ! -r "$dir/CLAUDE.md" ]; then
  emit "ERROR: agent handbook unreadable at $dir" \
    "The agent handbook at $dir is unreadable. Stop and tell the user before doing any work."
  exit 0
fi

GIT_TERMINAL_PROMPT=0 git -C "$dir" pull --ff-only -q >/dev/null 2>&1 &
pid=$!
(sleep 5 && kill "$pid" 2>/dev/null) &
timer=$!
if ! wait "$pid"; then
  emit "WARNING: agent handbook not synced with GitHub (offline, local changes or diverged). Using local copy at $dir." ""
fi
kill "$timer" 2>/dev/null
exit 0
