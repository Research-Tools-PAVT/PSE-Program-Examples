#!/usr/bin/bash

rm -rf $1/inputs/*
rm -rf $1/outputs/*
rm -rf $1/foralls/*

rm -rf $1/pathprobs.txt
rm -rf $1/results.txt

python3 $1/genCandidateM.py
python3 $1/candidates.py  
python3 $1/executeCV.py foralls