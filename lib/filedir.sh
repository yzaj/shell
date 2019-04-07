#!/bin/bash
#
# 文件与目录相关函数
set -euo pipefail

###################################################################################################
#
#       filedir::config
#
###################################################################################################
err() {
  echo "[$(date +'%Y-%m-%dT%H:%M:%S%z')]: $@" >&2
}

#   功能: 
#   使用: 
#   参数: 
# 返回值: 
filedir::config() {
  local key="$1"
  local value="$2"
  local file="$3"
  local line
  
  if [[ -s "${file}" ]]; then
    sed -i 's/\r$//g' "${file}"
    
    while read line; do
      if echo "${line}" | grep -iP "^[ \t]*${key}[ \t]*=[ \t\"\']*${value}[ \t\"\']*$"; then
        
        line="$(echo "${line}" | sed 's/^[ \t]*//g' | sed 's/[ \t]*$//g')"
        line="$(echo "${line}" | sed 's/[ \t]*=[ \t]*/=/g')"
        line="$(echo "${line}" | sed 's/"[ \t]*/"/g' | sed 's/[ \t]*"/"/g')"
        line="$(echo "${line}" | sed "s/'[ \t]*/'/g" | sed "s/[ \t]*'/'/g")"
        
        key="$(echo "${line%=*}" | tr '[A-Z]' '[a-z]')"
        value="$(echo "${line#*=}")"
        line="${key}=${value}"
        
        export "${line}"
        
      fi
    done < "${file}"
  fi
}
