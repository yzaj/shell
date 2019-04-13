#!/bin/bash
#
# 高亮颜色相关函数
set -euo pipefail

###################################################################################################
#
#       color::echo
#       color::read
#
###################################################################################################
err() {
  echo "[$(date +'%Y-%m-%dT%H:%M:%S%z')]: $@" >&2
}

# 颜色: 黑:30  红:31  绿:32  黄:33  蓝:34  紫:35  天蓝:36  白:37
# 成功: 'Success' 32
# 错误: 'Error'   31
# 警告: 'Warning' 33

# 功  能: 
# 使  用: 
# 参数 1:     [default: ]
# 参数 2:     [default: ]
# 参数 3:     [default: ]
# 返回值: 
# 备  注: 
color::echo() {
  local message="$1"
  local color="$2"
  
  echo -e "\e[1m\e[40;${color}m${message}\e[0m"
}

# 功  能: 
# 使  用: 
# 参数 1:     [default: ]
# 参数 2:     [default: ]
# 参数 3:     [default: ]
# 返回值: 
# 备  注: 
color::read() {
  local message="$1"
  local color="$2"
  local var="$3"
  
  echo -ne "\e[1m\e[40;${color}m${message}\e[0m"
  read "${var}"
}
