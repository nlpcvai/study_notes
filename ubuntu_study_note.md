# ubuntu

#### gnome-terminal

``` shell
CTRL + ALT + T (Open New Terminal) CTRL + SHIFT + T (Open New Tab in the terminal(Note you should not present on browser while executing this shortcut otherwise last closed browser tab will be opened)
gnome-terminal (open New Terminal) gnome-terminal --tab (open New tab in the terminal)
ALT + (tab number) ex: ALT + 1 (change to First Terminal tab) Alt + 2 (change to second Terminal Tab)
```

##### Chinese input

``` shell
# Ubuntu 20.04 version
Settings -> Region & Language -> Input Source -> + -> Chinese -> Chinese (Intelligent Pinyin) 
# Only choose Chinese doesn't work
Manage Installed Languages -> Install/Remove Languages... -> Chinese -> Keyboard input method system -> IBus
```

##### Linux http/https proxy

``` shell
# http/https proxy
export https_proxy="127.0.0.1:3213"
export http_proxy="127.0.0.1:3213"
export http_proxy_user=pubuliuyun@163.com
export http_proxy_pass=xxxx

# SSH proxy
Host *
    ProxyCommand nc -X connect -x 127.0.0.1:3213 %h %p

# Edit .bashrc
# Set Proxy
function setproxy() {
    export {http,https,ftp}_proxy="http://127.0.0.1:3213"
}
# Unset Proxy
function unsetproxy() {
    unset {http,https,ftp}_proxy
}
```



Upgrade ubuntu

``` shell
# Step 1. Make a backup
lsb_release -a
uname -mrs

# Step 2. Upgrade all installed packages on Ubuntu 18.04 LTS
sudo apt update
sudo apt list --upgradable
sudo apt upgrade

# Step 3. Ubuntu 18.04 remove all unused old kernels
Run the following to remove them:
sudo apt --purge autoremove
Sample outputs:

Reading package lists... Done
Building dependency tree       
Reading state information... Done
The following packages will be REMOVED:
  linux-headers-4.15.0-45* linux-headers-4.15.0-45-generic*
  linux-image-4.15.0-45-generic* linux-modules-4.15.0-45-generic*
  linux-modules-extra-4.15.0-45-generic*
0 upgraded, 0 newly installed, 5 to remove and 0 not upgraded.
After this operation, 334 MB disk space will be freed.
Do you want to continue? [Y/n] y
(Reading database ... 138353 files and directories currently installed.)
Removing linux-headers-4.15.0-45-generic (4.15.0-45.48) ...
Removing linux-headers-4.15.0-45 (4.15.0-45.48) ...
Removing linux-modules-extra-4.15.0-45-generic (4.15.0-45.48) ...
Removing linux-image-4.15.0-45-generic (4.15.0-45.48) ...

Make sure you install update-manager-core package
We need to install the Update Manager on server as it may or man not installed on your box:
sudo apt install update-manager-core

# Step 4. Upgrade Ubuntu Linux to latest LTS
Execute the following command:
sudo do-release-upgrade
Please note if you may be greeted with the following message:

Checking for a new Ubuntu release
There is no development version of an LTS available.
To upgrade to the latest non-LTS develoment release 
set Prompt=normal in /etc/update-manager/release-upgrades.

In that case, pass the -d option to get the latest supported release forcefully:
sudo do-release-upgrade -d
Sample outputs:

Reading cache
 
Checking package manager
 
Continue running under SSH? 
 
This session appears to be running under ssh. It is not recommended 
to perform a upgrade over ssh currently because in case of failure it 
is harder to recover. 
 
If you continue, an additional ssh daemon will be started at port 
'1022'. 
Do you want to continue? 
 
Continue [yN] y
 
Starting additional sshd 
 
To make recovery in case of failure easier, an additional sshd will 
be started on port '1022'. If anything goes wrong with the running 
ssh you can still connect to the additional one. 
If you run a firewall, you may need to temporarily open this port. As 
this is potentially dangerous it's not done automatically. You can 
open the port with e.g.: 
'iptables -I INPUT -p tcp --dport 1022 -j ACCEPT' 
 
To continue please press [ENTER]

No valid mirror found warning:

Updating repository information
 
While scanning your repository information no mirror entry for the 
upgrade was found. This can happen if you run an internal mirror or 
if the mirror information is out of date. 
 
Do you want to rewrite your 'sources.list' file anyway? If you choose 
'Yes' here it will update all 'bionic' to 'focal' entries. 
If you select 'No' the upgrade will cancel. 
 
Continue [yN]

Just say yes to use the official Ubuntu repo.
Reboot the box

We are almost done:

System upgrade is complete.

Restart required 

To finish the upgrade, a restart is required. 
If you select 'y' the system will be restarted. 

Continue [yN] y
Connection to 52.xxx.yy.zz closed by remote host.
Connection to 52.xxx.yy.zz closed.

In other words, confirm by typing ‘y‘ when asked to reboot the box:

# Step 5. Verification
Check your Disro version:
lsb_release -a
Sample outputs:

No LSB modules are available.
Distributor ID:	Ubuntu
Description:	Ubuntu 20.04 LTS
Release:	20.04
Codename:	focal

Verify Linux kernel version and other log files too:
tail -f /var/log/my-app.log
uname -mrs
Sample outputs:

Linux 5.4.0-24-generic x86_64

On AWS EC2 or Lightsail server will see the following Linux kernel:

Linux 5.4.0-1011-aws x86_64

# Step 6. Enable disabled 3rd party repo
During the upgrade process, 3rd party software repos will be disabled for stability reasons. For example, Google Chrome and others are disabled. So we need to enable those using either the CLI or GUI tool called Software and Updates. Use the cd command as follows:
cd /etc/apt/sources.list.d/
List those repos:
ls -l
Let us see google-chrome.list using the cat command:
cat google-chrome.list
Sample outputs:

### THIS FILE IS AUTOMATICALLY CONFIGURED ###
# You may comment out this entry, but any other modifications may be lost.
# deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main # disabled on upgrade to focal

Edit the file:
sudo nano google-chrome.list
## OR ##
sudo vim google-chrome.list
Now update the file by removing the ‘#’ so that it reads as follows:

### THIS FILE IS AUTOMATICALLY CONFIGURED ###
# You may comment out this entry, but any other modifications may be lost.
deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main # disabled on upgrade to focal

Save and close the file in vim text editor. Finally update your apt repos:
sudo apt update
sudo apt upgrade

# Step 7. Upgrade Ubuntu To 20.04 LTS Focal Fossa desktop system using GUI method
let us see how to upgrade on a desktop system.

    First, keep backups of all important data.
    Open the “Software & Updates” Setting in System Settings.
    Select the 3rd Tab called “Updates“.
Click to enlarge
Set the “Notify me of a new Ubuntu version” drop down menu to “For long-term support versions” if you are using 18.04 LTS; set it to “For any new version” if you are using 19.10.
Open the terminal and type the following command:
update-manager -c -d
step -2
Next, update Manager should open up and tell you that Ubuntu 20.04 LTS is now available. If the update-manager -c -d command failed to work, run the following command:
/usr/lib/ubuntu-release-upgrader/check-new-release-gtk
Click Upgrade and follow the on-screen instructions.
```



