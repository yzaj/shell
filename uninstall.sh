#!/bin/bash
#
# 任意仓库的卸载脚本
set -euo pipefail

# 修改 REPO 的值, 即可
readonly REPO='shell'
readonly MINTTY='Cygwin-Terminal.ico'
readonly E_USE_MINTTY=1

err() {
  echo "[$(date +'%Y-%m-%dT%H:%M:%S%z')]: $@" >&2
}

readonly repodir="/yzaj/${REPO}"
readonly src="/etc/profile.d/yzaj-${REPO}.sh"

if [[ ! -f "/${MINTTY}" ]]; then
  err "Please use cygwin to execute"
  exit "${E_USE_MINTTY}"
fi

if [[ -d "${repodir}" ]]; then
  rm -r "${repodir}"
fi

if [[ -f "${src}" ]]; then
  rm "${src}"
fi
