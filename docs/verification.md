# Observed native acceptance

## OwnMode Mac 0.3.0 identity cutover

- Core preset/input tests passed. The renamed arm64 app, ZIP and DMG built; ad-hoc codesigning verification and DMG checksum verification passed.
- The renamed executable's UI smoke passed against the available Apple on-device model: native controls, all five presets, cancellation/recovery and retained-window reopen.
- The actual content-view screenshot shows OwnMode Mac, its shared split-O icon, model readiness, separate source/result areas and real generated text.
- The menu icon uses a transparent template mask for system appearance. Login remains opt-in; acceptance did not enable it. The app reported that registration was unavailable from the build location and instructed moving it to Applications.
- macOS26 and eligible/ready Apple Intelligence remain requirements. No Developer ID signature, notarization, App Store approval or availability on every Mac is claimed.

GitHub CI and release download/install checks are separate from these source-build observations.

## Historical acceptance — Ownference Mac 0.2.0

Historical evidence for Ownference Mac 0.2.0, before the OwnMode rebrand; it does not verify the renamed app or its release artifacts.

On an arm64 Mac with Swift6.2.3/macOS26.2 SDK and an available Apple on-device model:

- `bash scripts/test.sh` passed semantic preset/input-bound tests.
- `bash scripts/build.sh` produced the actual .app, shared-family .icns, ad-hoc signature and arm64 ZIP.
- The built executable's `--smoke` returned a real Apple response retaining the otter/river/fish source facts.
- `--ui-smoke build/ui-smoke.png` launched the actual NSWindow, drove real native controls, validated empty input, performed all five presets with real Apple inference, closed/reopened the retained window, cancelled during streaming and recovered for subsequent generation.
- The actual content-view PNG was inspected: shared logo, preset selector, distinct source/result, model readiness, operation status, Generate/Cancel/Copy/Save/Clear and login controls were readable. This is not a redrawn mockup.
- The UI reported that login registration was unavailable in the build location and advised moving the app to Applications. Acceptance did not enable startup or claim macOS approval was granted.

Review fixes included retained NSWindow ownership, Dock/menu reopen, separate operation and availability status, and readable opaque capture after the initial AppKit capture rendered labels incorrectly. A focused re-review confirmed the native app lifecycle fixes.

Live Apple availability on this Mac is not proof for all Macs. The app requires supported Apple Intelligence configuration and macOS26; the ZIP is arm64, ad-hoc signed, not Developer ID signed/notarized or store-approved. There is no Node dependency, Ollama/LM Studio picker or HTTP server in this app. GitHub CI and release download/install evidence are separate from these source-checkout observations.
