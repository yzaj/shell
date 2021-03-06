#!/bin/bash
#
# 替换字符串
set -euo pipefail

# 功  能: 对 Windows 格式, GB2312 编码的文件, 进行字符串替换
# 使  用: sed.sh 原字符串 新字符串 文件
# 参数 1: 原字符串, 允许使用正则表达式    [default: ]
# 参数 2: 新字符串    [default: ]
# 参数 3: 文件, 允许文件不存在, 允许文件包含中文    [default: ]
# 返回值: 
# 备  注: 替换后, 文件格式和文件编码不会改变

readonly oldstr="$1"
readonly newstr="$2"
readonly filename="$3"

if [[ ! -s "${filename}" ]]; then
  exit
fi

sed -i 's/\r$//g' "${filename}"

iconv -f GB2312 -t UTF-8 "${filename}" > "${filename}.tmp"
mv "${filename}.tmp" "${filename}"

sed -i "s/${oldstr}/${newstr}/g" "${filename}"

iconv -f UTF-8 -t GB2312 "${filename}" > "${filename}.tmp"
mv "${filename}.tmp" "${filename}"

sed -i 's/$/\r/g' "${filename}"
