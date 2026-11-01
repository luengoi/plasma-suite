# Agent Steering

Applies when creating or modifying agent instructions, steering documents, or skills.

## Where guidance belongs

- Root `AGENTS.md`: essential repository-wide instructions and explicit routes to task-specific guidance. Keep it small.
- `.agents/steering/<topic>.md`: focused conventions and constraints loaded when relevant to a task.
- Scoped `AGENTS.md` files: instructions specific to a directory and its descendants. Add them only when local requirements justify them.
- `.agents/skills/<name>/SKILL.md`: on-demand workflows, optionally supported by scripts, references, and templates. Mandatory conventions must not depend solely on skill selection.
- `docs/`: working guides, specs, and decision records, not agent-specific instructions.

## Defining loading conditions

- State when each steering document applies and add an explicit loading condition to the relevant `AGENTS.md`, such as "Before creating commits, read `.agents/steering/commits.md`."
- Keep instructions for discovering and loading guidance in root `AGENTS.md`, where they are available before any steering document is read.
- `.agents/steering/` is a repository convention, not an automatically discovered location. Update routing instructions when adding, moving, or removing steering documents.

## Authoring rules

- Keep one authoritative home per rule. Link rather than duplicate across steering documents, scoped instructions, and skills.
- Keep documents concise and cohesive; split by topic or applicability, not into individual rule files.
- Local guidance should refine repository-wide instructions, not contradict them. Resolve conflicts rather than adding ambiguous exceptions.
- Prefer automated checks for mechanically enforceable rules; guidance is not an enforcement mechanism.
- Create guidance only when needed. Do not add speculative conventions or empty scaffolding.
