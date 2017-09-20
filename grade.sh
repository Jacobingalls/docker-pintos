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

sed -i 's/\/pintos\/threads\/build\/loader.bin/\/pintos\/'$PROJECT'\/build\/loader.bin/' /pintos/utils/Pintos.pm
sed -i 's/\/pintos\/threads\/build\/kernel.bin/\/pintos\/'$PROJECT'\/build\/kernel.bin/' /pintos/utils/pintos

make clean
echo $PROJECT > make_check_module

cd $PROJECT
make -j

guac

make grade > grade.txt
cat grade.txt

GRADE=$(cat grade.txt | grep "TOTAL TESTING SCORE" | cut -f4 -d' ')
echo "Grade: $GRADE"
