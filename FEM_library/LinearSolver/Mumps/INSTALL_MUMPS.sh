#!/bin/bash

# INSTALL MUMPS

rm -rf MUMPS

mkdir -p MUMPS

cd MUMPS

wget https://ftp.mcs.anl.gov/pub/petsc/externalpackages/MUMPS_5.0.1-p1.tar.gz

tar -xzf MUMPS_5.0.1-p1.tar.gz 
mv MUMPS_5.0.1-p1 MUMPS_5.0.1
cd MUMPS_5.0.1

cp ../../Makefile_MUMPS.inc Makefile.inc

cp ../../make_MatlabMUMPS.inc MATLAB/make.inc

make clean

export rootPath=$(cd ../../; pwd)

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/scratch/Libraries/Test_MUMPS_Installation/OpenBlas/install/lib/

make all

cd examples

make all

make d

./dsimpletest < input_simpletest_real
./zsimpletest < input_simpletest_cmplx

cd ../MATLAB

export mexPath=$(which mex)

echo "The path is" $mexPath

make clean

make

cp dmumps.m dmumpsmex.m* initmumps.m mumps_help.m ../../../../
