# Linux

### rz/sz file transfer tool

``` shell
wget https://ohse.de/uwe/releases/lrzsz-0.12.20.tar.gz
./configure && make && make install
cd /usr/bin
ln -s /usr/local/bin/lrz rz
ln -s /usr/local/bin/lsz sz
```
###### Add user
``` shell
sudo useradd -s /path/to/shell -d /home/{dirname} -m -G {secondary-group} {username}
sudo passwd {username}
$ sudo useradd -s /bin/bash -d /home/mason/ -m -G sudo mason
$ sudo passwd mason
-s /bin/bash – Set /bin/bash as login shell of the new account
-d /home/mason/ – Set /home/mason/ as home directory of the new Ubuntu account
-m – Create the user’s home directory
-G sudo – Make sure mason user can sudo i.e. give admin access to the new account
```
###### Change owner

``` shell
chown mason xxxx_file
chgrp mason xxxx_file
chmod +x    xxxx_file
sudo usermod -aG docker your-user
```

##### Source dosen't work

When you use source outside the / directory.

#### Disk commands

``` shell
du -sh * | sort -hr | head -n10
```

##### Samba

``` shell
# apt install samba-common samba smbclient
# ufw allow samba
or 
# firewall-cmd --permanent --add-port={139/tcp,445/tcp}
# firewall-cmd --reload

vim  /etc/samba/smb.conf
Configuring the [global] Section
workgroup = WORKGROUP
netbios name = LinuxServer

Configuring a Shared Resource
[sampleshare]
        comment = Example Samba share
        path = /sampleshare
        browseable = Yes
        public = yes
        writable = yes
      
Creating a Samba User
# smbpasswd -a demo
New SMB password:
Retype new SMB password:
Added user demo.

Testing the smb.conf File
# testparm
Load smb config files from /etc/samba/smb.conf
rlimit_max: increasing rlimit_max (1024) to minimum Windows limit (16384)
WARNING: The "syslog" option is deprecated
Processing section "[printers]"
Processing section "[print$]"
Processing section "[sampleshare]"
Loaded services file OK.
Server role: ROLE_STANDALONE
 
Press enter to see a dump of your service definitions
 
# Global parameters
[global]
	dns proxy = No
	log file = /var/log/samba/log.%m
	map to guest = Bad User
	max log size = 1000
	netbios name = LINUXSERVER
	obey pam restrictions = Yes
	pam password change = Yes
	panic action = /usr/share/samba/panic-action %d
	passwd chat = *Enter\snew\s*\spassword:* %n\n *Retype\snew\s*\spassword:* %n\n *password\supdated\ssuccessfully* .
	passwd program = /usr/bin/passwd %u
	security = USER
	server role = standalone server
	server string = %h server (Samba, Ubuntu)
	syslog = 0
	unix password sync = Yes
	usershare allow guests = Yes
	wins support = Yes
	idmap config * : backend = tdb
 
[printers]
	browseable = No
	comment = All Printers
	create mask = 0700
	path = /var/spool/samba
	printable = Yes
 
[print$]
	comment = Printer Drivers
	path = /var/lib/samba/printers
 
[sampleshare]
	comment = Example Samba share
	guest ok = Yes
	path = /sampleshare
	read only = No

Starting the Samba and NetBIOS Name Services
# systemctl enable smbd
# systemctl start smbd
# systemctl enable nmbd
# systemctl start nmbd

# smbclient -U demo -L localhost 
Enter WORKGROUP\demo's password: 
 
	Sharename       Type      Comment
	---------       ----      -------
	print$          Disk      Printer Drivers
	sampleshare     Disk      Example Samba share
	IPC$            IPC       IPC Service (demo-server2 server (Samba, Ubuntu))
	Officejet_Pro_8600_C7C718_ Printer   
	Officejet_6600_971B9B_ Printer   
Reconnecting with SMB1 for workgroup listing.
 
	Server               Comment
	---------            -------
 
	Workgroup            Master
	---------            -------
	WORKGROUP            LINUXSERVER
```



##### Open fine manager

``` shell
nautilus .

The following is an exemplary command of how to archive your system.
tar -cvpzf backup.tar.gz --exclude=/backup.tar.gz --one-file-system / 
```
##### Remote SSH access
``` shell
sudo apt-get install openssh-server
sudo service ssh status
ssh localhost
```
##### linux memory out of usage solution

