#!/bin/bash
# Closed 53개 B·C (CPU one-vs-one 24 jobs, 최저 우선순위) → Open-world 이진 (GPU 3번)
cd /home2/fedit-home/website-fingerprinting
L=results/svm/extra_credit/logs
NB=extra_credit/MLB_SVM_extra.ipynb
nice -n 19 env EC_OVO_JOBS=24 EC_CLOSED_FRAC=0.3 EC_RUN_BINARY=0 .venv/bin/python extra_credit/run_notebook.py $NB $NB extra_credit > $L/closed_53.log 2>&1 || { echo "CLOSED FAILED" >> $L/closed_53.log; exit 1; }
cp $NB $L/MLB_SVM_extra_closed_run.ipynb
nice -n 19 env CUDA_VISIBLE_DEVICES=3 EC_GPU=1 EC_RUN_BINARY=1 EC_BINARY_FRAC=0.3 .venv/bin/python extra_credit/run_notebook.py $NB $NB extra_credit > $L/binary_gpu.log 2>&1 || echo "BINARY FAILED" >> $L/binary_gpu.log
echo FINISHED >> $L/binary_gpu.log
