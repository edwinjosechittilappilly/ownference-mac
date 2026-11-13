# Ownference Mac development

## Map
`Sources/Core.swift` owns preset semantics and input bounds. `Sources/App.swift` owns the actual AppKit window, model session, menu bar and opt-in login lifecycle. `Tests/CoreTests.swift` exercises the pure core. `scripts/` builds/tests the app and arm64 release ZIP.

## Commands
Use the macOS26 SDK and Swift6.2 toolchain. `bash scripts/test.sh` checks the core. `bash scripts/build.sh` compiles and ad-hoc signs the app. The built executable supports `--smoke` and `--ui-smoke OUTPUT.png`; these require a real available Apple model and the latter creates a genuine native window.

## Boundaries and workflow
Never add cloud fallback, pretend model output, automatic login enabling, prompt logging or Node dependencies. Preserve cancellation, window reopen, status/error visibility and explicit source/result separation. Use focused conventional commits, meaningful regression coverage, independent review and observed verification. Parent README and docs state hardware/signing limits honestly; do not weaken tests or claim notarization.
