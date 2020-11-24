# GPU notes

``` shell
# Question
How do I select which GPU to run a job on?
# Anwser
Set the following two environment variables:
export NVIDIA_VISIBLE_DEVICES=$gpu_id
export CUDA_VISIBLE_DEVICES=0
If you want GPU load-balancing, make gpu_id random at each guest system start.
# Test case
from __future__ import print_function
import os
import torch
#os.environ["CUDA_DEVICE_ORDER"] ="3"
#os.environ["CUDA_VISIBLE_DEVICES"] = "3"
gpu_id = torch.cuda.current_device()
print("gpu id: " + str(gpu_id))
print("gpu count: " + str(torch.cuda.device_count()))
print("gpu device: " + str(torch.cuda.device(gpu_id)))
print("gpu name: " + str(torch.cuda.get_device_name(gpu_id)))
print("gpu available: " + str(torch.cuda.is_available()))
print("pytorch test output:")
x = torch.rand(5, 3)
print(x)
print("cuda balance test:")
for i in range(10000):
    x = torch.rand(10000,10000).cuda()
    y = torch.rand(10000,10000).cuda()
    m = x * y
```

###### Using GPU from a docker container

``` shell
# Find your nvidia devices
ls -la /dev | grep nvidia
crw-rw-rw-  1 root root    195,   0 Oct 25 19:37 nvidia0 
crw-rw-rw-  1 root root    195, 255 Oct 25 19:37 nvidiactl
crw-rw-rw-  1 root root    251,   0 Oct 25 19:37 nvidia-uvm
# Run Docker container with nvidia driver pre-installed
 $ sudo docker run -ti --device /dev/nvidia0:/dev/nvidia0 --device /dev/nvidiactl:/dev/nvidiactl --device /dev/nvidia-uvm:/dev/nvidia-uvm tleyden5iwx/ubuntu-cuda /bin/bash
# Verify CUDA is correctly installed
$ cd /opt/nvidia_installers
$ ./cuda-samples-linux-6.5.14-18745345.run -noprompt -cudaprefix=/usr/local/cuda-6.5/
$ cd /usr/local/cuda/samples/1_Utilities/deviceQuery
$ make
$ ./deviceQuery   
# If everything worked, you should see the following output:
deviceQuery, CUDA Driver = CUDART, CUDA Driver Version = 6.5, CUDA Runtime Version = 6.5, NumDevs =    1, Device0 = GRID K520
Result = PASS
```

###### New version GPU container

``` shell
Writing an updated answer since most of the already present answers are obsolete as of now.
Versions earlier than Docker 19.03 used to require nvidia-docker2 and the --runtime=nvidia flag.
Since Docker 19.03, you need to install nvidia-container-toolkit package and then use the --gpus all flag.
So, here are the basics,
Package Installation
Install the nvidia-container-toolkit package as per official documentation at Github.
For Redhat based OSes, execute the following set of commands:
$ distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
$ curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.repo | sudo tee /etc/yum.repos.d/nvidia-docker.repo
$ sudo yum install -y nvidia-container-toolkit
$ sudo systemctl restart docker
For Debian based OSes, execute the following set of commands:
# Add the package repositories
$ distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
$ curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key add -
$ curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | sudo tee /etc/apt/sources.list.d/nvidia-docker.list
$ sudo apt-get update && sudo apt-get install -y nvidia-container-toolkit
$ sudo systemctl restart docker
Running the docker with GPU support
docker run --name my_all_gpu_container --gpus all -t nvidia/cuda
Please note, the flag --gpus all is used to assign all available gpus to the docker container.
To assign specific gpu to the docker container (in case of multiple GPUs available in your machine)
docker run --name my_first_gpu_container --gpus device=0 nvidia/cuda
Or
docker run --name my_first_gpu_container --gpus '"device=0"' nvidia/cuda
```

sudo fuser -v /dev/nvidia*
