# Global OpenCode Instructions

## General Preferences

**Prefer standard tooling commands over manual edits.** When a standard CLI command exists that achieves the same result as manually editing a config file or writing boilerplate (e.g. `npx sv add mcp` rather than hand-writing the config), use the command. Ask if unsure whether a standard command exists.

## Working Style

**Explain as you go.** Describe what you're doing and why as you work — at a moderate level of detail, covering the reasoning and any non-obvious tradeoffs, but without exhaustive step-by-step narration.

**Ask clarifying questions before starting** only when a task is genuinely ambiguous or has multiple reasonable approaches with meaningfully different tradeoffs. For straightforward tasks, make sensible assumptions and proceed.

**Proactive suggestions** — if you notice related improvements, potential issues, or better approaches while working on a task, note them as a collected list after the task is complete rather than interrupting the flow mid-task.

## Code Style

**Prefer `async/await` over promise chains** for all asynchronous code.

**TypeScript types should be helpful, not ceremonial.** Let TypeScript infer types where it can do so unambiguously. Add explicit annotations when they genuinely aid readability, catch real mistakes, or document a non-obvious contract. If an annotation is redundant with what TypeScript would infer anyway, omit it. Push back on over-annotation and under-annotation equally.

**Prefer functional patterns** — pure functions, immutability, and composition where they make sense. Classes and mutation are fine when a library requires them (e.g. Lit web components) or when they're genuinely the clearest solution.

**No trailing semicolons in TypeScript** — omit them from statements (e.g. `const x = 1` not `const x = 1;`)

## Testing

**Use TDD for logic-heavy code** — state, actions, effects, gateways, and utilities. Write failing tests first, briefly describe the test cases being added, then implement until they pass. No need to wait for explicit approval between tests and implementation.

**Write tests alongside code for UI components** — component tests require more setup and are less naturally test-first. Write them at the same time as the component rather than before.

**Comprehensive TDD** — Some users prefer tests for everything, not just the "risky parts." When in doubt, ask the user their preference, but default to comprehensive coverage for: state modules, actions, effects, sync logic, utilities, and pure functions.

## Documentation

**Write documentation alongside code** — Use the `docs-maintainer` subagent when creating documentation, or at minimum update relevant docs as you implement. Documentation should not lag behind implementation.

## Communication

**Flag potential security issues** even when not asked about security. Note them clearly but without alarmism — a brief description of the risk and a suggested fix is enough.

**When uncertain about an approach**, ask for input rather than picking silently. Present the options with a brief summary of the tradeoffs and a recommendation where you have one.

## Languages

Primary languages are **TypeScript and JavaScript**. Python is acceptable when it's the right tool. For anything requiring compiled native code, prefer **Rust** over C or C++.

## Dotfiles

Global configuration files (`~/.config/`, `~/.zshrc`, etc.) are managed with **yadm** — use `yadm` commands instead of plain `git` when working with dotfiles. Load the `opencode-maintenance` skill for the full workflow when making agent, skill, or config changes.

## Global Skills

Custom skills live in `~/.config/opencode/skills/`. Skills installed via the `npx skills` ecosystem CLI live in `~/.agents/skills/`.

| Skill                       | Description                                                                           |
| --------------------------- | ------------------------------------------------------------------------------------- |
| `opencode-maintenance`      | How to update agents, skills, and OpenCode config; yadm workflow                      |
| `find-skills`               | Discover and install skills from the `npx skills` ecosystem CLI (skills.sh)           |
| `playwright-best-practices` | Comprehensive Playwright testing patterns — E2E, WebSocket, multi-user, drag-and-drop |

## Git Branching

For small changes and early-stage projects, committing directly to `main` is fine. For large changes on mature projects, use feature branches. When in doubt, ask.

## Committing

**Always ask for confirmation before creating a git commit.** Do not commit automatically, even after completing a task that feels complete. Present the proposed commit message and wait for explicit approval before running `git commit`.

## Memory MCP Server

A `memory` MCP server is available. Use it to persist facts that would genuinely change how
you approach future work in a project — not as a session log.

**Save to memory when you discover:**
- Project-specific conventions not obvious from the codebase (e.g. "this team always X")
- Architectural decisions made during a session and the reasoning behind them
- Recurring gotchas or non-obvious constraints (e.g. "Grails 2.5.6 requires flush:true in tests")
- Explicit user preferences stated during a session

**Check memory proactively when:**
- Starting work on a module or area you may have worked on before
- The user references a past decision or pattern

**Do not save:** transient state, file contents, task progress, or anything already captured
in AGENTS.md or the codebase itself.
