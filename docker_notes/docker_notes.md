# Docker notes
##### Install docker

``` shell
sudo apt-get update
sudo apt-get remove docker docker-engine docker.io
sudo apt install docker.io
sudo systemctl start docker
sudo systemctl enable docker
sudo service docker status
```
###### docker服务重启

``` shell
systemctl 方式
守护进程重启
sudo systemctl daemon-reload
重启docker服务
sudo systemctl restart docker
关闭docker
sudo systemctl stop docker
sudo systemctl status docker

service 方式
重启docker服务
sudo service docker restart
关闭docker
sudo service docker stop
docker status
sudo service docker status
dockerd --max-concurrent-downloads 1
```
###### Using NVIDIA GPU within Docker Containers

``` shell
# NVIDIA Persistence Daemon
vim /usr/lib/systemd/system/nvidia-persistenced.service
[Unit]
Description=NVIDIA Persistence Daemon
Wants=syslog.target

[Service]
Type=forking
PIDFile=/var/run/nvidia-persistenced/nvidia-persistenced.pid
Restart=always
ExecStart=/usr/bin/nvidia-persistenced --verbose
ExecStopPost=/bin/rm -rf /var/run/nvidia-persistenced

[Install]
WantedBy=multi-user.target
sudo systemctl enable nvidia-persistenced
vim /lib/udev/rules.d/40-vm-hotadd.rules
# SUBSYSTEM=="memory", ACTION=="add", DEVPATH=="/devices/system/memory/memory[0-9]*", TEST=="state", ATTR{state}="online"	//comment the memory subsystem rule
# test CUDA installation by compiling some of the provided examples
cuda-install-samples-9.1.sh ~
cd ~/NVIDIA_CUDA-9.1_Samples
make
./bin/x86_64/linux/release/deviceQuery | tail -n 1
# Having Result = PASS shows that my CUDA installation is fully operational

# Installing NVIDIA Docker
curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key add -
curl -s -L https://nvidia.github.io/nvidia-docker/ubuntu16.04/amd64/nvidia-docker.list | \
    sudo tee /etc/apt/sources.list.d/nvidia-docker.list
sudo apt-get update
# Before installing nvidia-docker2 utility, I need to ensure that I use docker-ce
# remove all previous Docker versions
sudo apt-get remove docker docker-engine docker.io
# add Docker official GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
# Add Docker repository (for Ubuntu Xenial)
sudo add-apt-repository \
    "deb [arch=amd64] https://download.docker.com/linux/ubuntu xenial stable"
sudo apt-get update
sudo apt install docker-ce
# Now that I have the last version of Docker, I can install nvidia-docker
# Install nvidia-docker2 and reload the Docker daemon configuration
sudo apt-get install -y nvidia-docker2
sudo pkill -SIGHUP dockerd
# Let's ensure everything work as expected, using a Docker image called nvidia-smi, which is a NVidia utility allowing to monitor (and manage) GPUs:
docker run --runtime=nvidia --rm nvidia/cuda nvidia-smi
# Benchmarking Between GPU and CPU
vim test.py
import sys
import numpy as np
import tensorflow as tf
from datetime import datetime

device_name = sys.argv[1]  # Choose device from cmd line. Options: gpu or cpu
shape = (int(sys.argv[2]), int(sys.argv[2]))
if device_name == "gpu":
    device_name = "/gpu:0"
else:
    device_name = "/cpu:0"

with tf.device(device_name):
    random_matrix = tf.random_uniform(shape=shape, minval=0, maxval=1)
    dot_operation = tf.matmul(random_matrix, tf.transpose(random_matrix))
    sum_operation = tf.reduce_sum(dot_operation)

startTime = datetime.now()
with tf.Session(config=tf.ConfigProto(log_device_placement=True)) as session:
        result = session.run(sum_operation)
        print(result)

# It can be hard to see the results on the terminal with lots of output -- add some newlines to improve readability.
print("\n" * 5)
print("Shape:", shape, "Device:", device_name)
print("Time taken:", str(datetime.now() - startTime))
# This script takes two arguments: cpu or gpu, and a matrix size. It performs some matrix operations, and returns the time spent on the task.
# I now want to call this script using Docker and the nvidia runtime. I settled on the tensorflow/tensorflow:latest-gpu Docker image, which provides a fully working TensorFlow environment:
docker run \
    --runtime=nvidia \
    --rm \
    -ti \
    -v "${PWD}:/app" \
    gcr.io/tensorflow/tensorflow:latest-gpu \
    python /app/benchmark.py cpu 10000
# Executing this command twice gave me the following results:
With GPU: 8.36 seconds
With CPU: 25.83 seconds
```

