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

# 功  能: 逐行读取配置文件, 获取键值对的值
# 使  用: filedir::config 键 值 文件
# 参数 1: 键值对的键, 不允许包含大写字母, 允许键值对不存在    [default: ]
# 参数 2: 键值对的值, 允许使用正则表达式    [default: ]
# 参数 3: 配置文件, 允许文件不存在    [default: ]
# 返回值: 将键值对导出为环境变量
# 备  注: 使用前必须定义默认值
filedir::config() {
  local key="$1"
  local value="$2"
  local file="$3"
  local line
  
  if [[ -s "${file}" ]]; then
    sed -i 's/\r$//g' "${file}"
    
    while read line; do
      if echo "${line}" | grep -iP "^[ \t]*${key}[ \t]*=[ \t\"\']*${value}[ \t\"\']*$"; then
        
        :
        
        
        
        
        
        
        
        
        
        
        #line="$(echo "${line}" | sed 's/^[ \t]*//g' | sed 's/[ \t]*$//g')"
        #line="$(echo "${line}" | sed 's/[ \t]*=[ \t]*/=/g')"
        #line="$(echo "${line}" | sed 's/"[ \t]*//g' | sed 's/[ \t]*"//g')"
        #line="$(echo "${line}" | sed "s/'[ \t]*//g" | sed "s/[ \t]*'//g")"
        
        #key="$(echo "${line%=*}" | tr '[A-Z]' '[a-z]')"
        #value="$(echo "${line#*=}")"
        #line="${key}=${value}"
        
        #export "${line}"
        
      fi
    done < "${file}"
  fi
}
