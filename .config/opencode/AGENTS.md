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

**Teaching workflow** — Some users occasionally prefer a teaching pattern: concept explanation → test written → user implements the code to pass → AI reviews and provides feedback. This builds user understanding and reduces future dependence. Offer this explicitly when it seems appropriate.

## Documentation

**Write documentation alongside code** — Use the `docs-maintainer` subagent when creating documentation, or at minimum update relevant docs as you implement. Documentation should not lag behind implementation.

## Communication

**Flag potential security issues** even when not asked about security. Note them clearly but without alarmism — a brief description of the risk and a suggested fix is enough.

**When uncertain about an approach**, ask for input rather than picking silently. Present the options with a brief summary of the tradeoffs and a recommendation where you have one.

## Languages

Primary languages are **TypeScript and JavaScript**. Python is acceptable when it's the right tool. For anything requiring compiled native code, prefer **Rust** over C or C++.

## Dotfiles

Global configuration files (`~/.config/`, `~/.zshrc`, etc.) are managed with **yadm** — use `yadm` commands instead of plain `git` when working with dotfiles.

Files that differ between machines use yadm's **alternates** system with a `##class.CLASSNAME` suffix. This machine has `local.class = work`. The personal laptop uses `local.class = personal`. After adding or modifying alternate files, run `yadm alt` to update symlinks.

- When editing a config file that is a symlink, edit the `##class.work` variant directly rather than the symlink target.
- When adding a new config file that needs to differ between machines, create both `##class.work` and `##class.personal` variants, add both to yadm, and run `yadm alt`.
- Files that are identical across machines are tracked as plain files with no suffix.

Current files using alternates: `~/.config/opencode/opencode.json` and the 10 agent files with per-machine model config (`code-reviewer.md`, `debugger.md`, `deep-thinker.md`, `docs-maintainer.md`, `git-assistant.md`, `refactorer.md`, `state-architect.md`, `researcher.md`, `test-writer.md`).

---

## Custom Agent Best Practices & Alternates Checklist

- **Identity and Routing**: Always announce identity with `delegating to @agentname...` at the beginning of each response (including when invoked as a subagent).
- **Per-machine alternates**:
  - Use yadm alternates for all custom agents where model, permissions, or config should vary by machine (`##class.work`, `##class.personal`).
  - After adding new alternates, always update this section and run `yadm alt`.
- **Frontmatter checklist**:
  - Each agent prompt alternates file must start with:
    - `model:` (specifies the exact OpenCode model)
    - `appliesTo: '**'`
  - The main body must clearly specify operating mode, permissions, limitations, and how to identify the agent.
- **Anti-hallucination and trust protocols**:
  - Custom research or fact-checking agents must provide confidence tagging on all answers, explicitly mark unverified sections, and cite all sources when using webfetch.
- **Alternates tracking**:
  - Be sure this list always reflects the current set of agents with alternates (add new ones here):

    - `~/.config/opencode/opencode.json`
    - `~/.config/opencode/opencode.json##class.work`
    - `~/.config/opencode/opencode.json##class.personal`
    - `~/.config/opencode/agent/code-reviewer.md##class.work`
    - `~/.config/opencode/agent/code-reviewer.md##class.personal`
    - `~/.config/opencode/agent/debugger.md##class.work`
    - `~/.config/opencode/agent/debugger.md##class.personal`
    - `~/.config/opencode/agent/deep-thinker.md##class.work`
    - `~/.config/opencode/agent/deep-thinker.md##class.personal`
    - `~/.config/opencode/agent/docs-maintainer.md##class.work`
    - `~/.config/opencode/agent/docs-maintainer.md##class.personal`
    - `~/.config/opencode/agent/git-assistant.md##class.work`
    - `~/.config/opencode/agent/git-assistant.md##class.personal`
    - `~/.config/opencode/agent/refactorer.md##class.work`
    - `~/.config/opencode/agent/refactorer.md##class.personal`
    - `~/.config/opencode/agent/state-architect.md##class.work`
    - `~/.config/opencode/agent/state-architect.md##class.personal`
    - `~/.config/opencode/agent/researcher.md##class.work`
    - `~/.config/opencode/agent/researcher.md##class.personal`
    - `~/.config/opencode/agent/test-writer.md##class.work`
    - `~/.config/opencode/agent/test-writer.md##class.personal`

## Git Branching

For small changes and early-stage projects, committing directly to `main` is fine. For large changes on mature projects, use feature branches. When in doubt, ask.

## Committing

**Always ask for confirmation before creating a git commit.** Do not commit automatically, even after completing a task that feels complete. Present the proposed commit message and wait for explicit approval before running `git commit`.
