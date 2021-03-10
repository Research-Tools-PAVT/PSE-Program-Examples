#!/usr/bin/bash

rm -rf estimate_example1/inputs/*
rm -rf estimate_example1/outputs/*
rm -rf estimate_example1/foralls/*

rm -rf estimate_example1/pathprobs.txt
rm -rf estimate_example1/results.txt

python3 estimate_example1/genCandidateM.py
python3 estimate_example1/candidates.py  
python3 estimate_example1/executeCV.py foralls