#!/bin/bash
#
# 获取配置文件的值
set -euo pipefail

# USAGE: config.sh 键 值 文件

# 该命令使用前必须定义默认值
# 允许键值对的值使用正则
# 允许文件不存在
# 允许键值对未定义

readonly key="$1"
readonly value="$2"
readonly filename="$3"

if [[ -s "${filename}" ]]; then
  sed -i 's/\r$//g' "${filename}"
  
  while read line; do
    if echo "${line}" | grep -iP "^[ \t]*${key}[ \t]*=[ \t\"\']*${value}[ \t\"\']*$"; then
      
      line="$(echo "${line}" | sed 's/^[ \t]*//g' | sed 's/[ \t]*$//g')"
      line="$(echo "${line}" | sed 's/[ \t]*=[ \t]*/=/g')"
      line="$(echo "${line}" | sed 's/"[ \t]*/"/g' | sed 's/[ \t]*"/"/g')"
      line="$(echo "${line}" | sed "s/'[ \t]*/'/g" | sed "s/[ \t]*'/'/g")"
      
      line_key="$(echo "${line%=*}" | tr '[A-Z]' '[a-z]')"
      line_value="$(echo "${line#*=}")"
      line="${line_key}=${line_value}"
      
      export "${line}"
      
    fi
  done < "${filename}"
fi
