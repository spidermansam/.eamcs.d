####  运行配置环境说明

```shell
# python 虚拟环境
yum install ipython

# 安装 py自动补全库
pip install  jedi elpy  rope flake8 importmagic autopep8 yapf

```





Go emacs 配置文件

```shell
# 自动格式化代码，自动删除 添加 imports
go get -u golang.org/x/tools/cmd/goimports

# go的自动补全库
go get -u github.com/nsf/gocode

# 开启联想 默认false
gocode set propose-builtins true

# 开启 源码查看
go get github.com/rogpeppe/godef

M-x package-install RET go-autocomplete

```

