## Blockchain Private Network Deploy Demo
[中文版](README-cn.md)

OS Env
```shell
~$ uname -a
Linux deploydemo 4.15.0-1025-gcp #26~16.04.1-Ubuntu SMP Wed Nov 21 10:13:20 UTC 2018 x86_64 x86_64 x86_64 GNU/Linux
```
Go and Geth Version
```shell
~$ geth version
Geth
Version: 1.8.12-stable
Git Commit: 37685930d953bcbe023f9bc65b135a8d8b8f1488
Architecture: amd64
Protocol Versions: [63 62]
Network Id: 1
Go Version: go1.10.3
```

1. install Golang
```shell
~$ wget https://dl.google.com/go/go1.10.3.linux-amd64.tar.gz
~$ sudo tar -C /usr/local -xzf go1.10.3.linux-amd64.tar.gz
~$ export PATH=$PATH:/usr/local/go/bin
```
2. install Geth client
```shell
~$ sudo add-apt-repository -y ppa:ethereum/ethereum
~$ sudo apt-get update
~$ sudo apt-get install ethereum
# Test
```
3. create account
```shell
# create data dir
~$ mkdir privateNet
~$ cd privateNet
# create account and specify a directory for storing chain data
~$ geth --datadir dataDir account new
Passphrase:
Repeat passphrase:
Address: {35891a52b96846f9c304dd6bc65eefdc795ed861}
# take note this account address for future usage
# echo password to file
~$ echo kaiyaxiong123 > dataDir/passwd
```
4. load genesis and config dump file
```shell
# load genesis file (jnulibtop.json)
~$ wget https://cdn.jsdelivr.net/gh/kaiya/deploydemo@master/jnulibtop.json

# load config dump file (config.toml)
~$ wget https://cdn.jsdelivr.net/gh/kaiya/deploydemo@master/config.toml
```
5. modify config file
```shell
# change dataset dir to your home directory
DatasetDir = "/home/xiongkaiya/.ethash"
# change HTTPPort to any port you want...
HTTPPort = 3778
ListenAddr = ":30300"
# !important change DataDir to your directory which you specify in step 3.
DataDir = "dataDir"
```
6. init network
```shell
~$ geth --datadir dataDir init jnulibtop.json
```
7. get node info
```shell
# start geth and attach to console
~$ geth --config config.toml console
# get node info in geth console 
> admin.nodeInfo.enode
"enode://0db203c41c62f7cd930589aace87fece451479896d7b65e2c1148793b5679cd7f2180d205512676a550772614377a53e879d1bd643cf48d835bb7fcc0db0ac15@35.220.189.212:30300"
# take note the enode url
```

8. add peer
```shell
# add other peers in geth console
> admin.addPeer("peer's enode url")
# !attention, the ip addr in your peer's enode url must could be accessed by your machine.
# list peers
> admin.peers
[{
    caps: ["eth/63"],
    id: "0db203c41c62f7cd930589aace87fece451479896d7b65e2c1148793b5679cd7f2180d205512676a550772614377a53e879d1bd643cf48d835bb7fcc0db0ac15",
    name: "Geth/v1.8.20-stable-24d727b6/linux-amd64/go1.10.4",
    network: {
      inbound: false,
      localAddress: "202.116.174.1:47716",
      remoteAddress: "35.220.189.212:30300",
      static: true,
      trusted: false
    },
    protocols: {
      eth: {
        difficulty: 181377,
        head: "0xef06264fa715a2168c4e3f6b8f0dc7e090d4becf807e83461fd64e04f62d7d79",
        version: 63
      }
    }
}]
```
9. run geth
create start.sh file
```shell
#!/bin/bash
geth --config config.toml --unlock 0x${account_address} --password ./dataDir/passwd --targetgaslimit '9000000' --mine
```
run geth with nohup
```shell
nohup bash start.sh > run.log 2>&1 &
```
![Syncing block](https://lib.azfs.com.cn/20190109154704533549707.png)
You can check log  via tail command
```shell
tail -f run.log
```
