#!/bin/sh
set -o errexit
set -o xtrace

BATS_VERSION="${BATS_VERSION:-v0.4.0}"

git clone \
  --branch "${BATS_VERSION}" \
  --depth 1 \
  https://github.com/bats-core/bats-core bats

(cd bats
  ./install.sh "${HOME}/.local"
)

rm -rf bats
