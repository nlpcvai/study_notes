# shell study note

## shell prompt short-cut

### Linux

```shell

​```bash
!!          # 执行上一条命令
!?string?   # 执行含有 string 字符串的最新命令
!num        # 执行命令历史列表的第 num 条命令
Alt+<       # 历史列表第一项
Alt+>       # 历史列表最后一项
Alt+b       # 光标向后移动一个单词
Alt+c       # 把当前词汇变成首字符大写
Alt+d       # 剪切光标之后的词
Alt+f       # 光标向前移动一个单词
Alt+l       # 把当前词转化为小写
Alt+t       # 交换当前与以前单词的位置
Alt+u       # 把当前词转化为大写
Ctrl+(x u)  # 按住 Ctrl 的同时再先后按 x 和 u，撤销刚才的操作
Ctrl+a      # 移动到当前行的开头
Ctrl+b      # 光标向后移动一个字符,相当与`<-`
Ctrl+c      # 删除整行
Ctrl+d      # 删除光标所在处字符
Ctrl+e      # 移动到当前行的结尾
Ctrl+f      # 光标向前移动一个字符,相当与`->`
Ctrl+h      # 删除光标所在处前一个字符
Ctrl+k      # 剪切命令行中光标所在处之后的所有字符（包括自身）
Ctrl+l      # 清屏
Ctrl+q      # 重新启用挂起的 shell
Ctrl+r      # 然后输入若干字符，开始向上搜索包含该字符的命令，继续按 Ctrl+r，搜索上一条匹配的命令
Ctrl+s      # 与 Ctrl+r 类似,只是正向检索
Ctrl+s      # 挂起当前 shell
Ctrl+t      # 颠倒光标所在处及其之前的字符位置，并将光标移动到下一个字符
Ctrl+u      # 剪切命令行中光标所在处之前的所有字符（不包括自身）
Ctrl+v      # 插入特殊字符,如 Ctrl+v+Tab 加入 Tab 字符键
Ctrl+w      # 剪切光标所在处之前的一个词（以空格、标点等为分隔符）
Ctrl+y      # 粘贴刚才所删除的字符
Esc+b       # 移动到当前单词的开头
Esc+f       # 移动到当前单词的结尾
Esc+t       # 颠倒光标所在处及其相邻单词的位置
Esc+w       # 删除光标所在处之前的字符至其单词尾（以空格、标点等为分隔符）
ls !$       # 执行命令 ls，并以上一条命令的参数为其参数
↑(Ctrl+p)   # 显示上一条命令
↓(Ctrl+n)   # 显示下一条命令

```



``` shell
ctrl+w 		# delete a work before cursor
ctrl+s		# freeze the shell
ctrl+q		# unfreeze the shell

```



### mac

- **Ctrl+A** 光标移动到行首，相当于Home键
- **Ctrl+E** 光标移动到行尾，相当于End键
- **Ctrl+B** 光标左移一个字符，相当于←方向键
- **Ctrl+F** 光标右移一个字符，相当于→方向键
- **Ctrl+D** 删除光标所在处的字符，并向右删除，相当于Del键；最后一次可退出当前Shell
- **Ctrl+H** 删除光标左侧的字符，相当于Backspace
- **Ctrl+K** 删除从光标所在处字符及其后的所有字符，相当于长按Del键
- **Ctrl+U** 删除从光标所在处字符前面（到行首）的所有字符，相当于长按Backspace键
- **Ctrl+L** 清屏，删除屏幕的所有输出，相当于Linux clear命令 或Windows cls命令
- **Ctrl+W** 删除光标左侧的一个单词
- **Ctrl+T** 交换光标前两个字符位置
- **ESC+T** 交换光标前两个单词位置
- **Ctrl+C** 结束当前命令
- **Ctrl+R** 在历史命令中查找,输入关键字过滤，重复命令进行滚动查找
- **Ctrl+Z** 挂起/停止命令，前后台切换，可用fg，bg命令恢复
- **Ctrl+P** 上一条命令，相当于↑方向键
- **Ctrl+N** 下一条命令，相当于↓方向键
- **Ctrl+J** 相当于Enter
- **Ctrl+I** 自动补全，相当于Tab键



### shell execute

bash        use interpreter, need not add execute priot

./             need add execute prior



### shell feature

#### color

``` shell
echo -e "\033[36m green \033[0m"
```

### variable

```shell
IP=$(ifconfig en0 | grep "inet")
ping -c1 192.168.56.11 &>/dev/null && echo "ip 192.168.56.11 ok" || echo "ip 192.168.56.11 error"

#!/bin/bash
IP=192.168.56.11
ping -c1 "$IP" &>/dev/null && echo "ip $IP ok" || echo "ip $IP error"

#!/bin/bash
IP=192.168.56.11
ping -c1 "$IP" &>/dev/null
if [ $? -eq 0 ];then
	echo "\033[36m ip $IP ok \033[0m"
else
	echo "\033[31m ip $IP error \033[0m"
	
	
#!/bin/bash
ping -c1 $1 &>/dev/null
if [ $? -eq 0 ];then
	echo "\033[36m ip $1 ok \033[0m"
else
	echo "\033[31m ip $1 error \033[0m"


#!/bin/bash
read -p "Please input ip: " IP
ping -c1 "$IP" &>/dev/null
if [ $? -eq 0 ];then
	echo "\033[36m ip $IP ok \033[0m"
