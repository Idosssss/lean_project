#!/bin/sh
# Reuse the CSLib + Mathlib already downloaded in the course repo (Lean_TCS),
# instead of downloading a second ~6 GB copy for this project.
#
# Usage:  scripts/share-packages.sh /path/to/Lean_TCS
#
# It only works while both projects pin the same Lean and CSLib versions,
# so it checks that first. It changes nothing in git: `.lake` is ignored.
set -e

COURSE="${1:?usage: scripts/share-packages.sh /path/to/Lean_TCS}"
cd "$(dirname "$0")/.."

if [ ! -d "$COURSE/.lake/packages/cslib" ]; then
  echo "No CSLib in $COURSE/.lake/packages. Run 'lake update cslib' in the course repo first." >&2
  exit 1
fi

if ! cmp -s lean-toolchain "$COURSE/lean-toolchain"; then
  echo "Lean versions differ: $(cat lean-toolchain) here vs $(cat "$COURSE/lean-toolchain") in the course repo." >&2
  exit 1
fi

# Every pinned dependency commit must match, or Lake would re-download into the shared folder.
if [ "$(grep '"rev"' lake-manifest.json | sort)" != "$(grep '"rev"' "$COURSE/lake-manifest.json" | sort)" ]; then
  echo "Pinned dependency versions differ between lake-manifest.json files. Not linking." >&2
  exit 1
fi

if [ -e .lake/packages ] && [ ! -L .lake/packages ]; then
  echo ".lake/packages already exists as a real folder. Delete it first if you want to share." >&2
  exit 1
fi

mkdir -p .lake
ln -sfn "$COURSE/.lake/packages" .lake/packages
echo "Linked .lake/packages -> $COURSE/.lake/packages"
