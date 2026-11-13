#!/bin/bash
set -euo pipefail
cd "$(dirname "$0")/.."
ROOT="$PWD"
OUT="${OUT_DIR:-$ROOT/build}"
APP="$OUT/Ownference Mac.app"
ASSETS="$ROOT/docs/assets"
SDK="$(xcrun --sdk macosx --show-sdk-path)"
mkdir -p "$APP/Contents/MacOS" "$APP/Contents/Resources" "$OUT/Ownference.iconset"
for size in 16 32 128 256 512 1024; do
  test -f "$ASSETS/icon-$size.png" || { echo "Missing shared asset: $ASSETS/icon-$size.png" >&2; exit 1; }
done
cp "$ASSETS/icon-16.png" "$OUT/Ownference.iconset/icon_16x16.png"
cp "$ASSETS/icon-32.png" "$OUT/Ownference.iconset/icon_16x16@2x.png"
cp "$ASSETS/icon-32.png" "$OUT/Ownference.iconset/icon_32x32.png"
sips -z 64 64 "$ASSETS/icon-128.png" --out "$OUT/Ownference.iconset/icon_32x32@2x.png" >/dev/null
cp "$ASSETS/icon-128.png" "$OUT/Ownference.iconset/icon_128x128.png"
cp "$ASSETS/icon-256.png" "$OUT/Ownference.iconset/icon_128x128@2x.png"
cp "$ASSETS/icon-256.png" "$OUT/Ownference.iconset/icon_256x256.png"
cp "$ASSETS/icon-512.png" "$OUT/Ownference.iconset/icon_256x256@2x.png"
cp "$ASSETS/icon-512.png" "$OUT/Ownference.iconset/icon_512x512.png"
cp "$ASSETS/icon-1024.png" "$OUT/Ownference.iconset/icon_512x512@2x.png"
iconutil -c icns "$OUT/Ownference.iconset" -o "$APP/Contents/Resources/Icon.icns"
cp "$ASSETS/icon-32.png" "$APP/Contents/Resources/MenuIcon.png"
xcrun swiftc -sdk "$SDK" -target arm64-apple-macosx26.0 -O "$ROOT/Sources/Core.swift" "$ROOT/Sources/App.swift" -o "$APP/Contents/MacOS/OwnferenceMac"
cat > "$APP/Contents/Info.plist" <<'PLIST'
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0"><dict>
<key>CFBundleExecutable</key><string>OwnferenceMac</string>
<key>CFBundleIdentifier</key><string>com.ownference.mac</string>
<key>CFBundleName</key><string>Ownference Mac</string>
<key>CFBundleDisplayName</key><string>Ownference Mac</string>
<key>CFBundlePackageType</key><string>APPL</string>
<key>CFBundleShortVersionString</key><string>0.2.0</string>
<key>CFBundleVersion</key><string>0.2.0</string>
<key>CFBundleIconFile</key><string>Icon</string>
<key>LSMinimumSystemVersion</key><string>26.0</string>
<key>NSHighResolutionCapable</key><true/>
</dict></plist>
PLIST
codesign --force --deep --sign - "$APP"
ditto -c -k --sequesterRsrc --keepParent "$APP" "$OUT/Ownference-Mac-0.2.0-arm64.zip"
echo "Built $APP and $OUT/Ownference-Mac-0.2.0-arm64.zip (arm64, ad-hoc signed, not notarized)"
