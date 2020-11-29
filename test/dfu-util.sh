#!/usr/bin/env sh

set -e

cd $(dirname "$0")

printf '\n::group::Environment\n'
  echo "CC: $CC"
  echo "CXX: $CXX"
echo '::endgroup::'

printf '\n::group::Install dfu-util through pacman\n'
  case "$MSYSTEM" in
    MINGW64|mingw64)
      pacman -S --noconfirm mingw-w64-x86_64-dfu-util
    ;;
    MINGW32|mingw32)
      pacman -S --noconfirm mingw-w64-i686-dfu-util
    ;;
    *)
      echo 'Unknown MSYSTEM: $MSYSTEM'
      exit 1
    ;;
  esac
echo '::endgroup::'

printf '\nSmoke tests\n'
./smoke-tests/dfu-util.sh

printf '\n::group::Version\n'
  dfu-util --version
echo '::endgroup::'
