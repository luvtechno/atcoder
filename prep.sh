#!/bin/bash
set -ux

git co -b $DIR
mkdir $DIR
cd $DIR
for problem in c d e f; do
  mkdir ${problem}; cd ${problem}; touch main.rb 1.txt 2.txt 3.txt; cd ..
done