``` shell
# Add virtual memory
swith to root
dd if=/dev/zero of=/opt/swap bs=1024 count=1024000
chmod 600 /opt/swap
swapon /opt/swap

# Delete virtual memory
swapoff /opt/swap
rm /opt/swap
```

``` shell
$ lsb_release -a
No LSB modules are available.
Distributor ID:	Ubuntu
Description:	Ubuntu 16.04.6 LTS
Release:	16.04
Codename:	xenial
```

###### Change owner / group recursively

``` shell
sudo find . -type f -exec chown mason.mason {} \;
sudo find . -type d -exec chown mason.mason {} \;

Unix-like operating systems decouple the user name from the user identity, so you may safely change the name without affecting the ID. All permissions, files, etc are tied to your identity (uid), not your username.

To manage every aspect of the user database, you use the usermod tool.

To change username (it is probably best to do this without being logged in):

sudo usermod -l newUsername oldUsername
This however, doesn't rename the home folder.

To change home-folder, use

sudo usermod -d /home/newHomeDir -m newUsername
after you changed the username.

For instance, you could logout, drop to a console (Ctrl+Alt+F1), and sudo su - to become true root (as opposed to sudo -s, where $HOME is still /home/yourname.) Maybe you also have to kill some still running processes from this user first. To do so, enter ps -u username, look for the matching PID and kill them by kill PID-number.

Update: as arrange mentioned, some files may reference your old home directory. You can either keep a symlink for backward compatibility, e g ln -s /home/newname /home/oldname or you can change the file contents with sed -i.bak 's/*oldname*/*newname*/g' *list of files* It creates a backup for each file with a .bak extension.

Some additional information for not so experienced users like me:
As I only have ONE user account (administrator), it would not let me change the username ("you are already logged in" was the response in TTY1 (Ctrl+Alt+F1). To get around this:

Login with your old credentials and add a new user, e.g. "temporary" in TTY1:

sudo adduser temporary
set the password.

Allow the temporary user to run sudo by adding the user to sudo group:

sudo adduser temporary sudo
Log out with the command exit.
Return to tty1: Login with the 'temporary' user account and password. Change your username and folder as mentioned above. exit (until you get the login prompt)
Go back to TTY7 (Ctrl+Alt+F7) to login on the GUI/normal desktop screen and see if this works.
Delete temporary user and folder:

sudo deluser temporary
sudo rm -r /home/temporary
```
###### Install Rtree
``` shell
cd spatialindex-src-1.9.3
cmake ..;make;sudo make install
sudo ldconfig            # note: install failed if no ldconfig
pip install Rtree --trusted-host mirrors.aliyun.com
```

##### Bug and Solution

``` shell
# Error
ImportError: No module named Cython
# Solution
pip install --upgrade cython
# Error
pyembree/mesh_construction.cpp:648:10: fatal error: embree2/rtcore.h: No such file or directory
# Solution
The embree version has upgraded, need to find a older version, copy the bin, lib, include folder to the right place, or set environment variables right.
#Error
/usr/bin/ld: cannot find -lXxf86vm
/usr/bin/ld: cannot find -lfreetype
collect2: error: ld returned 1 exit status
make[2]: *** [CMakeFiles/7.in_practice__1.debugging.dir/build.make:88: ../bin/7.in_practice/7.in_practice__1.debugging] Error 1
make[1]: *** [CMakeFiles/Makefile2:239: CMakeFiles/7.in_practice__1.debugging.dir/all] Error 2
make: *** [Makefile:84: all] Error 2
# Solution
sudo apt install libxxf86vm-dev
sudo apt install libfreetype-dev
#E
Cmake openpose problem (Could NOT find CUDA, cuDNN not found)
#S
apt install nvidia-cuda-toolkit
#E
win10 cannot access ubuntu share folder after several minutes, the error message is location error, arguments error.
#S
sudo ufw disable
Append "security = share" to the "/etc/samba/smb.conf" file.
#E
dpkg: error: dpkg frontend is locked by another process
#S
sudo apt-get install -f
#查看哪個LOCK
sudo rm /var/lib/dpkg/lock-frontend
sudo apt-get install -f
```

##### Question & Answer

