#Elasticsearch-tester

由Vargant及Chef-Solo建構而成的Elasticsearch測試環境，純供學習及研究之用。

##安裝

**注意！在執行本測試環境前，請先安裝最新版本的Vargant。**

**詳細教學請見：**

**[Vagrant 安裝與建構] (http://drupaltaiwan.org/forum/20141125/11378)**

1.下載Ubuntu 14.04 64位元的Vagrant box檔案：

https://github.com/kraksoft/vagrant-box-ubuntu/releases/download/14.04/ubuntu-14.04-amd64.box

2.下載完成後，匯入該Vagrant box檔案：

```bash
$ vagrant box add base ubuntu-14.04-amd64.box
```

##用法
在sandbox/dev目錄下，輸入以下指令啟動虛擬機：

```bash
$ vagrant up
```

關閉虛擬機則是：

```bash
$ vagrant halt
```

進入虛擬機：

```bash
$ vagrant ssh
```
