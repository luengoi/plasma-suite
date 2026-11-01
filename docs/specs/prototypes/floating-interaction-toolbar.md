# Floating interaction toolbar

## Status

Draft prototype spec for a shared interaction pattern in Plasma Suite, explored first in PlasmaFood. This specifies an experiment, not an accepted production interaction contract. It follows the [shared design language](../../../.agents/steering/design-language.md); it does not select one of the current home-screen layouts or replace their implementation.

The toolbar shape and gesture intents come from the proposed experience. The details below, including gesture commitment, side assignments, and conversation presentation, are recommendations to validate.

## Intent

Give people a consistent place to ask the app to do something, return Home, and reach frequent actions. The central button is the main interaction point: it opens an agent conversation by text or voice. Direct controls remain available for tasks that do not need a conversation.

In PlasmaFood, someone might tap the center and type “create a plan for the week,” or hold it and make the same request aloud. The agent presents a plan draft that can be reviewed and adjusted before applying it.

## Toolbar composition

- Float a compact Liquid Glass toolbar above the bottom safe area. Content can scroll behind it, with enough bottom clearance to bring the final item fully above the controls.
- Use a wider capsule button in the center, flanked by smaller circular icon buttons. Keep the center physically centered, including when one side has fewer controls.
- Allow zero to two buttons on each side. Do not fill unused positions just to reach five controls.
- Keep every toolbar button icon-only. Use accessible names and show text labels in revealed panels and gesture previews.
- Give the central button the strongest emphasis through width and accent treatment. Keep its identity stable across screens; it should not silently become a different primary action.
- Use the shared material and accessibility rules. Give each button at least a 44 × 44 pt touch region, with separation between targets. Prefer one coherent glass surface over stacked glass effects.

For the first prototype, use **Home on the left, the agent in the center, and Actions on the right**. Additional app shortcuts can be considered after validating this smaller set. The agent symbol is still an open design choice; a plus symbol would imply adding an item more narrowly than the proposed behavior.

## Central-button interactions

| Input | Prototype result | Feedback and commitment |
| --- | --- | --- |
| Single tap | Open a compact text conversation with the agent. | Show pressed feedback; open on release only if no hold or drag was recognized. Focus the text composer. |
| Press and hold | Open a voice conversation with the same agent. | A short hold produces a haptic and visible microphone state. Once recognized, release must not also trigger text chat. The voice session stays open without requiring continued contact. |
| Drag upward | Return to the app's Home screen. | Show a Home preview as the button follows the drag. Commit on release beyond an intentional distance; returning toward the origin cancels. |
| Drag toward the leading side | Reveal navigation destinations. | Show a labeled navigation panel. Release beyond the reveal threshold leaves it open; tap a destination to navigate. |
| Drag toward the trailing side | Reveal contextual actions. | Show a labeled action panel. Release leaves it open; tap an action to run it. |

Here, **Home means the current app's root screen**, not the iOS Home screen or a suite launcher. Dragging upward while already Home returns the control to rest without resetting the page or duplicating navigation.

“Deep press” means a timed hold with haptic acknowledgement in this spec, not a pressure requirement. Apple's [long-press gesture](https://developer.apple.com/documentation/swiftui/longpressgesture/minimumduration) recognizes duration and permits a movement tolerance. The exact hold duration and drag distances should be tuned on device rather than fixed in this document.

For left-to-right layouts, leading is left and trailing is right. Mirror these assignments for right-to-left layouts, keeping the visible controls and their corresponding panels aligned.

## Gesture behavior

Each touch can resolve to only one outcome: tap, hold, upward drag, sideways drag, or cancellation.

1. Touch-down highlights the central button without opening anything.
2. A release within the tap tolerance opens text chat.
3. Remaining sufficiently still until the hold is recognized opens voice chat and consumes the interaction.
4. Moving beyond the initial movement tolerance before the hold is recognized cancels the hold timer and begins a directional drag.
5. Once a clear direction is chosen, lock that direction for the gesture. A diagonal movement should not switch unpredictably between Home and an action panel.
6. During a drag, preview the destination and acknowledge crossing its activation threshold once. Returning to the cancellation region or releasing short cancels; downward and ambiguous drags do nothing.
7. System interruption cancels an uncommitted gesture. Never turn a cancelled drag or completed hold into a tap.

Only drags that begin on the central button participate. Scrolling the page and interacting with side buttons must retain their ordinary behavior. Leave space above the system home indicator and verify that the custom upward drag does not interfere with iOS navigation.

