# SSH Tutorial

你有没有在ssh远程主机的时候，总是在切出去查资料的功夫再回来ssh就断了？

其实这个问题很好解决，解锁一下`/etc/ssh/sshd_config`的两项参数即可! 具体参数要根据具体情况来定，否则会带来安全隐患

``` shell
##这两项参数大概在110行左右的位置
ClientAliveInterval 3600  ##客户端允许连接时间，单位为秒
ClientAliveCountMax 3   ##客户端重试次数
```

Client end Solution:

``` shell
# per command:
ssh -o "ServerAliveInterval 60" -o "ServerAliveCountMax 120" <SERVER_ADDRESS>
# Persistent: To make it persistent write it to /etc/ssh/ssh_config (will apply system-wide) or ~/.ssh/config (will apply user-only):
ServerAliveInterval 60
ServerAliveCountMax 120
```

