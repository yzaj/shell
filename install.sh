#!/bin/bash
#
# 任意仓库的安装脚本
set -euo pipefail

# 修改 REPO 的值, 即可
readonly REPO='phone'
readonly CMD='git'
readonly MINTTY='Cygwin-Terminal.ico'
readonly E_USE_MINTTY=1

err() {
  echo "[$(date +'%Y-%m-%dT%H:%M:%S%z')]: $@" >&2
}

readonly url="https://github.com/yzaj/${REPO}.git"
readonly repodir="/yzaj/${REPO}"
readonly tempdir="/yzaj/temp/${REPO}"
readonly src="/etc/profile.d/yzaj-${REPO}.sh"

if [[ ! -f "/${MINTTY}" ]]; then
  err "Please use cygwin to execute"
  exit "${E_USE_MINTTY}"
fi

if ! type "${CMD}"; then
  apt-cyg install "${CMD}"
fi

git clone --depth 1 "${url}" "${repodir}"

if [[ -d "${repodir}/bin" ]]; then
  chmod -R 755 "${repodir}"/bin
  echo "export PATH=\${PATH}:${repodir}/bin" > "${src}"
fi

mkdir -p "${tempdir}"
