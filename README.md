# 411w16

## Description

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
> Copy files
```bash
$ ./benchmarPC.sh [count of iterations]
```
> Transfer files over tcp
```bash
$ ./benchmarkTCP.sh [count of iterations] [host] [port]
```
* Note : you need to launch ther server on another computer using:
```bash
$ bash Network/server.sh [port]
```
> generate graphs
```bash
$ ./createGraph.sh
```
* Note this command executes : with filename the computed data
```python
python3 python.py [filename]
```
> Delete all generated files
```bash
$ ./clean.sh
```

