#! /bin/bash

PROJECT=$1

export TERM=xterm
set -xe
if [ ! -d utils.old ]; then
        mv -n utils utils.old
fi
rm -rf utils
cp -R /pintos_utils utils

if [ ! -d tests.old ]; then
        mv -n tests tests.old
fi
rm -rf tests
cp -R /pintos_tests tests

sed -i 's/\/pintos\/userprog\/build\/loader.bin/\/pintos\/'$PROJECT'\/build\/loader.bin/' /pintos/utils/Pintos.pm
sed -i 's/\/pintos\/userprog\/build\/kernel.bin/\/pintos\/'$PROJECT'\/build\/kernel.bin/' /pintos/utils/pintos
sed -i 's/#define\s*LOGGING_ENABLE\s*[0-9]*/#define LOGGING_ENABLE 0/' /pintos/lib/log.h

# Clean Code
sed -i 's/while\s*(\s*1\s*)\s*{[^}]*}/printf("Removed while(1){} in process.c");"/' /pintos/userprog/process.c
sed -i 's/while\s*(\s*true\s*)\s*{[^}]*}/printf("Removed while(true){} in process.c");/' /pintos/userprog/process.c
sed -i 's/while\s*(\s*1\s*)\s*;/printf("Removed while(1); in process.c");/' /pintos/userprog/process.c
sed -i 's/while\s*(\s*true\s*)\s*;/printf("Removed while(true); in process.c");/' /pintos/userprog/process.c

echo $PROJECT > make_check_module

chmod -R 777 .
