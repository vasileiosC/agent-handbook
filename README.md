# agent-handbook

Source of truth for my agent rules: [AGENTS.md](AGENTS.md) for every agent, [CLAUDE.md](CLAUDE.md) for Claude-only rules. Editing rules: [CONTRIBUTING.md](CONTRIBUTING.md).

## Setup on a new machine

1. Clone:
   ```sh
   git clone https://github.com/vasileiosC/agent-handbook ~/Documents/GitHub/agent-handbook
   ```
2. Write `~/.claude/CLAUDE.md`. Claude Code skips a missing import silently, so the first line tells Claude to stop if it fails:
   ```md
   The next line imports the agent handbook, the source of truth for agent rules. If its rules are not in your context, stop and tell the user before doing any work.
   @~/Documents/GitHub/agent-handbook/CLAUDE.md
   ```
3. Add the SessionStart hook to `~/.claude/settings.json` under `hooks`. It pulls the handbook at session start, warns if the pull fails, and errors if the handbook is missing (the inline guard covers a missing clone, which the script can't report):
   ```json
   "SessionStart": [
     {
       "matcher": "startup|resume|clear",
       "hooks": [
         {
           "type": "command",
           "command": "h=\"$HOME/Documents/GitHub/agent-handbook/hooks/session-start.sh\"; [ -r \"$h\" ] && exec sh \"$h\"; printf '{\"systemMessage\":\"ERROR: agent handbook missing at ~/Documents/GitHub/agent-handbook\",\"hookSpecificOutput\":{\"hookEventName\":\"SessionStart\",\"additionalContext\":\"The agent handbook clone is missing. Stop and tell the user before doing any work.\"}}\\n'"
         }
       ]
     }
   ]
   ```
