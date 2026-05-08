#!/usr/bin/env bash
# Runs on Vercel Linux builders (not on your Windows machine).
set -euo pipefail
cd "$(dirname "$0")/.."

FLUTTER_DIR="${FLUTTER_DIR:-$PWD/.flutter}"

if [ ! -x "$FLUTTER_DIR/bin/flutter" ]; then
  rm -rf "$FLUTTER_DIR"
  git clone https://github.com/flutter/flutter.git -b stable --depth 1 "$FLUTTER_DIR"
fi

export PATH="$FLUTTER_DIR/bin:$PATH"

flutter config --no-analytics
flutter precache --web
flutter pub get
flutter build web --release
