# Cython wrapper for the LWAN HTTP server

This project is a proof of concept which aims at making an efficient multi-threaded Python server. [LWAN](https://lwan.ws/), written in C, is running under the hood. [Cython](http://cython.org/) is used to wrap it into a Python module.


## Usage

### Prerequisites

LWAN must be installed on your machine as a library. To do so, you can either follow [the instructions](https://github.com/lpereira/lwan#build-commands) from the LWAN repository or run `install_lwan.sh` if you are feeling lazy. In any case, make sure to have the required dependencies installed before.

Then, install Cython using pip:

```shell
pip3 install cython
```

### Compile and run

A simple Makefile automates the building and running part:

```shell
make
make run
```

Your server should be listening on `0.0.0.0:8080`.

## Golang

A Go HTTP server is also provided for comparison. It uses the standard "net/http" package. To run it:

```shell
go run golang/server.go
```