``` shell
#Q: Dual monitor applications opening on wrong monitor
#A: Something similar to this happened to me a while back. Try going to System > Preferences > Monitors. Make sure that the main monitor (your working monitor) is to the left and not the right. If the two monitors are different resoutions make sure that they both align at the top. I noticed this with my setup a couple months ago when I installed a monitor that was using a resolution way higher than my working monitor.

#Q: Ubuntu 20.04 external full HD monitor flicker
#A: Finally a simple change of resolution from 2048 x 1152 to 1920 x 1080 (at Settings - Devices - Displays - [choose the problematic display] Resolution) worked. (May be should replace VAG with HDMI cable).

#Q: 
How to install snap packages behind web proxy on Ubuntu.
#A: 
A system option was added in snap 2.28 to specify the proxy server.
$ sudo snap set system proxy.http="http://<proxy_addr>:<proxy_port>"
$ sudo snap set system proxy.https="http://<proxy_addr>:<proxy_port>"
#Q
 What is foo , bar , baz really mean?
#A
foo, bar , baz, foonley are metasyntactic variables.
metasyntactic variables are used in formal logic, and used in spoken languages
A metasyntactic variable is a specific word or set of words identified as a placeholder in computer science and specifically computer programming. These words are commonly found in source code and are intended to be modified or substituted to be applicable to the specific usage before compilation (translation to an executable).
The words foo and bar are good examples as they are used in over 330 Internet Engineering Task Force Requests for Comments, which are documents explaining foundational internet technologies like HTTP (websites), TCP/IP, and email protocols.
By mathematical analogy, a metasyntactic variable is a word that is a variable for other words, just as in algebra letters are used as variables for numbers.
Metasyntactic variables are used to name entities such as variables, functions, and commands whose exact identity is unimportant and serve only to demonstrate a concept, which is useful for teaching programming.
Due to English being the foundation-language, or lingua franca, of most computer programming languages these variables are commonly seen even in programs and examples of programs written for other spoken-language audiences.
The typical names may depend however on the subculture that has developed around a given programming language.
General usage
Metasyntactic variables used commonly across all programming languages include foobar, foo, bar, baz, qux, quux, quuz, corge, grault, garply, waldo, fred, plugh, xyzzy, thud, Wibble, wobble, wubble, and flob are also used in the UK.
A complete reference can be found in a MIT Press book titled The Hacker's Dictionary.
Usage
In C & C++ programming languages foo  and bar are used as function names and variables.
In Python programming language : Spam, ham, and eggs are the principal metasyntactic variables used in the Python programming language. This is a reference to the famous comedy sketch, "Spam", by Monty Python, the eponym of the language.
```
##### Summary
``` shell
1. transfer big file
$ split -b 100M Linux_Security.mp4 ls.
$ cat ls.?? > Linux_security.mp4
2. Backup system
# dd if=/dev/sda of=/dev/sdb conv=noerror,sync
3. NTFS disk can be mounted on linux system, but can't be seen in command line, need to use it in GUI.
```

## Installing Multiple GCC Versions

``` shell
sudo apt install software-properties-common
sudo add-apt-repository ppa:ubuntu-toolchain-r/test

sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-9 90 --slave /usr/bin/g++ g++ /usr/bin/g++-9 --slave /usr/bin/gcov gcov /usr/bin/gcov-9
sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-8 80 --slave /usr/bin/g++ g++ /usr/bin/g++-8 --slave /usr/bin/gcov gcov /usr/bin/gcov-8
sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-7 70 --slave /usr/bin/g++ g++ /usr/bin/g++-7 --slave /usr/bin/gcov gcov /usr/bin/gcov-7

sudo update-alternatives --config gcc

```



#####  Ubuntu 20.04 Remote Desktop Access from Windows 10

``` shell
$ sudo apt install xrdp
$ sudo systemctl enable --now xrdp
$ sudo ufw allow from any to any port 3389 proto tcp
From time to time I have received a black screen after initiating the remote connection to the Xrdp Remote Desktop Protocol (RDP) server. Although I'm not sure how to completely resolve this issue but logging out from the Ubuntu desktop prior to making a remote connection have solved it at least temporarily.
```

##### zip
``` shell
for i in */; do zip -rm "${i%/}.zip" "$i"; done
```
​      
