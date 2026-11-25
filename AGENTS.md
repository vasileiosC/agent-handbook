# Agent handbook

Rules for agentic development in every repo. Before changing this handbook, read [CONTRIBUTING.md](CONTRIBUTING.md).

## Instruction files
- Write agent rules and instructions to AGENTS.md, in this repo or any other. CLAUDE.md starts with `@AGENTS.md` and holds only Claude-specific content.
- Write only what an agent can't get on its own. A line describing what the harness already does (e.g. "read CLAUDE.md": Claude Code loads it) changes nothing and costs context.

## Docs
- Document only what the code can't show: platform behaviour, settings made in external UIs, decisions with their why, gotchas, runbooks. Link to source files instead of describing them.
