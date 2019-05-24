# 411w16

## Description

This projects will aim to generate data for copying and transfering data.  
This project will generate files, and save eecution time when copying these files on the drive and also when transfering them over tcp.  
This project is user-friendly since for every action, all the user has to do is execute the write, explicitly named, script.  


## Requirements

> Python:  
> * matplotlib
> BASH
> * netcat
> * awk

## Guide

> Create files
```bash
$ ./createFiles.sh
```
- - -
> Copy files
```bash
$ ./benchmarPC.sh [count of iterations]
```
- - -
> Transfer files over tcp
```bash
$ ./benchmarkTCP.sh [count of iterations] [host] [port]
```
* Note : you need to launch ther server on another computer using:
```bash
$ bash Network/server.sh [port]
```
- - -
> generate graphs
```bash
$ ./createGraph.sh
```
* Note this command executes : with filename the computed data
```bash
$ python3 python.py [filename]
```
- - -
> Delete all generated files
```bash
$ ./clean.sh
```

