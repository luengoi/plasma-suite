# Design language

Applies before designing, implementing, or reviewing mobile UI, shared UI components, visual assets, typography, color, layout, motion, or accessibility in Plasma Suite. Also applies to mockups and design explorations, including work outside the app source directories.

## Direction and authority

- Follow a **calm and precise, native iOS** direction with clear hierarchy, **Liquid Glass**, and **vibrant color used deliberately**. Calm does not mean muted accents everywhere.
- Keep the language generic across the suite. App workflows, content, and identity can differ; do not impose a common dashboard or identical navigation destinations.
- This document is the authoritative home for shared design guidance. Code is authoritative for implemented token values and component APIs. Reuse the [PlasmaUI foundation](../../ios/foundation/PlasmaUI/) and inspect existing components before adding equivalents.
- Treat draft specs and exploratory code as provisional unless explicitly selected. Do not promote a preview's palette, geometry, sample content, or behavior into suite-wide defaults simply because it exists.

## Visual hierarchy and references

- Establish hierarchy through placement, semantic typography, spacing, and grouping before adding decoration. Keep the primary action clear and alternatives discoverable.
- Base design decisions on Plasma's shared rules and the task being served. External references can inform a specific exploration; they do not define the suite's design direction.
- When new reference research is needed, inspect actual screenshots before describing a pattern. Distinguish observed details from your design judgment; do not claim reference evidence when access is unavailable.

## Color and materials

- Use semantic roles for canvas, content surface, primary and secondary text, separators, accent, and status. Prefer adaptive system colors and existing shared tokens.
- Use vibrant accents for primary actions, selection, and limited identity cues. Keep supporting surfaces quiet. No specific app palette is established here; the violet used in home explorations is experimental.
- Keep status meanings separate from identity and domain data. Reinforce success, warning, error, destructive, and selected states with text, symbols, or shape. Do not assign food, training, calendar, or other domain colors in this shared language.
- Use native Liquid Glass for the navigation and control layer above content. Start with system components and their material behavior, following [Apple's material guidance](https://developer.apple.com/design/human-interface-guidelines/materials).
- Keep lists, form groups, and content surfaces opaque or use appropriate standard materials. Do not turn every card or field into glass, stack glass surfaces, or simulate native glass with decorative blur and shadows when native components are available.
- Preserve native interactive states, including material changes within controls. Check contrast against the content visible beneath glass, in light and dark appearances and with accessibility settings.

## Typography, icons, and layout

- Use the system font and semantic text styles. Let Dynamic Type, language, and content determine growth and wrapping; do not shrink essential text to fit a mockup. Use weight sparingly and align related numbers when comparison matters.
- Use SF Symbols for standard interface actions, keeping meaning and visual weight consistent. App icons and a suite mark remain separate design decisions.
- Reuse the [spacing foundation](../../ios/foundation/PlasmaUI/Sources/Spacing.swift). Keep related elements closer than separate groups. Preserve native control, list, sheet, and navigation geometry; do not impose a universal corner radius.
- Prefer sections and separators for repeated rows. Add a card only for a meaningful group; avoid nested cards and decorative shadows.
- Respect safe areas, keyboard avoidance, and system margins. Floating controls must leave enough scroll clearance for the last content item to become fully visible and actionable.
- Allow grids and spatial content to use task-appropriate density. Shared styling must not force every screen into a list of cards.

## Controls and behavior

- Start reusable building blocks with buttons, icon buttons, fields, toggles, and dividers. Prefer native behavior. Promote larger compositions into shared components only when demonstrated needs justify them.
- Keep floating quick-action toolbar buttons **icon-only**, with meaningful accessibility labels. This does not prohibit visible labels in forms, ordinary action buttons, menus, revealed panels, or help.
- Make pressed, selected, disabled, loading, empty, and error states understandable. Preserve input during loading and failure; prevent duplicate submissions and provide a recovery path.
- Use specific action verbs and explain unavailable actions when the reason is unclear. For destructive changes, communicate the consequence and provide undo or confirmation when appropriate.
- Preserve familiar back and dismissal behavior. Custom gestures need discoverable tap alternatives, clear feedback, and cancellation; never make an essential action gesture-only.
- The wider central agent button, smaller side buttons, and tap/hold/drag interaction model are a **proposed direction**. Validate that experiment before adopting it; do not silently ship its gesture mappings or apply them throughout the suite as settled rules.

## Motion, accessibility, and language

- Prefer native transitions. Custom motion must explain a state change or preserve context. Honor Reduce Motion; haptics supplement visible feedback and never stand alone.
- Support VoiceOver, Dynamic Type, light and dark appearance, Increase Contrast, and Reduce Transparency. Provide meaningful names, values, states, reading order, and focus restoration.
- Provide at least 44 × 44 pt touch regions with adequate separation. Keep essential actions reachable through ordinary activation as well as any shortcuts.
- Support longer translations and right-to-left layouts. Use leading/trailing alignment and locale-aware dates, numbers, and units.
- Write plain, direct, sentence-case copy. Keep wording factual and supportive; avoid judgments about a person's choices, activity, or progress. Use the same term for the same concept.

## Working and reviewing

- Before changing UI, identify the applicable existing components, shared rules, and any explicitly requested experiment. Keep experimental styling local until selected; do not create a new shared token for each mockup value.
- Use consistent, clearly identified sample data when comparing directions. Keep prototype-only capabilities distinguishable from working features.
- Build changed code and inspect rendered output. For visual work, provide screenshots or previews and check clipping, wrapping, hierarchy, touch targets, and floating-control clearance.
- Validate relevant states and representative accessibility text sizes, appearances, and localization cases. Report what was actually checked and any gaps. Validate gesture feel and haptics on a physical device before treating them as proven.
- Keep this guidance concise. Keep open design decisions and feature specifications in `docs/specs/`, and prototype specifications in `docs/specs/prototypes/`, rather than duplicating them here. Update guidance when a design decision changes; keep token values and implementation details in code.
