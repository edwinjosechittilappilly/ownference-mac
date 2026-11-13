# Observed native acceptance — 0.2.0

On an arm64 Mac with Swift6.2.3/macOS26.2 SDK and an available Apple on-device model:

- `bash scripts/test.sh` passed semantic preset/input-bound tests.
- `bash scripts/build.sh` produced the actual .app, shared-family .icns, ad-hoc signature and arm64 ZIP.
- The built executable's `--smoke` returned a real Apple response retaining the otter/river/fish source facts.
- `--ui-smoke build/ui-smoke.png` launched the actual NSWindow, drove real native controls, validated empty input, performed all five presets with real Apple inference, closed/reopened the retained window, cancelled during streaming and recovered for subsequent generation.
- The actual content-view PNG was inspected: shared logo, preset selector, distinct source/result, model readiness, operation status, Generate/Cancel/Copy/Save/Clear and login controls were readable. This is not a redrawn mockup.
- The UI reported that login registration was unavailable in the build location and advised moving the app to Applications. Acceptance did not enable startup or claim macOS approval was granted.

Review fixes included retained NSWindow ownership, Dock/menu reopen, separate operation and availability status, and readable opaque capture after the initial AppKit capture rendered labels incorrectly. A focused re-review confirmed the native app lifecycle fixes.

Live Apple availability on this Mac is not proof for all Macs. The app requires supported Apple Intelligence configuration and macOS26; the ZIP is arm64, ad-hoc signed, not Developer ID signed/notarized or store-approved. There is no Node dependency, Ollama/LM Studio picker or HTTP server in this app. GitHub CI and release download/install evidence are separate from these source-checkout observations.