###### Docker accelareting

``` shell
vim /etc/docker/daemon.json
"registry-mirrors": ["https://docker.mirrors.ustc.edu.cn/"]
```

###### Docker http proxy
``` shell
 # First, create a systemd drop-in directory for the Docker service:
mkdir /etc/systemd/system/docker.service.d
vim /etc/systemd/system/docker.service.d/http-proxy.conf
[Service]
Environment="HTTP_PROXY=http://xx.xxx.xx.xx:xxxx"
Environment="HTTPS_PROXY=http://xx.xxx.xx.xx:xxx" 
# Flush changes:
sudo systemctl daemon-reload
# Verify that the configuration has been loaded:
$ sudo systemctl show --property Environment docker
Environment=HTTP_PROXY=http://proxy.example.com:80/
$ sudo systemctl restart docker

# Other methods
sudo HTTP_PROXY=http://192.168.1.1:3128/ docker pull busybox
vim /etc/sysconfig/docker
# Adding the below line helped me to get the Docker daemon working behind a proxy server:
HTTP_PROXY="http://<proxy_host>:<proxy_port>"
HTTPS_PROXY="http://<proxy_host>:<proxy_port>"
```

##### Docker usage

``` shell
docker cp host_file_path <container_id>:/container_path
SRC_PATH does not end with /.
the source directory is copied into this directory
SRC_PATH does end with /.
the content of the source directory is copied into this director

docker start [container_id]
 1 # 搜索镜像
 2 docker search <image> # 在docker index中搜索image
 3 # 下载镜像
 4 docker pull <image>  # 从docker registry server 中下拉image
 5 # 查看镜像 
 6     docker images： # 列出images
 7     docker images -a # 列出所有的images（包含历史）
 8     docker rmi  <image ID>： # 删除一个或多个image
 9 
10 # 使用镜像创建容器
11     docker run -i -t sauloal/ubuntu14.04
12     docker run -i -t sauloal/ubuntu14.04 /bin/bash # 创建一个容器，让其中运行
13     bash 应用，退出后容器关闭
14 # 查看容器
15     docker ps ：列出当前所有正在运行的container
16     docker ps -l ：列出最近一次启动的container
17     docker ps -a ：列出所有的container（包含历史，即运行过的container）
18     docker ps -q ：列出最近一次运行的container ID
19 # 再次启动容器
20     docker start/stop/restart <container> #：开启/停止/重启container
21     docker start [container_id] #：再次运行某个container （包括历史container）
22     docker attach [container_id] #：连接一个正在运行的container实例（即实例须   
23              为start状态，可以多个窗口同时attach 一个container实例）
24     docker start -i <container> #：启动一个container并进入交互模式（相当于先
25          start，在attach）
26     docker run -i -t <image> /bin/bash #：使用image创建container并进入交互模
27              式, login shell是/bin/bash
28     docker run -i -t -p <host_port:contain_port> #：映射 HOST 端口到容器，方便
29           外部访问容器内服务，host_port 可以省略，省略表示把 container_port 映射到
30           一个动态端口。
31     #注：使用start是启动已经创建过得container，使用run则通过image开启一个新的
32           container。
33 
34 # 删除容器
35     docker rm <container...> #：删除一个或多个container
36     docker rm `docker ps -a -q` #：删除所有的container
37     docker ps -a -q | xargs docker rm #：同上, 删除所有的container
3、持久化容器与镜像
3.1 通过容器生成新的镜像
运行中的镜像称为容器。你可以修改容器（比如删除一个文件），但这些修改不会影响到镜像。不过，你使用docker commit 命令可以把一个正在运行的容器变成一个新的镜像。
    docker commit <container> [repo:tag] # 将一个container固化为一个新的image，后面的repo:tag可选。
3.2 持久化容器
export命令用于持久化容器
    docker export <CONTAINER ID> > /tmp/export.tar
3.3 持久化镜像
Save命令用于持久化镜像
        docker save 镜像ID > /tmp/save.tar
3.4 导入持久化container
删除container 2161509ff65e
        docker rm 2161509ff65e
导入export.tar文件
cat /tmp/export.tar | docker import - export:latest
3.5 导入持久化image
删除image daa11948e23d
docker rmi daa11948e23d
导入save.tar文件
docker load < /tmp/save.tar
对image打tag
docker tag daa11948e23d load:tag
3.6 export-import与save-load的区别
导出后再导入(export-import)的镜像会丢失所有的历史，而保存后再加载（save-load）的镜像没有丢失历史和层(layer)。这意味着使用导出后再导入的方式，你将无法回滚到之前的层(layer)，同时，使用保存后再加载的方式持久化整个镜像，就可以做到层回滚。（可以执行docker tag 来回滚之前的层）。
3.7 一些其它命令
1 docker logs $CONTAINER_ID #查看docker实例运行日志，确保正常运行
2     docker inspect $CONTAINER_ID #docker inspect <image|container> 查看image或container的底层信息
3     docker build <path> 寻找path路径下名为的Dockerfile的配置文件，使用此配置生成新的image
4     docker build -t repo[:tag] 同上，可以指定repo和可选的tag
5     docker build - < <dockerfile> 使用指定的dockerfile配置文件，docker以stdin方式获取内容，使用此配置生成新的image
6     docker port <container> <container port> 查看本地哪个端口映射到container的指定端口，其实用docker ps 也可以看到

以守护形式运行容器：
$ docker run -it IMAGE /bin/bash
  Ctrl+P Ctrl+Q
$ docker attach container_name
$ docker run -d image_name [COMMAND][ARG...]
$ docker run --name 3d -d torch_cuda /bin/bash -c "while true; do echo hello world; sleep 1; done"

Port mapping
run [-P][-p]
-p, --publish=[]
1. containerPort
	docker run -p 80 -i -t ubuntu /bin/bash
2. hostPort:containerPort
	docker run -p 8080:80 -i -t ubuntu /bin/bash
3. ip:containerPort
	docker run -p 0.0.0.0:80 -i -t ubuntu /bin/bash
4. ip:hostPort:containerPort
	docker run -p 0.0.0.0:8080:80 -i -t ubuntu /bin/bash
sudo docker run -p 777 --name 3d -d 2d574f367d1f
```

