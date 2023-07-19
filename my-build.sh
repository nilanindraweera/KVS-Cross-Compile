#!/bin/bash

function run_cmake()
{
    cmake .. -DBUILD_TEST=TRUE -DBUILD_OPENSSL_PLATFORM=linux-generic32 -DBUILD_LOG4CPLUS_HOST=arm-linux -DCMAKE_INSTALL_PREFIX=.
}

function modify_env_for_openssl()
{
    echo "MYLOG::modifying environment variables CXX, CC, AR, and RANLIB"
    export CC=gcc
    export CXX=g++
    export AR=ar
    export RANLIB=ranlib
}

mkdir -p amazon-kinesis-video-streams-producer-sdk-cpp/build && cd amazon-kinesis-video-streams-producer-sdk-cpp/build
run_cmake

function revert_env_to_default()
{
    echo "MYLOG::reverting back to initial value to environment CXX, CC, AR, and RANLIB"
    export CXX="arm-linux-gnueabihf-g++ -mthumb -mfpu=neon -mfloat-abi=hard -mcpu=cortex-a9 -fstack-protector-strong -D_FORTIFY_SOURCE=2 -Wformat -Wformat-security -Werror=format-security --sysroot=/opt/axis/acapsdk/sysroots/armv7hf"
    export CC="arm-linux-gnueabihf-gcc -mthumb -mfpu=neon -mfloat-abi=hard -mcpu=cortex-a9 -fstack-protector-strong -D_FORTIFY_SOURCE=2 -Wformat -Wformat-security -Werror=format-security --sysroot=/opt/axis/acapsdk/sysroots/armv7hf"
}

ret=$?
if [ $ret -ne 0 ]; 
then
    modify_env_for_openssl
    run_cmake
fi

ret=$?
if [ $ret -ne 0 ]; 
then
    revert_env_to_default
    run_cmake
fi

make

ret=$?
if [ $ret -ne 0 ]; 
then
    echo "MYLOG::adding manual lib-curl and directory"
    tempary_open_src_install_prefix=${OPEN_SRC_INSTALL_PREFIX}
    export OPEN_SRC_INSTALL_PREFIX="/workspaces/kvs-build/dependency-libs/"
    make
fi
