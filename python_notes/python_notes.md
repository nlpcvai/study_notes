# Python Study Notes

Python path

`#!/usr/bin/env python`    

### virtualenv

``` shell
sudo apt install virtualenv
virtualenv venv --python=python3
sudo apt install python3-pip
```

###### Choose gpu

``` shell
os.environ["CUDA_DEVICE_ORDER"]="PCI_BUS_ID"
os.environ["CUDA_VISIBLE_DEVICES"]="0"
```

Anaconda

``` shell
curl -O https://repo.anaconda.com/archive/Anaconda3-2020.07-Linux-x86_64.sh
sha256sum Anaconda3-2020.07-Linux-x86_64.sh

conda config --set remote_read_timeout_secs 1000

conda pack -n my_env
mkdir -p home/miniconda3/my_env
tar -xzf my_env.tar.gz -C home/miniconda3/my_env
source my_env/bin/activate
conda-unpack
source my_env/bin/deactivate
conda env list
conda activate my_env

vim .condarc
proxy_servers:
	http: http://127.0.0.1:3213
	https: https://127.0.0.1:3213
```



### pip

``` shell
pip install -i  http://mirrors.aliyun.com/pypi/simple/ numpy
pip install -i https://pypi.tuna.tsinghua.edu.cn/simple --trusted-host pypi.tuna.tsinghua.edu.cn  matplotlib
```

### pip

``` shell
pip install -i  http://mirrors.aliyun.com/pypi/simple/ --trusted-host mirrors.aliyun.com torch torchvision
# Error
Traceback (most recent call last):
  File "/usr/local/bin/pip3", line 5, in <module>
    from pip._internal.cli.main import main
ModuleNotFoundError: No module named 'pip'
#Solution
sudo apt-get remove --purge python3-pip
sudo apt-get autoremove && sudo apt-get autoclean && sudo apt-get clean
sudo apt-get update
sudo apt-get install python3-pip
# Error
Install throws TypeError: unsupported operand type(s) for -=: 'Retry' and 'int'
# Solution1
pip3 --default-timeout=1000 install requests
# Solution2
mkdir ~/.pip
cd ~/.pip/
vim pip.conf
[global]
timeout = 6000
index-url = http://mirrors.aliyun.com/pypi/simple/
[install]
use-mirrors = true
mirrors = http://mirrors.aliyun.com/pypi/simple/
# Error
$ virtualenv venv --python=python3
OSError: Command /home/mason/Projects/venv/bin/python3 - setuptools pkg_resources pip wheel failed with error code 2
# Solution
set timeout
# Error
$ sudo pip3 install --upgrade pip
The directory '/home/mason/.cache/pip/http' or its parent directory is not owned by the current user and the cache has been disabled. Please check the permissions and owner of that directory. If executing pip with sudo, you may want sudo's -H flag.
# Solution
set timeout
# Error
fatal error: Python.h: No such file or directory
# Solution
sudo apt-get install python3.7-dev
# Error
ERROR: Failed building wheel for PyOpenGL-accelerate
#Solution
$ tar -zxvf PyOpenGL-accelerate-3.1.0.tar.gz
$ cd PyOpenGL-accelerate-3.1.0
$ python setup.py install

#E
OpenEXR.cpp:36:10: fatal error: ImathBox.h: No such file or directory
#S
sudo apt install libopenexr-dev
sudo ldconfig
#E
/usr/bin/ld: cannot find -lz     collect2: error: ld returned 1 exit status
#S
sudo apt install libz-dev
#E
OpenGL.error.NullFunctionError: Attempt to call an undefined function glutInit, check for bool(glutInit) before calling
#S
sudo apt-get install freeglut3-dev
sudo apt-get install python-opengl
```

## Verification

To ensure that PyTorch was installed correctly, we can verify the  installation by running sample PyTorch code. Here we will construct a  randomly initialized tensor.

``` python 
from __future__ import print_function
import torch
x = torch.rand(5, 3)
print(x)
```

The output should be something similar to:

``` shell
tensor([[0.3380, 0.3845, 0.3217],
        [0.8337, 0.9050, 0.2650],
        [0.2979, 0.7141, 0.9069],
        [0.1449, 0.1132, 0.1375],
        [0.4675, 0.3947, 0.1426]])
```

