<p align="center"><img src="docs/assets/logo.svg" width="88" alt="Ownference linked-loop logo with Mac-window badge"></p>

# Ownference Mac
### A little studio for local intelligence.

A native Mac workspace for **rewriting, summarizing, extracting, comparing and drafting** with Apple's on-device model. No Node, Ollama server or cloud API key required.

<p><a href="https://github.com/edwinjosechittilappilly/ownference-mac/releases">Download the Mac app</a> · <a href="#start-with-a-release">Install</a> · <a href="#five-workflows-worth-keeping-close">Workflows</a> · <a href="#menu-bar-and-launch-at-login">Menu bar & startup</a> · <a href="docs/testing.md">Verification</a></p>

![Ownference Mac: a little studio for local intelligence](docs/assets/hero.svg)

**Apache-2.0 · Native Swift + AppKit · Apple on-device · Private preview**

## Start with a release

**Requires:** an Apple Silicon Mac running macOS 26+, Apple Intelligence enabled, and the on-device model downloaded and available. This is **not an app every Mac can run**. Availability also depends on Apple's supported configuration, region and language.

With GitHub CLI and access to this private repository:

```sh
gh release download v0.2.0 \
  --repo edwinjosechittilappilly/ownference-mac \
  --pattern Ownference-Mac-0.2.0-arm64.zip

mkdir -p "$HOME/Applications"
ditto -x -k Ownference-Mac-0.2.0-arm64.zip "$HOME/Applications"
open "$HOME/Applications/Ownference Mac.app"
```

Prefer a graphical download? Open **Releases**, download the arm64 app ZIP, extract it and move **Ownference Mac.app** to Applications. Keep it in a stable location before enabling launch at login.

Release builds are **ad-hoc signed, not Developer ID signed or notarized**. macOS may block first launch; use only your organization's approved process or build from source. Do not disable Gatekeeper. The ZIP includes no Node runtime or downloaded third-party model.

## Five workflows worth keeping close

| Preset | Try it with |
|---|---|
| Summarize | A long article excerpt or meeting notes |
| Rewrite | A rough paragraph that needs a clearer tone |
| Extract | Notes containing dates, decisions and action items |
| Compare | Two options you want to understand side by side |
| Draft | Context for a reply you will review yourself |

Choose a preset, paste source text, optionally add direction and generate. Watch the result stream, cancel if needed, then copy or save it. The app never sends email, edits a website or executes an action on the model's behalf.

The source and result stay visibly separate. Clear the workspace when finished. Source length is bounded, but the model's context window can be smaller; shorten the input when prompted. A valid response may still be wrong—review it before use.

## Menu bar and launch at login

The shared Ownference icon keeps the workspace reachable from the menu bar. Open the workspace, choose a preset or quit from its menu. Closing a window is different from quitting the app.

Launch at login is **opt-in** through the app's control. Registration uses Apple's `SMAppService`; the app reports enabled, disabled or approval-required status and can open the relevant System Settings panel. Installation does not silently enable startup. A stable app location and macOS approval may be required.

## Native app or local bridge?

| Choose | When you want |
|---|---|
| **Ownference Mac** | A Node-free, native preset workspace using Apple's model |
| [Ownference Bridge](https://github.com/edwinjosechittilappilly/ownference) | A local endpoint for apps, multiple providers and browser native messaging |
| [Ownference Tabs](https://github.com/edwinjosechittilappilly/ownference-tabs) | Approved page-text assistance and website relay approvals |
| [Ownference Web](https://github.com/edwinjosechittilappilly/ownference-web) | A JavaScript SDK for cooperating frontends |

The Mac app is not an Ollama-compatible HTTP server and does not replace the bridge. It currently uses Apple on-device inference only; it does not claim selectable Ollama/LM Studio providers. Keeping these products separate avoids requiring Node for a simple Mac writing task.

## Local, with honest limits

No cloud fallback, telemetry or prompt-history database. The app invokes `SystemLanguageModel` locally—not Private Cloud Compute. Copying or saving output makes it available wherever you put it; local inference is not a guarantee that other applications will keep it private.

Apple's model availability, context limits, safety guardrails and acceptable-use requirements apply. Prompt injection and hallucinations remain possible. The UI reports unavailable, refused, cancelled and too-large-input conditions instead of inventing a result.

## Build and verify

Requires a compatible Xcode command-line toolchain with the macOS 26 SDK:

```sh
bash scripts/test.sh
bash scripts/build.sh
"build/Ownference Mac.app/Contents/MacOS/OwnferenceMac" --smoke
"build/Ownference Mac.app/Contents/MacOS/OwnferenceMac" \
  --ui-smoke "$PWD/build/ui-smoke.png"
```

The UI smoke launches an actual native window, drives its controls, waits for real on-device generation and captures the rendered view. It requires a supported Mac with the model ready; CI compilation and semantic tests alone do not prove model availability.

See [testing](docs/testing.md), [architecture](docs/architecture.md), [security](SECURITY.md) and [contributing](CONTRIBUTING.md). Releases include checksums; the GitHub Actions tab is the source of truth for CI status.

Licensed under [Apache-2.0](LICENSE). Ownference is a working brand, not trademark-cleared. Private preview until the owner approves public distribution.
