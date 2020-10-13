# VPN

mac CLI use vpn

`http_proxy=http://127.0.0.1:3213 https_proxy=http://127.0.0.1:3213 brew install youtube-dl`

`ALL_PROXY=socks5://127.0.0.1:9001 brew upgrade`

Ubuntu CLI use vpn

``` shell
git config --global http.proxy http://127.0.0.1:3213
git config --global https.proxy http://127.0.0.1:3213

vim ~/.ssh/config
Host github.com
    ProxyCommand nc -X connect -x 127.0.0.1:3213 %h %p
sudo chmod 600 ~/.ssh/config 
    
git config --global --unset http.proxy
git config --global --unset https.proxy
```

##### How to Set the Proxy for APT on Ubuntu 18.04

``` shell
Creating  an Apt Proxy Conf File
Apt loads all configuration files under /etc/apt/apt.conf.d. We can create a configuration specifically for our proxy there, keeping it separate from all other configurations.
    Create a new configuration file named proxy.conf.
    sudo touch /etc/apt/apt.conf.d/proxy.conf
    Open the proxy.conf file in a text editor.
    sudo vi /etc/apt/apt.conf.d/proxy.conf
    Add the following line to set your HTTP proxy.
    Acquire::http::Proxy "http://user:password@proxy.server:port/";
    Add the following line to set your HTTPS proxy.
    Acquire::https::Proxy "http://user:password@proxy.server:port/";
    Save your changes and exit the text editor.
Your proxy settings will be applied the next time you run Apt.
Simplifying the Configuration
As mentioned by a user in the comments below, there is an alternative way for defining the proxy settings. While similar, it removes some redundancy.
Just like in the first example, create a new file under the /etc/apt/apt.conf.d directory, and then add the following lines.
Acquire {
  HTTP::proxy "http://127.0.0.1:8080";
  HTTPS::proxy "http://127.0.0.1:8080";
}
```
##### How to set apt-get proxy
``` shell
$ sudo vi /etc/apt/apt.conf

Acquire::http::Proxy "http://user:pass@proxy_host:port";
Acquire::https::Proxy "https://user:pass@proxy_host:port";
```
##### To use wget behind proxy
``` shell
sudo vi /etc/wgetrc

https_proxy  = http://username:password@proxy:port
http_proxy = http://username:password@proxy:port
http_proxy = http://Domain\username:password@proxy:port # (in case of LDAP)
ftp_proxy = http://username:password@proxy:port
Uncomment 'use_proxy = on'
```

##### Dockerfile apt-get behind proxy

``` shell
docker build -t <TARGET> --build-arg http_proxy=http://<IP:PORT> --build-arg https_proxy=http://<IP:PORT> --network=host .
```



## SquirrelVPN

## Kaspersky Secure Connection





## GUI应用使用VPN

在浏览器中可以正常使用VPN，但是在图形应用中，如果初始化时要下载被封锁的资源时，该应用并不会走VPN这条网络，而是默认使用正常的网络，最终会初始化失败。这时需要使用Proxifier这个工具帮助我们解决。

