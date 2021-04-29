#!/usr/bin/bash

rm -rf $1/inputs/*
rm -rf $1/outputs/*
rm -rf $1/foralls/*

rm -rf $1/pathprobs.txt
rm -rf $1/results.txt

python3 $1/candidates.py  
python3 $1/executeCV.py foralls

# python3 estimate_example5/candidates.py 15
# python3 estimate_example5/executeCV.py inputs
# cd estimate_example5/outputs/
# cat *txt | sort 
# cd ../../
# python3 postprocess/z3write.py example5_processed/example5_paths.json > estimate_example5/paths.py