For the initial prototype, **sideways dragging reveals rather than selects**. Releasing over a newly revealed action must not execute it. A later drag-to-select experiment would be a separate decision, after the reveal behavior proves understandable.

## Conversation and action presentation

Text and voice are two input modes for the same conversation. Switching modes should preserve the request and responses. Opening the agent should retain the underlying page and its scroll position; dismissing it returns there.

Start text chat in a sheet that can expand for longer replies. When the keyboard is visible, the sheet's composer takes over the bottom interaction area rather than competing with the global toolbar. Include a visible microphone control to enter voice without a hold gesture.

In voice mode, clearly distinguish connecting, listening, processing, and speaking. Provide visible mute, end-session, and switch-to-text controls. Request microphone permission when voice is first invoked; show listening only after permission and session readiness. On denial or connection failure, preserve the request and offer text input. Closing the voice session ends microphone capture.

Show the context the agent will use, such as the selected day, when it affects a request. Keep draft results editable. For the weekly-plan example, show the proposed week and a clear Apply action; do not silently treat a generated answer as an accepted plan. Allow people to leave the conversation without losing its draft.

Navigation and action panels appear above the toolbar with readable labels. Tapping outside or choosing Close dismisses them without changing the current page. Opening another panel replaces the previous one. Keep destinations stable and make contextual actions specific to the current screen.

## Discovery and accessible alternatives

The resting toolbar stays icon-only. During first use, offer a short, dismissible explanation: **Tap to type. Hold to talk. Drag up for Home. Drag sideways for more.** Repeatable help belongs in the Actions panel, not in a permanent overlay.

Every gesture has a tap-based path:

| Gesture shortcut | Alternative |
| --- | --- |
| Hold for voice | Tap the agent, then the microphone control. |
| Drag up for Home | Tap the Home side button. |
| Drag sideways for navigation or actions | Tap Actions, then choose a labeled destination or action. |

Expose the center as a button named “Ask agent,” with appropriate accessibility actions for voice, Home, navigation, and actions. Support ordinary focus and activation for VoiceOver, Switch Control, and keyboard input without requiring a drag or timed hold. Restore focus to the invoking control when dismissing a panel.

Respect Reduce Motion, Reduce Transparency, and Increase Contrast. Haptics reinforce visible feedback; they are never the only indication that an interaction was recognized.

This is a custom interaction that needs testing. Apple's [gesture guidance](https://developer.apple.com/design/human-interface-guidelines/gestures) favors familiar, consistent interactions. The prototype therefore preserves conventional tap controls alongside the gesture shortcuts.

## Prototype scope and acceptance

Build a focused interaction prototype with the three-button toolbar, a sample text conversation, voice-session states, a second screen for returning Home, and small navigation/action panels. Use sample results before connecting an agent or live microphone. Keep the current home-screen alternatives available beneath the same toolbar.

Prototype acceptance requires each gesture and its tap alternative to reach the specified state, cancellation to leave the current screen unchanged, and one touch to produce at most one outcome. Voice and agent results are simulated and identified as such; live microphone capture, agent integration, and persistent changes are outside this prototype. Exercise permission and failure states through simulation. The live-session behavior described above is a future integration requirement.

Validate on a physical iPhone as well as the simulator:

- Can someone find text, voice, Home, and actions without instruction, then recall the gestures after the short hint?
- Does a tap ever open voice, or an intended drag open chat? Check one-handed use with either hand and slower or imprecise movement.
- Can people preview, cancel, and commit each drag reliably without accidental navigation or action execution?
- Does the control remain usable near the home indicator, while scrolling, with the keyboard open, and after interruptions?
- Can each task be completed using tap controls and assistive technologies alone?
- Do the panels, focus, drafts, and voice states remain understandable with accessibility settings enabled?

Treat observed confusion as a reason to simplify or remove a gesture. An animated preview alone cannot validate haptics, gesture recognition, or physical reach.

## Open decisions

- Choose the central symbol, resting width, and pressed/listening appearance.
- Confirm navigation on the leading side and contextual actions on the trailing side, or explore another mapping.
- Decide whether tapping the agent resumes the current conversation or starts a new one. Initial recommendation: resume, with an explicit New conversation action.
- Select any additional side shortcuts per app while keeping the central interaction and Home behavior stable across the suite.
- Decide whether and how the toolbar remains available in full-screen tasks. In modal conversations, preserve a conventional Close action rather than overloading the central button again.

After review and prototype validation, record the accepted interaction contract in a decision record and link it here. Code should then own gesture thresholds and component APIs.
