# Testing and release acceptance

Run `bash scripts/test.sh` for isolated preset/input tests and `bash scripts/build.sh` for actual Swift compilation, .app construction and ad-hoc signing. Verify the bundle with `codesign --verify --deep --strict 'build/OwnMode Mac.app'`.

The built executable's `--smoke` path invokes a real available Apple model. `--ui-smoke OUTPUT.png` launches the actual NSWindow, drives preset/Generate controls, checks real visible model output, closes/reopens the window through its native controls, exercises cancellation and captures the rendered content view. It does not fake a model or draw a replacement UI. It requires an interactive supported Mac/model, so CI build/core tests are not described as live inference.

Launch-at-login is intentionally not enabled automatically by acceptance. Its status/approval UI is inspected; macOS can require a stable Applications location and user approval. No OS Accessibility permission is assumed for same-process UI checks.

GitHub release workflow builds the actual arm64 ZIP, verifies the signature and attaches SHA256SUMS. Download and open that artifact for release smoke; a source build alone is not release installation proof. Signing is ad-hoc, not notarization. See README for compatible Macs.
