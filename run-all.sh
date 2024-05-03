#!/bin/bash

# Build CPU version of MaBoSS
make -C repos/MaBoSS/engine/src clean
make -C repos/MaBoSS/engine/src MAXNODES=1024 -j `nproc`
mkdir -p build/MaBoSS-CPU
cp repos/MaBoSS/engine/src/MaBoSS_1024n build/MaBoSS-CPU/MaBoSS_1024n

# Build MPI version of MaBoSS
make -C repos/MaBoSS/engine/src clean
make -C repos/MaBoSS/engine/src MAXNODES=1024 MPI_COMPAT=1 CXX=mpic++ -j `nproc`
mkdir -p build/MaBoSS-MPI
cp repos/MaBoSS/engine/src/MaBoSS_1024n build/MaBoSS-MPI/MaBoSS_1024n


echo Creating synthetic data
./make-data.sh

echo Running MPI version of MaBoSS on synthetic data
./benchmark/run-synth-mpi.sh
