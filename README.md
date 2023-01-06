# CVHD INSTALL
## Prepare

0.Suppose your server had install openmpi 4.1.0 and corresponding complier

1. Download and unzip lammps,suggest use lammps-7Aug19
   
```
wget http://lammps.sandia.gov/tars/lammps-stable.tar.gz
tar -xvf lammps-stable.tar.gz   
```

2. Download colvars_cvhd.tar.gz
```
wget https://sites.google.com/site/kristofbal/colvars-cvhd.tar.gz

or
download from the repo.
```

## INSTALL

1.Read the readme.txt carefully
   ```
   cp -r lib/colvars ~/lammps-7Mar19/lib/
   cp -r USER-COLVARS ~/lammps-7Mar19/src/
   cp fix_timeboost.cpp fix_timeboost.h ~/lammps-7Mar19/src/
   ```
2. Install user-colvars and other packages you need.
```
cd lammps-7Mar19/src
make yes-user-colvars
make yes-user-reaxc
cd ../lib/colvars
make -f Makefile.g++
cd ../../src
make mpi # compile with openmpi
```
sed environment variable
```
echo 'export PATH=$PATH:'$(pwd)>>$HOME/.bashrc
source $HOME/.bashrc
```
## RUN 
1. Check the packages install successfully
```
lmp_mpi -h
```
Download the dodecane example and run the dodecane combustion

```

mpirun -np 8 lmp_mpi -in in.ch
```
2.Check the log file and analyse result to make sure your simulation is correct
