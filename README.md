# CVHD的安装
## 准备

0.假设电脑已经安装openmpi和相关的编译器 

1.下载解压lammps 
   
```
wget http://lammps.sandia.gov/tars/lammps-stable.tar.gz
tar -xvf lammps-stable.tar.gz   
```
2.下载colvars_cvhd
```
wget https://sites.google.com/site/kristofbal/colvars-cvhd.tar.gz

or

链接：https://pan.baidu.com/s/1y1zgv4iCvIEnV0mzNzXu9w 
提取码：k8me 
```

## 安装

1.阅读colvars_cvhd的readme.txt,将lib/colvars和USER-COLVARS文件夹替换lammps下的lib/colvars和src/USER-COLVARS，同时拷贝fix_timeboost.cpp  fix_timeboost.h 到lammps的src文件下。
   ```
   cp -r lib/colvars ~/lammps-7Mar19/lib/
   cp -r USER-COLVARS ~/lammps-7Mar19/src/
   cp fix_timeboost.cpp fix_timeboost.h ~/lammps-7Mar19/src/
   ```
2.安装user-colvars 和需要用到的包（如user-reaxc）
```
cd lammps-7Mar19/src
make yes-user-colvars
make yes-user-reaxc
cd ../lib/colvars
make -f Makefile.g++
cd ../../src
make mpi #编译并行版本openmpi
```
设置环境变量
```
echo 'export PATH=$PATH:'$(pwd)>>$HOME/.bashrc
source $HOME/.bashrc
```
## 运行
1.查看安装的包是否成功
```
lmp_mpi -h
```
下载例子，跑一个正十二烷的裂解，需要安装user-reaxc包
```
链接：https://pan.baidu.com/s/1LLZRbEIPU7ILbi6J71yr_Q 
提取码：07qz 

mpirun -np 8 lmp_mpi -in in.ch
```
2.查看log等输出文件就可以知道自己的cvhd有没有安装成功。
