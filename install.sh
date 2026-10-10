#!/usr/bin/env sh
# Installs paperoo to ~/.local/bin (or $PREFIX/bin)
set -e
PREFIX="${PREFIX:-$HOME/.local}"
mkdir -p "$PREFIX/bin"
install -m 755 "$(dirname "$0")/paperoo" "$PREFIX/bin/paperoo"
echo "installed paperoo to $PREFIX/bin/paperoo"
case ":$PATH:" in
  *":$PREFIX/bin:"*) ;;
  *) echo "note: $PREFIX/bin isn't in your PATH, add it to your shell config" ;;
esac
command -v python3 >/dev/null || echo "note: paperoo needs python3"
