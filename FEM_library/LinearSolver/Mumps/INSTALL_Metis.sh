#!/bin/bash

# INSTALL METIS

rootPath=$PWD

rm -rf Metis

mkdir -p Metis

cd Metis

wget https://ftp.mcs.anl.gov/pub/petsc/externalpackages/metis-5.1.0-p3.tar.gz


tar -xvzf metis-5.1.0-p3.tar.gz

mv metis-5.1.0-p3 metis-5.1.0

mkdir -p metis-5.1.0-install

cd metis-5.1.0

make config prefix=$rootPath/Metis/metis-5.1.0-install/

make

make install
