#! /bin/bash

PROJECT=$1

make clean
cd $PROJECT
make -j
make check

make grade > grade.txt
cat grade.txt

GRADE=$(cat grade.txt | grep "TOTAL TESTING SCORE" | cut -f4 -d' ')
echo "Grade: $GRADE"