check if your GPU driver and CUDA is enabled and accessible by PyTorch,  run the following commands to return whether or not the CUDA driver is  enabled:

``` python 
import torch
torch.cuda.is_available()
```

``` shell
# Error
ModuleNotFoundError: No module named 'pip._internal'
# Solution1
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
python3 get-pip.py --force-reinstall
# Solution2
sudo easy_install pip
# Solution3
sudo su
pip install
# Solution4
1. Go to /usr/local/bin by terminal
2. Execute sudo vim pip
3. Change the from pip._internal import main into from pip import main.	
# Error
Unable to locate package virtualenv in ubuntu-13 on a virtual-machine
# Solution
sudo apt-get update
sudo apt-get install virtualenv
#E
(venv) mason@9d98a046e697:/home/mason/Projects/tmp$ python test_env.py 
Could not find platform independent libraries <prefix>
Could not find platform dependent libraries <exec_prefix>
Consider setting $PYTHONHOME to <prefix>[:<exec_prefix>]
Fatal Python error: initfsencoding: unable to load the file system codec
ModuleNotFoundError: No module named 'encodings'

Current thread 0x00007f1db11fe740 (most recent call first):
Aborted (core dumped)
#S
use requirements.txt to reinstall the virtual environment
#E
ValueError: bad marshal data (unknown type code)
#S
find package_name -name '*.pyc' -delete  // or
find . -name "*.pyc" -exec rm -f {} \;
#E
tqdm progressbar and zip built-in do not work together
#S
specify length will ok
#E
138 | #error -- unsupported GNU version! gcc versions later than 8 are not supported!
#S
export CONDA_BUILD=1 
sudo update-alternatives --config gcc         #choose a right version to match cuda
#E
E: Package 'python-software-properties' has no installation candidate
#S
I was getting started with the torch and faced the error.
Here is how I got it resolved.
goto

Home -> Torch -> Open install-deps

find the keyword python-software-properties and replace it with software-python-common, save and exit.

install the software-python-common with the command

sudo apt-get install software-properties-common 
run the command

cd ~/torch; bash install-deps;
You are done!!
#E
CMake Error: The following variables are used in this project, but they are set to NOTFOUND.
Please set them or make sure they are set and tested correctly in the CMake files:
CUDA_cublas_device_LIBRARY (ADVANCED)
    linked by target "THC" in directory /home/mason/torch/extra/cutorch/lib/THC
#S

#E
E: Package 'ipython' has no installation candidate
#S
add deb http://cz.archive.ubuntu.com/ubuntu bionic main universe in source.list
```
Error:

tqdm progressbar and zip built-in do not work together

<img src="../python_resource/A0Pmu.png"/>

Solution:

![DG36L](../python_resource/DG36L.png)

The issue is that tqdm needs to know the length of the iterable ahead of time. Because zip is meant to handle iterables with different lengths, it does not have as an attribute a single length of its arguments. So, **tqdm** still works nicely with zip, you just need to provide a little manual control with the 'total' keyword argument.

##### Question & Answer

``` shell
#Q:
How to move a virtualenv
#A:
An example of usage:
$ cd ~/first
$ virtualenv my-venv
$ grep 'VIRTUAL_ENV=' my-venv/bin/activate
VIRTUAL_ENV="/home/username/first/my-venv"
$ virtualenv --relocatable my-venv
Making script my-venv/bin/easy_install relative
Making script my-venv/bin/easy_install-2.7 relative
Making script my-venv/bin/pip relative
Making script my-venv/bin/pip2 relative
Making script my-venv/bin/pip2.7 relative
### Note that `activate` has not been touched
$ mkdir ~/second
$ mv my-venv ~/second
$ cd ~/second
$ grep 'VIRTUAL_ENV=' my-venv/bin/activate
VIRTUAL_ENV=/home/username/first/my-venv
### (This variable hasn't been changed, it still refers to the old, now non-existent directory!)
$ sed -i -e 's|username/first|username/second|' my-venv/bin/activate
## sed can be used to change the path.
## Note that the `-i` (in place) flag won't work on all machines. 
$ source my-venv/bin/activate 
#Q
How to install python3.8
#A
sudo apt update
sudo apt install software-properties-common -y
sudo add-apt-repository ppa:deadsnakes/ppa -y
sudo apt install python3.8
```