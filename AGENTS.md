# Instructions for AI coding agents (GitHub Copilot, Codex and others)

The full project context, rules and known issues for AI agents are in
`CLAUDE.md` at the repository root. Read it before making changes and follow it.

Most important rules:

- Work on a branch per issue; never commit directly to `main`.
- Do not change numerical or physical behaviour without comparing against
  reference outputs; report deviations.
- No new global variables. No `try` without a `catch` that reports the error.
- Use `strcmp`/`isequal` for strings and `fullfile` for paths; handle cancelled
  `uigetfile`/`uiputfile` dialogs (they return `0`).
- Do not reformat whole files; keep existing comments and author notes.
- Never commit generated results (`.mat`, `.wav`, `.avi`), autosaves or
  machine-specific files.
- Run the Code Analyzer on changed files and test the affected feature in MATLAB;
  say clearly what was tested and what was not.
- Keep code, comments and commit messages in English.
