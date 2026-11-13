# Architecture

OwnMode Mac is a standalone Swift/AppKit application, not a Node wrapper. The pure preset module validates source and direction and owns the five task instructions. The native application owns a retained NSWindow, accessible native controls, cancellable task state and direct SystemLanguageModel sessions.

The menu bar opens the same workspace and selects presets. Closing the window must not destroy it; Dock/menu reopen restores it. Operation status and model availability are separate so activation cannot overwrite an in-progress or error message. SMAppService manages opt-in login registration and approval status; no installer silently registers it.

The app has no HTTP server, web relay or Ollama-compatible endpoint. Use OwnMode Connect for multi-provider/frontend compute. This product keeps simple Apple preset workflows Node-free. Apple inference requires macOS 26 and supported Apple Intelligence configuration; there is no cloud fallback for an unavailable model.

Build produces a standard arm64 .app, shared-family .icns, Info.plist, ad-hoc signature and ZIP. Not Developer ID signed/notarized or store-approved. Source and result are transient user-controlled text; copied/saved data follows the receiving application's privacy model.
