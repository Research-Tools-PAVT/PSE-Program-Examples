# KLEE

Install `klee-ulibc`, `klee-deps` & `z3` binaries.
After installing `prerequisites`, this follows. Run from the `$HOME` directory.

- [Official Install Guide](https://github.com/klee/klee.github.io/blob/master/build-llvm9.md)
- Make sure `CMAKE`, `cmake`, `python3`, `wllvm`, `lit`, `dot/xdot` and `clang-10` are installed and in the `$PATH`.

```bash

# ASSUMING KLEE IS CLONED IN $HOME DIR.
mkdir libcxx-build
cd $HOME/klee
LLVM_VERSION=10 BASE=$HOME/libcxx-build REQUIRES_RTTI=1 DISABLE_ASSERTIONS=1 ENABLE_DEBUG=0 ENABLE_OPTIMIZED=1 ./scripts/build/build.sh libcxx

mkdir klee-build && cd klee-build

# Final CMAKE command for building KLEE.
cmake \
  -DENABLE_POSIX_RUNTIME=ON \
  -DENABLE_KLEE_UCLIBC=ON \
  -DKLEE_UCLIBC_PATH=$HOME/klee-uclibc \
  -DLLVM_CONFIG_BINARY=/usr/bin/llvm-config-10 \
  -DLLVMCC=/usr/bin/clang-10 \
  -DLLVMCXX=/usr/bin/clang++-10 \
  -DENABLE_KLEE_LIBCXX=ON \
  -DCMAKE_BUILD_TYPE=RelWithDebInfo \
  -DENABLE_KLEE_EH_CXX=ON	\
  -DENABLE_TCMALLOC=ON \
  -DKLEE_ENABLE_TIMESTAMP=ON \
  -DKLEE_RUNTIME_BUILD_TYPE=Release+Debug+Asserts \
  -DKLEE_LIBCXX_DIR=$HOME/libcxx-build/libc++-install-100/ \
  -DKLEE_LIBCXXABI_SRC_DIR=$HOME/libcxx-build/llvm-100/libcxxabi/ \
  -DKLEE_LIBCXX_INCLUDE_DIR=$HOME/libcxx-build/libc++-install-100/include/c++/v1/ \
  -DENABLE_KLEE_EH_CXX=ON \
  -DENABLE_UNIT_TESTS=ON \
  -DGTEST_SRC_DIR=$HOME/googletest-release-1.7.0/ \
  -DENABLE_SOLVER_Z3=ON  $HOME/klee

# Build KLEE.
make -j8

# Install KLEE.
sudo make -j8 install
```