###### How do I transfer a Docker image from one machine to another one without using a repository

``` shell
docker save -o <path for generated tar file> <image name>
# Then copy your image to a new system with regular file transfer tools such as cp, scp or rsync(preferred for big files).
docker load -i <path to image tar file>
```

##### Dockerfile
``` shell

```

###### Summary

``` shell
1. The position of argument in docker cannot change, for example
sudo docker run 3b55548ae91f -it --gpus 3         // Error
docker: Error response from daemon: OCI runtime create failed: container_linux.go:349: starting container process caused "exec: \"-it\": executable file not found in $PATH": unknown.
ERRO[0001] error waiting for container: context canceled 
sudo docker run -it --gpus 3 3b55548ae91f		//Right
2. Starting a GPU enabled container on specific GPUs
docker run --gpus '"device=1,2"' nvidia/cuda:10.0-base nvidia-smi
docker run --gpus '"device=UUID-ABCDEF,1"' nvidia/cuda:10.0-base nvidia-smi
3. You can get a list of all containers bu invoking the docker container ls command with the -a option:
docker container ls -a
If you get an error message similar to the one shown below, it means that the container is running. You’ll need to stop the container before removing it.
Error response from daemon: You cannot remove a running container fc983ebf4771d42a8bd0029df061cb74dc12cb174530b2036987575b83442b47. Stop the container before attempting removal or force remove.
4. To remove all stopped containers use the docker container prune command:
docker container prune
5. If you want to get a list of all non-running (stopped) containers that will be removed with docker container prune, use the following command:
docker container ls -a --filter status=exited --filter status=created 
6. Stop and remove all containers
To stop all running containers use the docker container stop command followed by a the containers IDs:
docker container stop $(docker container ls -aq)
The command docker container ls -aq generates a list of all containers.
docker container rm $(docker container ls -aq)
7. In docker container, you cannot use virtual environment copied from host if you are root
you need add --name argument.
sudo docker start -i --name=mason f3b4d5c78f04

8. Delete containers from specific image
$ sudo docker ps -a | grep 2d574f367d1f | awk '{print $1}'| xargs sudo docker rm
delete image
$ sudo docker images | awk '/^<none>' | awk '{print $3}' | xargs sudo docker rmi
9. For versions older than v17.09.0-ce, docker doesn't support COPY as a user other than root. You need to chown / chmod the file after the COPY command.
Example Dockerfile:
from centos:6
RUN groupadd -r myuser && adduser -r -g myuser myuser
USER myuser
#Install code, configure application, etc...
USER root
COPY run-my-app.sh /usr/local/bin/run-my-app.sh
RUN chown myuser:myuser /usr/local/bin/run-my-app.sh && \
    chmod 744 /usr/local/bin/run-my-app.sh
USER myuser
ENTRYPOINT ["/usr/local/bin/run-my-app.sh"]

For versions v17.09.0-ce and newer, Use the optional flag --chown=<user>:<group> with either the ADD or COPY commands.
For example:
COPY --chown=<user>:<group> <hostPath> <containerPath>

10. Dockerfile COPY command, the hostPath should be the subfolder of the directory, which contains Dockerfile.

#S
Docker build behind proxy:
docker build --build-arg http_proxy=http://10.239.4.80:913 --build-arg https_proxy=http://10.239.4.80:913 .
Docker run behind proxy:
docker run xxxx --env HTTP_PROXY="http://127.0.0.1:3001"

#S 
Install miniconda to specific directory.
$ curl -sSL https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -o /tmp/miniconda.sh
$ bash /tmp/miniconda.sh -bfp /usr/local/
```