``` shell
An error occurred, please run Package Manager from the right-click from the right click window or apt-get in a terminal to see what is wrong. The error message was: 'Error:Opening the cache (E:flAbsPath on/var/lib/dpkg/status failed - realpath (2: No such file or directory), E:Could not open file)'

Solution:
正在读取软件包列表… 有错误！
E: flAbsPath on /var/lib/dpkg/status failed - realpath (2: 没有那个文件或目录)
E: 无法打开文件 - open (2: 没有那个文件或目录)
E: Problem opening
E: 无法解析或打开软件包的列表或是状态文件。

首先：&ysc：sudo mkdir -p /var/lib/dpkg/{alternatives,info,parts,triggers,updates}
&ysc：sudo cp /var/backups/dpkg.status.0 /var/lib/dpkg/status
现在,让我们看看如果你的dpkg工作(开始祈祷):
&ysc：apt-get download dpkg
&ysc：sudo dpkg -i dpkg*.deb
如果一切都是“ok”,那么修复你的基地文件:
&ysc：apt-get download base-files
&ysc：sudo dpkg -i base-files*.deb
现在尝试更新你的包列表等。
&ysc：sudo apt-get update
&ysc：sudo apt-get check
------------------------------------------------------------
# Operation
sudo apt-get update

# Error
Reading package lists... Done       
E: The repository 'http://download.opensuse.org/repositories/home:/strycore/xUbuntu_16.04  Release' does not have a Release file.
N: Updating from such a repository can't be done securely, and is therefore disabled by default.
N: See apt-secure(8) manpage for repository creation and user configuration details.
E: The repository 'http://ppa.launchpad.net/fcitx-team/nightly/ubuntu focal Release' does not have a Release file.
N: Updating from such a repository can't be done securely, and is therefore disabled by default.
N: See apt-secure(8) manpage for repository creation and user configuration details.

# Solution
sudo rm -rf /var/lib/apt/lists/*
sudo rm -rf /etc/apt/sources.list.d/*
sudo apt-get update

```

``` shell

Unlock the dpkg – (message /var/lib/dpkg/lock)

sudo fuser -vki /var/lib/dpkg/lock

sudo dpkg –configure -a

sudo rm /var/lib/apt/lists/lock
sudo rm /var/cache/apt/archives/lock
```

``` shell
#E
$python3 -m venv test
Error: Command '['/home/mason/workspace/venvs/sss/bin/python3', '-Im', 'ensurepip', '--upgrade', '--default-pip']' returned non-zero exit status 1.
#S
apt update
apt install python3-venv  // the version should match python3

```

