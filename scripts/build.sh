#!/bin/bash
set -euo pipefail
cd "$(dirname "$0")/.."
ROOT="$PWD"
OUT="${OUT_DIR:-$ROOT/build}"
APP="$OUT/OwnMode Mac.app"
ASSETS="$ROOT/docs/assets"
SDK="$(xcrun --sdk macosx --show-sdk-path)"
mkdir -p "$APP/Contents/MacOS" "$APP/Contents/Resources" "$OUT/OwnMode.iconset"
for size in 16 32 128 256 512 1024; do
  test -f "$ASSETS/icon-$size.png" || { echo "Missing shared asset: $ASSETS/icon-$size.png" >&2; exit 1; }
done
cp "$ASSETS/icon-16.png" "$OUT/OwnMode.iconset/icon_16x16.png"
cp "$ASSETS/icon-32.png" "$OUT/OwnMode.iconset/icon_16x16@2x.png"
cp "$ASSETS/icon-32.png" "$OUT/OwnMode.iconset/icon_32x32.png"
sips -z 64 64 "$ASSETS/icon-128.png" --out "$OUT/OwnMode.iconset/icon_32x32@2x.png" >/dev/null
cp "$ASSETS/icon-128.png" "$OUT/OwnMode.iconset/icon_128x128.png"
cp "$ASSETS/icon-256.png" "$OUT/OwnMode.iconset/icon_128x128@2x.png"
cp "$ASSETS/icon-256.png" "$OUT/OwnMode.iconset/icon_256x256.png"
cp "$ASSETS/icon-512.png" "$OUT/OwnMode.iconset/icon_256x256@2x.png"
cp "$ASSETS/icon-512.png" "$OUT/OwnMode.iconset/icon_512x512.png"
cp "$ASSETS/icon-1024.png" "$OUT/OwnMode.iconset/icon_512x512@2x.png"
iconutil -c icns "$OUT/OwnMode.iconset" -o "$APP/Contents/Resources/Icon.icns"
cp "$ASSETS/menu-icon.png" "$APP/Contents/Resources/MenuIcon.png"
xcrun swiftc -sdk "$SDK" -target arm64-apple-macosx26.0 -O "$ROOT/Sources/Core.swift" "$ROOT/Sources/App.swift" -o "$APP/Contents/MacOS/OwnModeMac"
cat > "$APP/Contents/Info.plist" <<'PLIST'
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0"><dict>
<key>CFBundleExecutable</key><string>OwnModeMac</string>
<key>CFBundleIdentifier</key><string>com.ownmode.mac</string>
<key>CFBundleName</key><string>OwnMode Mac</string>
<key>CFBundleDisplayName</key><string>OwnMode Mac</string>
<key>CFBundlePackageType</key><string>APPL</string>
<key>CFBundleShortVersionString</key><string>0.3.0</string>
<key>CFBundleVersion</key><string>0.3.0</string>
<key>CFBundleIconFile</key><string>Icon</string>
<key>LSMinimumSystemVersion</key><string>26.0</string>
<key>NSHighResolutionCapable</key><true/>
</dict></plist>
PLIST
codesign --force --deep --sign - "$APP"
ditto -c -k --sequesterRsrc --keepParent "$APP" "$OUT/OwnMode-Mac-0.3.0-arm64.zip"
STAGE="$(mktemp -d "${TMPDIR:-/tmp}/ownmode-mac-dmg.XXXXXX")"
trap 'rm -rf "$STAGE"' EXIT
ditto "$APP" "$STAGE/OwnMode Mac.app"
ln -s /Applications "$STAGE/Applications"
rm -f "$OUT/OwnMode-Mac-0.3.0-arm64.dmg"
hdiutil create -quiet -volname "OwnMode Mac" -srcfolder "$STAGE" -format UDZO "$OUT/OwnMode-Mac-0.3.0-arm64.dmg"
echo "Built $APP, ZIP and DMG (arm64, ad-hoc signed, not notarized)"
