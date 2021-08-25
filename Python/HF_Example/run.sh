#!/bin/bash

if [ $(whoami) == jpmcd ]; then
  GROUP_DIR="fastai"
else
  GROUP_DIR="fastai_shared"
fi

# Make Hugging Face cache folder on drive
HF_LOCAL_DIR="/state/partition1/user/$(whoami)/cache/huggingface"
mkdir -p $HF_LOCAL_DIR
# HF folder in shared file system
HF_USER_DIR="/home/gridsan/$(whoami)/.cache/huggingface"
export HF_HOME="${HF_LOCAL_DIR}"

HF_MODEL_NAME="bert-base-uncased"  # default "distilbert-base-uncased"
GLUE_TASK="sst2"  # default "sst2"
BATCH_SIZE=8
LEARNING_RATE="2e-5"
WEIGHT_DECAY="0.01"
NUM_EPOCHS=5

# python load_datasets.py
python load_model.py --model ${HF_MODEL_NAME}
rsync -a --ignore-existing ${HF_LOCAL_DIR}/ $HF_USER_DIR
for i in `seq 1 1`;
do
    sbatch --output="/home/gridsan/groups/${GROUP_DIR}/$(whoami)/fastai/ground-truth-logs/slurm_logs/%j.log" \
        batch_bert_v0.sh ${HF_MODEL_NAME} \
        ${GLUE_TASK} \
        ${BATCH_SIZE} \
        ${LEARNING_RATE} \
        ${WEIGHT_DECAY} \
        ${NUM_EPOCHS}
done

# if [[ $(hostname) =~ login-[1-9] ]]; then
#     python load_datasets.py
#     python load_model.py --model ${HF_MODEL_NAME}
#     rsync -a --ignore-existing ${HF_LOCAL_DIR}/ $HF_USER_DIR
# else
#     rsync -a --ignore-existing ${HF_USER_DIR}/ $HF_LOCAL_DIR
#     export TRANSFORMERS_OFFLINE=1
#     export HF_DATASETS_OFFLINE=1
#     python glue_finetune.py --config default.json
# fi
