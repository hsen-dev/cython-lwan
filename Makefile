.PHONY: all cython_module run

all: cython_module

cython_module:
	python3 setup.py build_ext --inplace

run: cython_module
	export LD_LIBRARY_PATH=/usr/local/lib; python3 -c "import lwan; lwan.run()"
