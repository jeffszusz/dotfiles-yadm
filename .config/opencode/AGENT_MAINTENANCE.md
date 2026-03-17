# Custom Agent Maintenance Guide

This document contains the meta-configuration instructions for OpenCode custom agents. Reference this when adding, modifying, or testing custom agents.

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
