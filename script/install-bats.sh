#!/bin/sh
set -o errexit
set -o xtrace

BATS_VERSION="${1:-0.4.0}"

git clone \
  --branch "v${BATS_VERSION}" \
  --depth 1 \
  https://github.com/sstephenson/bats

(cd bats
  ./install.sh "${HOME}/.local"
)

rm -rf bats
