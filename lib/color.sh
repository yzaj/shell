#!/bin/bash
#
# 高亮颜色相关函数
set -euo pipefail

###################################################################################################
#
#       color::echo
#       color::read
#       color::countdown
#
###################################################################################################
err() {
  echo "[$(date +'%Y-%m-%dT%H:%M:%S%z')]: $@" >&2
}

# 颜色: 黑:30  红:31  绿:32  黄:33  蓝:34  紫:35  天蓝:36  白:37
# 成功: 'Success' 32
# 错误: 'Error'   31
# 警告: 'Warning' 33

# 功  能: 同 echo
# 使  用: color::echo 输出内容 颜色值
# 参数 1: 输出内容    [default: ]
# 参数 2: 颜色值    [default: ]
# 返回值: 输出内容
# 备  注: 
color::echo() {
  local message="$1"
  local color="$2"
  
  echo -e "\e[1m\e[40;${color}m${message}\e[0m"
}

# 功  能: 同 read
# 使  用: color::read 输出内容 颜色值 变量名
# 参数 1: 输出内容    [default: ]
# 参数 2: 颜色值    [default: ]
# 参数 3: 变量名    [default: ]
# 返回值: 输出内容 和 变量
# 备  注: 
color::read() {
  local message="$1"
  local color="$2"
  local var="$3"
  
  echo -ne "\e[1m\e[40;${color}m${message}\e[0m"
  read "${var}"
}

# 功  能: 倒计时
# 使  用: color::countdown 秒 颜色值 输出内容的前半部分 颜色值 输出内容的后半部分 颜色值
# 参数 1: 秒    [default: ]
# 参数 2: 颜色值    [default: ]
# 参数 3: 输出内容的前半部分    [default: ]
# 参数 4: 颜色值    [default: ]
# 参数 5: 输出内容的后半部分    [default: ]
# 参数 6: 颜色值    [default: ]
# 返回值: 输出内容
# 备  注: 
color::countdown() {
  local sec="$1"
  local sec_color="$2"
  local head="$3"
  local head_color="$4"
  local tail="$5"
  local tail_color="$6"
  local secs
  
  secs="$(seq "${sec}" | sort -nr)"
  
  for sec in ${secs}; do
    echo -ne "\e[1m\e[40;${head_color}m${head}\e[0m"
    echo -ne "\e[1m\e[40;${sec_color}m${sec}\e[0m"
    echo -ne "\e[1m\e[40;${tail_color}m${tail}\e[0m"
    echo -ne "        \r"
    
    sleep 1
  done
  
  echo -ne "        \r"
}

# 功  能: 
# 使  用: 
# 参数 1:     [default: ]
# 参数 2:     [default: ]
# 参数 3:     [default: ]
# 返回值: 
# 备  注: 
