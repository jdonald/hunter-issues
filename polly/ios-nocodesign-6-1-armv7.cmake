# Copyright (c) 2014-2016, Ruslan Baratov
# All rights reserved.
cmake_minimum_required(VERSION 3.1)
set(IOS_DEPLOYMENT_SDK_VERSION "6.1")

if(DEFINED POLLY_IOS_NOCODESIGN_6_1_CMAKE_)
  return()
else()
  set(POLLY_IOS_NOCODESIGN_6_1_CMAKE_ 1)
endif()


include("${CMAKE_CURRENT_LIST_DIR}/utilities/polly_module_path.cmake")
include(polly_clear_environment_variables)
include(polly_init)
include("${CMAKE_CURRENT_LIST_DIR}/os/iphone-default-sdk.cmake") # -> IOS_SDK_VERSION

set(POLLY_XCODE_COMPILER "clang")
polly_init(
  "iOS ${IOS_SDK_VERSION} Universal (iphoneos + iphonesimulator) / \
${POLLY_XCODE_COMPILER} / \
c++14 support"
  "Xcode"
)

include(polly_common)
include(polly_fatal_error)

# Fix try_compile
include(polly_ios_bundle_identifier)
set(CMAKE_MACOSX_BUNDLE YES)

# Verify XCODE_XCCONFIG_FILE
set(
  _polly_xcode_xcconfig_file_path
    "${CMAKE_CURRENT_LIST_DIR}/scripts/NoCodeSign.xcconfig"
)
if(NOT EXISTS "$ENV{XCODE_XCCONFIG_FILE}")
  polly_fatal_error(
    "Path specified by XCODE_XCCONFIG_FILE environment variable not found"
    "($ENV{XCODE_XCCONFIG_FILE})"
    "Use this command to set: "
    "    export XCODE_XCCONFIG_FILE=${_polly_xcode_xcconfig_file_path}"
  )
else()
  string(
    COMPARE
    NOTEQUAL
    "$ENV{XCODE_XCCONFIG_FILE}"
    "${_polly_xcode_xcconfig_file_path}"
    _polly_wrong_xcconfig_path
  )
  if(_polly_wrong_xcconfig_path)
    polly_fatal_error(
        "Unexpected XCODE_XCCONFIG_FILE value: "
        "    $ENV{XCODE_XCCONFIG_FILE}"
        "expected: "
        "    ${_polly_xcode_xcconfig_file_path}"
    )
  endif()
endif()

set(IPHONEOS_ARCHS armv7)
set(IPHONESIMULATOR_ARCHS "")

set(CMAKE_XCODE_ATTRIBUTE_CLANG_CXX_LIBRARY "libc++")

include("${CMAKE_CURRENT_LIST_DIR}/compiler/xcode.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/os/iphone.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/flags/cxx11.cmake")

include("${CMAKE_CURRENT_LIST_DIR}/library/std/libcxx.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/flags/fpic.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/flags/function-sections.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/flags/data-sections.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/flags/hidden.cmake")