###### Question & Answer

``` shell
#Q: Add repository and tag to an image with Docker
#A: docker tag <image ID> <image name>:latest
// example 
sudo docker tag 3b55548ae91f nvidia/cuda:10.1-base
#Q: Docker switch to root
#A: $ sudo passwd root
    $ su root
```



##### Error & Solution

``` shell
# Error
docker: Error response from daemon: OCI runtime create failed: container_linux.go:349: starting container process caused "process_linux.go:449: container init caused \"process_linux.go:432: running prestart hook 0 caused \\\"error running hook: exit status 1, stdout: , stderr: nvidia-container-cli: requirement error: unsatisfied condition: cuda>=10.2, please update your driver to a newer version, or use an earlier cuda container\\\\n\\\"\"": unknown.
ERRO[0000] error waiting for container: context canceled 
# Solution
nvidia-smi show the Driver Version and CUDA Version, download the nvidia/cuda according to that version.

#E
debconf: delaying package configuration, since apt-utils is not installed
debconf: unable to initialize frontend: Dialog
#S
apt-get install -y --no-install-recommends dialog apt-utils
#E
WARNING: apt does not have a stable CLI interface. Use with caution in scripts.
#S
replace apt with apt-get
#E
W: GPG error: https://developer.download.nvidia.cn/compute/machine-learning/repos/ubuntu1804/x86_64  Release: The following signatures were invalid: BADSIG F60F4B3D7FA2AF80 cudatools <cudatools@nvidia.com>
E: The repository 'https://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu1804/x86_64  Release' is not signed.
#S
I think it's a region-specific error, some region doesn't allow access on 'http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64'
The above link will redirect to this link "http://114.80.80.238:8089/ceshi/index.html". The content is in the Chinese language the translated version is:

Tips: The site is temporarily inaccessible

According to the relevant laws and regulations of the Ministry of Industry and Information, because your website has not yet been filed, the website cannot be accessed.

According to the Order No. 33 of the Ministry of Industry and Information Technology of the People's Republic of China: Websites that do not have record numbers cannot be solved
Analysis and opening, otherwise it is necessary to bear the relevant legal responsibility.

Please be sure that all enterprises and institutions must complete the record and open the website. Thank you for your support!

Century Connect Record Consultation Contact Information

Registration Advisory Telephone: 021-36359595

What we could do is to edit on "sudo nano /etc/apt/sources.list.d/cuda.list" file and replace
"http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64" with
"https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64"
--------------
What helped in my case:

    install apt-transport-https
    Setting link from http: to https: in /etc/apt/sources.list.d/cuda.list
    updating apt-key
    check the https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/ page and find the .pub file and update apt-key with that .pub file's content, like this way:

wget -qO - https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/7fa2af80.pub | sudo apt-key add -
#E
W: GPG error: https://developer.download.nvidia.cn/compute/cuda/repos/ubuntu1804/x86_64  Release: The following signatures were invalid: BADSIG F60F4B3D7FA2AF80 cudatools <cudatools@nvidia.com>
E: The repository 'https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64  Release' is not signed.
E: GPG error: https://developer.download.nvidia.cn/compute/machine-learning/repos/ubuntu1804/x86_64  Release: Signed file isn't valid, got 'NODATA' (does the network require authentication?)
#S
RUN rm /etc/apt/sources.list.d/cuda.list
COPY 7fa2af80.pub 7fa2af80.pub
RUN apt-key add 7fa2af80.pub
RUN apt-get clean && \
    cd /var/lib/apt && \
    mv lists lists.old && \
    mkdir -p lists/partial && \
    apt-get clean
#E
Error: retrieving gpg key timed out.
#S
delete apt-add-repository, ppa stuff
set proxy, it's network issue.
#E
virtualenv torch_env --python=python3
Exception:
socket.timeout: The read operation timed out
/usr/lib/python3/dist-packages/virtualenv.py:1086: DeprecationWarning: the imp module is deprecated in favour of importlib; see the module's documentation for alternative uses
  import imp
OSError: Command /home/mason/venvs/torch_env/bin/python3 - setuptools pkg_resources pip wheel failed with error code 2
#S
The version of virtualenv is to old, update newer version.
#E
clearsigned file isn't valid got 'nosplit' (does the network require authentication )
#S
Network issue, config proxy will work.
#E
invalid argument "type=bind,source=/home/mason/Projects," for "--mount" flag: invalid field '' must be a key=value pair
#S
Delete space between mount arguments.
#E
Error response from daemon: Get https://registry-1.docker.io/v2/: proxyconnect tcp: dial tcp 127.
#S
Change Astrill OpenWeb Tunnel option "All app" to "Browers".
#E 
pulling images sometimes gets stuck
#S
vim /etc/docker/daemon.json
{
    "max-concurrent-uploads": 1,
    "max-concurrent-downloads": 1
}
## or use this command
dockerd --max-concurrent-downloads 1       
```

   