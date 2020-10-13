# Double Operating System Installation Guidelines



insert USD stick and power on.

Computer Management -> Dsik Management -> New Simple Volume

Settings -> Update & Security -> Recovery -> Restart now -> Troubleshoot -> Advanced options -> UEFI Firmware Settings -> Restart -> Security -> **Secure Boot Disabled** -> ESC 

Settings -> Update & Security -> Recovery -> Restart now -> Boot -> Boot sequence

insert USD stick and restart

Install ubontu -> Normal installation -> Installation type -> something else -> focus on free space and click plus sign -> setup /,  swap, /home -> 



``` shell
sudo apt-get install samba
Reading package lists... Done
Building dependency tree
Reading state information... Done
Some packages could not be installed. This may mean that you have
requested an impossible situation or if you are using the unstable
distribution that some required packages have not yet been created
or been moved out of Incoming.
The following information may help to resolve the situation:

The following packages have unmet dependencies:
samba : Depends: samba-common (= 2:4.1.6+dfsg-1ubuntu2.14.04.7) but 2:4.1.6+dfsg-1ubuntu2.14.04.8 is to be installed
Depends: samba-common-bin (= 2:4.1.6+dfsg-1ubuntu2.14.04.7) but 2:4.1.6+dfsg-1ubuntu2.14.04.8 is to be installed
Depends: samba-dsdb-modules but it is not going to be installed
Depends: samba-libs (= 2:4.1.6+dfsg-1ubuntu2.14.04.7) but 2:4.1.6+dfsg-1ubuntu2.14.04.8 is to be installed
Recommends: attr
Recommends: samba-vfs-modules but it is not going to be installed
E: Unable to correct problems, you have held broken packages.


```





#### Linux fold share

method 1.  Focus on folder -> properties -> Local Network Share -> check box -> create

``` shell
# Error
The following packages have unmet dependencies:
samba : 
   k
#Solution
sudo apt --fix-broken install
sudo apt-get update
sudo apt-get upgrade
```

#### Fix Settings missing

``` shell
sudo apt install gnome-control-center
```

## How to Install Nvidia Driver on Ubuntu 18.04 From the Command Line

``` shell
sudo lshw -c display
// You can also use video instead of display as the class name.
sudo lshw -c video
sudo ubuntu-drivers devices
// As you can see, there are 3 drivers available for my GeForce GTX 1080 Ti card. Two are proprietary (non-free) drivers, which is recommend by Ubuntu. The other is the default open-source Nouveau driver. There may be some other drivers for your Nvidia card. To install the recommended driver, run the following command.
sudo ubuntu-drivers autoinstall
sudo apt install nvidia-driver-version-number
sudo apt install nvidia-driver-430			// For example
// After the driver is installed, we need to run the following command to reboot the computer, in order to enable nvidia-prime, which is technology to switch between Intel and Nvidia graphics card.
prime-select query

// If you want to use Intel graphics card, run the following command:
sudo prime-select intel
// To switch back to Nvidia card, run
sudo prime-select nvidia
```



Install linux first and windows second, maybe use this command:

``` shell
bcdedit /set "{bootmgr}" path \EFI\ubuntu\grubx64.efi
```



一、baiUSB-FDD和USB-HDDDE 区别：

1、启动模式：USB-FDD是模拟du软盘模式，一般的软zhi盘都可以用这个模式来启动；USB-HDD是硬dao盘模式，像移动硬盘什么的都可以用这种方式启动；

2、启动盘符：USB-FDD模式是指把U盘模拟成软驱模式，启动后U盘以后，电脑会把U盘看做是软盘，因此会在命令行上显示盘符是【A:】；USB-HDD硬盘仿真模式，启动后U盘的盘符是【C:】。

二、USB-FDD
1、含义：USB-FDD即USB Floppy Disk Drive的缩写，软驱磁盘驱动器。现已被淘汰。但部分未淘汰的老机子仍在使用。

2、作用：USB-FDD模式是指把U盘模拟成软驱模式，启动后U盘以后，电脑会把U盘看做是软盘，因此会在命令行上显示盘符是【A:】。以前的电脑没有光驱，也不支持USB-HDD，只能使用USB-FDD启动（这个模式的U盘在一些支持USB-FDD启动的机器上启动时，会找不到U盘）。

``` shell
# ubuntu restart get following error
SQUASHFS error: Unable to read fragment cache entry [22a4be36]
SQUASHFS error: Unable to read page, block 22a4be36, size 7e4a
SQUASHFS error: squashfs_read_data failed to read block 0Xd50d45d
SQUASHFS error: Unable to read metadata cache entry [764ae6ba]
SQUASHFS error: Unable to read inode 0x46fec065

Solution:
安装ubuntu时，在初始界面，即在选择try ubuntu和install那个菜单界面，将选中条移到install，按e进入grub编辑界面，在倒数第二行末尾加上acpi=off
```

