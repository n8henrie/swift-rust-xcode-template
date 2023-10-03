#!/bin/bash
# XCode will call this script automatically in the `Run Script` build phase.

set -x

log() {
  printf '%s\n' "$*" > /dev/stderr
}

err() {
  log "$*"
  exit 1
}

# If cargo isn't found, add a few default paths
if ! command -v cargo; then
  # Default cargo path
  PATH+=:$HOME/.cargo/bin
  # Default for nix-darwin
  PATH+=:/run/current-system/sw/bin
  export PATH
fi

cmd=(cargo build)

if [[ "${CONFIGURATION}" = "Release" ]]; then
  cmd+=("--release")
fi

case "${EFFECTIVE_PLATFORM_NAME}" in
  "-iphonesimulator")
    cmd+=("--target=aarch64-apple-ios-sim")
    ;;
  "-iphoneos")
    cmd+=("--target=aarch64-apple-ios")
    ;;
  *)
    err "Unknown target: ${EFFECTIVE_PLATFORM_NAME}"
    ;;
esac

# When run from xcode:
# ld: library not found for -lSystem
# https://users.rust-lang.org/t/ld-library-not-found-for-lsystem-on-a-mac-monterrey/69741/3
export LIBRARY_PATH="$LIBRARY_PATH:/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/lib"

exec "${cmd[@]}"
