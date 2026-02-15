#!/bin/bash
set -e

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
ANDROID_DIR="$SCRIPT_DIR/.."

echo "🔍 Validating environment for Flutter + Fastlane deployment..."
ERRORS=0

check() {
  if command -v "$1" &>/dev/null; then
    echo "  ✅ $1 found: $(command -v $1)"
  else
    echo "  ❌ $1 NOT found — $2"
    ERRORS=$((ERRORS + 1))
  fi
}

check ruby     "Install via: brew install ruby or rbenv"
check bundle   "Install via: gem install bundler"
check fastlane "Install via: gem install fastlane"
check java     "Install JDK: brew install --cask temurin"
check flutter  "Install Flutter: https://docs.flutter.dev/get-started/install"

echo ""
echo "🔍 Checking Android SDK..."
if [ -z "$ANDROID_HOME" ] && [ -z "$ANDROID_SDK_ROOT" ]; then
  # check local.properties as fallback
  if [ -f "$ANDROID_DIR/local.properties" ]; then
     SDK_DIR=$(grep sdk.dir "$ANDROID_DIR/local.properties" | cut -d= -f2)
     if [ -d "$SDK_DIR" ]; then
       echo "  ✅ Android SDK found in local.properties: $SDK_DIR"
     else
       echo "  ❌ ANDROID_HOME / ANDROID_SDK_ROOT not set and local.properties sdk.dir missing/invalid"
       ERRORS=$((ERRORS + 1))
     fi
  else
     echo "  ❌ ANDROID_HOME / ANDROID_SDK_ROOT not set"
     ERRORS=$((ERRORS + 1))
  fi
else
  echo "  ✅ Android SDK: ${ANDROID_HOME:-$ANDROID_SDK_ROOT}"
fi

echo ""
echo "🔍 Checking project files..."
[ -f "$ANDROID_DIR/key.properties" ]        && echo "  ✅ key.properties found"  || echo "  ⚠️  key.properties missing — create before building"
[ -f "$ANDROID_DIR/fastlane/Appfile" ]      && echo "  ✅ Appfile found"         || echo "  ⚠️  Appfile missing"
[ -f "$ANDROID_DIR/fastlane/Fastfile" ]     && echo "  ✅ Fastfile found"        || echo "  ⚠️  Fastfile missing"
[ -f "$ANDROID_DIR/fastlane/google-play-key.json" ] && echo "  ✅ Google Play key found" || echo "  ⚠️  google-play-key.json missing"

echo ""
if [ "$ERRORS" -eq 0 ]; then
  echo "🎉 Environment looks good! Ready to run Fastlane."
else
  echo "🚨 $ERRORS issue(s) found. Fix them before proceeding."
  exit 1
fi
