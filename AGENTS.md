# Repository Guidelines

## Agent Guidance

- Before modifying files, read applicable `AGENTS.md` files from the repository root through each target directory; do not assume nested instructions are loaded automatically.
- Read steering documents when their loading conditions apply, before performing the relevant work. Load only task-relevant guidance and follow additional references only as needed for that task.
- Before creating or modifying agent instructions, steering documents, or skills, read `.agents/steering/agent-steering.md`.
- Before designing, implementing, or reviewing mobile UI, shared UI components, visual assets, or design explorations, read `.agents/steering/design-language.md`.

## Documentation

- Treat code and tooling as the source of truth. Do not duplicate implementation details, API definitions, dependency graphs, or configuration in documentation.
- Use working guides for actionable development and operational instructions that cannot reasonably be discovered from code or tooling.
- Use specs to define scope, expected behavior, and acceptance criteria, and decision records to capture important choices and their reasoning. Mark draft specs and unresolved choices explicitly.
- Prefer executable tooling over manual instructions; simplify or remove guides when workflows become automated.
- Keep one authoritative home per topic. Link rather than duplicate, and update affected guides alongside changes.

### Structure

- `README.md`: brief project overview and links to documentation.
- `docs/README.md`: documentation index, when needed.
- `docs/guides/<topic>.md`: project-wide development and operational guides.
- `docs/specs/<topic>.md`: specifications with scope, expected behavior, acceptance criteria, status, and open questions.
- `docs/specs/prototypes/<topic>.md`: prototype specifications; distinguish experimental behavior and simulated capabilities from production requirements.
- `docs/decisions/NNNN-<topic>.md`: sequentially numbered decision records with status, context, decision, and consequences. Preserve historical reasoning; supersede rather than rewrite past decisions.
- Component-local `README.md` files: instructions specific to that app, service, or module; keep longer local guides in a neighboring `docs/` directory.

Use Markdown, descriptive kebab-case filenames, and relative links. Create documents and directories only when needed.

## Commits

- Use Conventional Commits: `<type>[optional scope]: <description>`.
- Use a scope only when it adds useful context.
- Write concise, imperative descriptions.
- Keep commits small, focused, and self-contained. Do not include unrelated changes.
- Mark breaking changes with `!` and explain them in the commit body.
- Prefer a subject line alone. Add a body only when it adds value; keep it concise, direct, and cleanly formatted.