else
	echo "\033[31m ip $IP error \033[0m"

$IP  ${IP}    #difference    concatenate with other word

unset $a

sh -xv ping.sh.  #use debug mode

#!/bin/bash
echo "`basename $0`"
echo '$*='$*
echo '$@='$@
echo '$#='$#
echo '$1='$1
echo '$$='$$

echo "${xxx}"   #double quote parse the content
echo '${xxx}'   #single quote not parse the content
                # \`\` equals $()
                
                
                
url=www.test.com
echo ${#url}       #get length
echo ${url#*.}		 #indice
echo ${url##*.}
echo ${url:0:5}

echo ${url:5:5}
echo ${url/sina/baidu}
echo ${url/n/N}
echo ${url//n/N}

unset var1   
 # default value
url=www.sina.com
echo $url
echo ${url-www.baidu.com}
unset url
echo ${url-www.baidu.com}


url2=
echo ${url2-www.baidu.com}


url=www.sina.com
echo $url
echo ${url:-www.baidu.com}
unset url
echo ${url:-www.baidu.com}

```

### integer arithmatic

```shell
expr 2 + 1
$(())
$[]
let sum=2+3

echo "scale=2;6/4" |bc

```

## File test

```shell
which test
test -d /backup || mkdir -p /backup
echo $?
which [

[ -e dir|file ]
[ -d dir ]
[ -f file ]
[ -r file ]
[ -x file ]
[ -w file ]
[ -L file]

[ 1 -gt 10 ]
[ 1 -lt 10 ]
[ 1 -eq 10 ]
[ 1 -ne 10 ]
[ 1 -ge 10 ]
[ 1 -le 10 ]


df -h|grep /$|awk '{print $(NF-1)}'
df -h|grep /$|awk '{print $(NF-1)}'|awk -F '%' '{print $1}'


```

## String compare

``` shell
[ $USER == "mason" ];echo $?
[ $USER != "mason" ];echo $?
[ -z "$url" ]
[ -n "$url" ]
[ 1 -lt 2 -a 5 -gt 10 ]
[[ 1 -lt 2 && 5 -gt 10 ]]

[[ "$USER" =~ ^r ]];echo $?    # [[]] use regular expression
[[ "$num" =~ ^[0-9]+$ ]];echo $?
```

## Control

``` shell
while date; do date; sleep 1; done
while :;do echo 1;done
```

## Array

``` shell
book=(linux shell openstack)
echo ${book[0]}
echo ${book[@]}
echo ${book[*]}

declare -a tt
tt=([index1]=test [index2]=test2)
echo ${tt[@]}
echo ${!tt[@]}
echo ${#tt[@]}

```

## Function

``` shell

```



## Regular expression

``` shell
grep "^G" test.txt
grep "m$" test.txt
grep "^$" test.txt
grep -v "^$" test.txt
grep -vn "^$" test.txt
grep "." test.txt
grep ".*" test.txt
grep "x..u" test.txt
grep "\.$" test.txt
grep -o "8*" test.txt
grep [abc] test.txt
grep "8\{3\}" test.txt 
egrep "8{3}" test.txt
grep -E "8{3}" test.txt


```

## Sed  and awk



Sed  [options] 'command' file

Exit status always 0

``` shell
#options:
-r 		#support expand meta character
-n 		# omit default output


#command
a
c
d
i
sed -i '30a listen80' passwd.txt 
sed -i '30a \\t listen80;' passwd.txt
sed '/^SELINUX/p' /etc/selinux/config
sed  -i '/^SELINUX/c SELINUX=Disabled' /etc/selinux/config
sed  -i '7c SELINUX=Disabled' /etc/selinux/config
sed 's/root/rt' passwd.txt
sed 's/root/rt/g' passwd.txt


$0  	#save file content
NR		# number of line
FNR 	# The input record number in the current input file
awk 'NR<3{print $0}' passwd.txt
awk '{print NR $0}' passwd.txt
awk 'BEGIN{RS=":"}{print $0}' passwd.txt
awk -F: '{if($3==0){print $1 " is admin"}}' passwd.txt
```

``` shell
set参数介绍
set指令能设置所使用shell的执行方式，可依照不同的需求来做设置
　-a 　标示已修改的变量，以供输出至环境变量。
　-b 　使被中止的后台程序立刻回报执行状态。
　-C 　转向所产生的文件无法覆盖已存在的文件。
　-d 　Shell预设会用杂凑表记忆使用过的指令，以加速指令的执行。使用-d参数可取消。
　-e 　若指令传回值不等于0，则立即退出shell。　　
　-f　 　取消使用通配符。
　-h 　自动记录函数的所在位置。
　-H Shell 　可利用"!"加<指令编号>的方式来执行history中记录的指令。
　-k 　指令所给的参数都会被视为此指令的环境变量。
　-l 　记录for循环的变量名称。
　-m 　使用监视模式。
　-n 　只读取指令，而不实际执行。
　-p 　启动优先顺序模式。
　-P 　启动-P参数后，执行指令时，会以实际的文件或目录来取代符号连接。
　-t 　执行完随后的指令，即退出shell。
　-u 　当执行时使用到未定义过的变量，则显示错误信息。
　-v 　显示shell所读取的输入值。
　-x 　执行指令后，会先显示该指令及所下的参数。
　+<参数> 　取消某个set曾启动的参数。
```



