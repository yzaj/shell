#!/bin/bash
#
# 获取配置文件的值
set -euo pipefail

# USAGE: config.sh 键 值 文件

readonly E_MISSING_OPERAND=1
readonly E_NOT_FOUND=2

err() {
  echo "[$(date +'%Y-%m-%dT%H:%M:%S%z')]: $@" >&2
}

readonly key="$1"
readonly value="$2"
readonly filename="$3"

if [[ -z "${key}" || -z "${value}" || -z "${filename}" ]]; then
  
fi









