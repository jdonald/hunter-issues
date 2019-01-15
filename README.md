# hunter-issues
Simple sample project demonstrating Hunter boost flags problem

Usage:

    mkdir -p build-osx-10-7; cd build-osx-10-7
    POLLY_DIR="$(cd ../polly && pwd)"
    XCODE_XCCONFIG_FILE=${POLLY_DIR}"/scripts/NoCodeSign.xcconfig \
      cmake -G Xcode -DCMAKE_TOOLCHAIN_FILE="${POLLY_DIR}"/osx-10-7.cmake ..

or

    mkdir -p build-ios-6-1; cd build-ios-6-1
    POLLY_DIR="$(cd ../polly && pwd)"
    XCODE_XCCONFIG_FILE=${POLLY_DIR}"/scripts/NoCodeSign.xcconfig \
      cmake -G Xcode -DCMAKE_TOOLCHAIN_FILE="${POLLY_DIR}"/ios-nocodesign-6-1-armv7.cmake ..

Both cases not only fail to propagate -stdlib=libc++, but also flags such
as -fvisibility -ffunction-sections and -fdata-sections. It's clear from
the Hunter-generated `boost.user.jam`

Failing to propagate -stdlib manifests as:
```
In file included from ./boost/config.hpp:44:
./boost/config/detail/select_stdlib_config.hpp:18:12: fatal error: 'cstddef' file not found
#  include <cstddef>
```
The fatal error does not happen when targeting OS X 10.8 / iOS 7 or above, because in
those cases clang defaults to `-stdlib=libc++`. Failing to pass the other flags
happens on all targets though.
