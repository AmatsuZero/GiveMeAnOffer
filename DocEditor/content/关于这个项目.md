---
title: "关于这个项目"
date: 2019-07-02T10:12:04+08:00
draft: true
---

## How to Build It on Linux

如果你打算根据官网去编译，那么我可以帮你节省这个时间：不可能。Swift官网文档早已过时，我推荐利用 [swiftenv](https://github.com/kylef/swiftenv) 来安装，不过在此之前，你需要安装一些依赖：

```sh
# 以 Ubuntu 为例
sudo apt-get install git cmake ninja-build clang python uuid-dev libicu-dev icu-devtools libbsd-dev libedit-dev libxml2-dev libsqlite3-dev swig libpython-dev libncurses5-dev pkg-config libblocksruntime-dev libcurl4-openssl-dev systemtap-sdt-dev tzdata rsync
```
安装完依赖以后，就可以参考[文档](https://swiftenv.fuller.li/en/latest/installation.html)安装 swiftenv 了：

```sh
# Make the swiftenv folder
mkdir .swiftenv
# Clone the repo
git clone https://github.com/kylef/swiftenv ~/.swiftenv
# Add swiftenv to bash profile #1:
echo 'export SWIFTENV_ROOT="$HOME/.swiftenv"' >> ~/.bashrc
# Add swiftenv to bash profile #2
echo 'export PATH="$SWIFTENV_ROOT/bin:$PATH"' >> ~/.bashrc
# Add swiftenv to bash profile #3
echo 'eval "$(swiftenv init -)"' >> ~/.bashrc

source ~/.bashrc
``` 

###### 注： 你可能听说过 [Linuxbrew](https://docs.brew.sh/Homebrew-on-Linux), 且大部分formula是根 [Homebrew](https://brew.sh/) 相通的。遗憾的是，swiftenv 并不在其中。

接下来的安装就很简单了，我建议直接安装官网提供的产物，本项目目前是更新到了5.0.1版本，我们可以直接这样安装：

```sh
swiften install https://swift.org/builds/swift-5.0.1-release/ubuntu1804/swift-5.0.1-RELEASE/swift-5.0.1-RELEASE-ubuntu18.04.tar.gz
```

## How to Build It on macOS

如果你是在 macOS 上进行的编译，且你觉得 Xcode 的环境比较熟悉，那么可以进一步用 [SPM](https://github.com/apple/swift-package-manager) 生成一个``.xcodeproj``文件来进行管理。

```sh
# 你可以放心生成，.xcodeproj 文件已经添加至 .gitignore 文件中。
swift package generate-xcodeproj
```