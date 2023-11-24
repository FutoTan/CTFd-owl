# CTFd-owl

**Dynamic Check Challenges with docker-compose for CTFd**

Modify from [H1ve/CTFd/plugins/ctfd-owl](https://github.com/D0g3-Lab/H1ve/tree/master/CTFd/plugins/ctfd-owl) and [CTFd-Whale](https://github.com/frankli0324/CTFd-Whale). 

适合的 CTFd 版本： **Version 3.5**.

**注意，3.6 版本的 CTFd 将 markdown 渲染移至后端，导致此版本的 CTFd-owl 无法正常使用。**

## TL;DR

如果你之前没有使用过 CTFd（请保证下面的命令都是以 root 权限执行）：

```shell
# install docker
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh
pip3 install docker-compose

# replace <workdir> to your workdir
cd <workdir>
git clone https://github.com/CTFd/CTFd.git -b 3.5.3
git clone https://github.com/FutoTan/CTFd-owl.git
# replace file in CTFd
cp -rf CTFd-owl/* CTFd
```

修改 frps 端口：

`single-nginx.yml` 或 `single.yml`
```yaml
frps:
...
    ports:
      - 20000-20099:20000-20099
...
```

构建 CTFd 镜像：

```shell
# if you want to use nginx
docker-compose -f CTFd/single-nginx.yml up -d
# or no nginx
docker-compose -f CTFd/single.yml up -d
# wait till the containers are ready
```

## Configuration

### Docker Settings

|Options|Content|
|:-:|:-:|
|**Docker Flag Prefix**|Flag前缀|
|**Docker APIs URL**|API名称（默认为`unix://var/run/docker.sock`）|
|**Max Container Count**|最大容器数量（默认无限制）|
|**Docker Container Timeout**|容器最长运行时间（达到时间后会自动摧毁）|
|**Max Renewal Time**|最大容器延长次数（超过次数将无法延长）|

### FRP Settings

|Options|Content|
|:-:|:-:|
|**FRP Http Domain Suffix**|FRP域名前缀（如开启动态域名转发必填）|
|**FRP Direct IP Address**|frp服务器IP|
|**FRP Direct Minimum Port**|最小端口（保持和`docker-compose`中`frps`对外映射的端口段最小一致）|
|**FRP Direct Maximum Port**|最大端口（与上同理）|
|**FRP config template**|frpc 热重载配置头模版(如不会自定义，尽量按照默认配置)|

`token` 请随机生成，替换掉`random_this`，并修改`frp/conf/frps.ini`中的`token` 与其一致.

```ini
[common]
token = random_this
server_addr = frps
server_port = 80
admin_addr = 10.1.0.4
admin_port = 7400
```

### Add Challenge

详见[添加题目 - Wiki](https://github.com/BIT-NSC/CTFd-owl/wiki/%E4%B8%80%E4%BA%9B%E5%B8%B8%E8%A7%81%E9%97%AE%E9%A2%98#%E6%B7%BB%E5%8A%A0%E9%A2%98%E7%9B%AE).

## Twins

* [CTFd-Whale](https://github.com/frankli0324/CTFd-Whale) (Support docker-swarm)
