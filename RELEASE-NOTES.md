# OwnMode Mac 0.3.0

Switch to your own AI.

A native, Node-free writing app using Apple's on-device model.

## What's new

- Drag-to-Applications DMG, with ZIP retained as an alternative.
- OwnMode identity and a real workspace screenshot.
- Direct download-first README, compatibility guidance and visible signing limits.

Summarize, rewrite, extract, compare and draft; stream, cancel, copy or save. Menu-bar access and launch-at-login remain opt-in/user-controlled.

[Installation and workflows](https://github.com/edwinjosechittilappilly/ownmode-mac/tree/v0.3.0#readme)


## Choose an asset

- `OwnMode-Mac-0.3.0-arm64.dmg`: open the image and drag OwnMode Mac to Applications.
- `OwnMode-Mac-0.3.0-arm64.zip`: the same app as a ZIP archive.
- `SHA256SUMS`: verify downloaded assets with `shasum -a 256 -c SHA256SUMS` after downloading both assets into the same directory.

The DMG release URL is https://github.com/edwinjosechittilappilly/ownmode-mac/releases/download/v0.3.0/OwnMode-Mac-0.3.0-arm64.dmg.

Requires eligible Apple silicon, macOS 26 or later, and Apple Intelligence enabled and ready. The app is ad-hoc signed, not Developer ID signed or notarized; macOS Gatekeeper may prevent it from opening. The model runs on-device; there is no cloud fallback. See the repository for setup and model availability details.

Upgrading from Ownference Mac: disable its launch-at-login setting or remove its login item in System Settings before removing the old app. The new bundle identifier does not carry that registration over. Install OwnMode Mac in Applications, then opt in to launch at login again and approve it if prompted.
