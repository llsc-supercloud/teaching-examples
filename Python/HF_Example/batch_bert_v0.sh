#!/bin/bash
#SBATCH -N 1
#SBATCH --job-name bert_v0
#SBATCH --gres=gpu:volta:2
#SBATCH --tasks-per-node=2
#SBATCH --cpus-per-task=20
##SBATCH -o /home/gridsan/groups/fastai_shared/%u/fastai/ground-truth-logs/slurm_logs/%j.log

if [ ! -e /proc/$(pidof nvidia-smi) ]
then
	echo "nvidia-smi does not seem to be running. exiting job"
    exit 1
fi

source /etc/profile
module load anaconda/2021a

if [ $(whoami) == jpmcd ]
then
    GROUP_DIR="fastai"
else
    GROUP_DIR="fastai_shared"
fi

export TOTAL_GPUS=${SLURM_NTASKS}
export GPUS_PER_NODE=2

HF_USER_DIR="/home/gridsan/$(whoami)/.cache/huggingface"
HF_LOCAL_DIR="/state/partition1/user/$(whoami)/cache/huggingface"
mkdir -p $HF_LOCAL_DIR
rsync -a --ignore-existing $HF_USER_DIR/ ${HF_LOCAL_DIR}
export HF_HOME=${HF_LOCAL_DIR}
export TRANSFORMERS_OFFLINE=1
export HF_DATASETS_OFFLINE=1
export WANDB_DISABLED="true"

export BACKEND="pytorch"
export HF_MODEL_NAME=$1
export MODEL="hfmodel-${HF_MODEL_NAME}"
export GLUE_TASK=$2
export BATCH_SIZE=$3
export LEARNING_RATE=$4
export WEIGHT_DECAY=$5
export NUM_EPOCHS=$6

export BASEDIR=/home/gridsan/groups/${GROUP_DIR}/$(whoami)/fastai/ground-truth-logs
export LOG_DIR=${BASEDIR}/logs/${SLURM_JOBID}-${TOTAL_GPUS}-${MODEL}-${BATCH_SIZE}-${NUM_EPOCHS}
mkdir -pv ${LOG_DIR}
if ! [ -f  ${BASEDIR}/README.md ]
then
    echo "Folder name are created as follows : " > ${LOG_DIR}/../README.md
    echo "{SLURM_JOBID}-{TOTAL_GPUS}-{MODEL}-{BATCH_SIZE}-{NUM-EPOCHS}" >> ${LOG_DIR}/../README.md
fi
LOG_FILE=${LOG_DIR}/${TOTAL_GPUS}.log
ERR_LOG=${LOG_DIR}/${TOTAL_GPUS}.err
CONFIG=${LOG_DIR}/config.json

# copy batch script for posterity
cp -v /var/spool/slurmd/job$(printf %05u $SLURM_JOB_ID)/slurm_script ${LOG_DIR}/batch.sh

echo ""
echo "--------------------------------------------------------------------------------------------------"
echo "--------------------------------------------------------------------------------------------------"
echo "{" | tee -a ${CONFIG}
echo "\"NUM_NODES\"     : \"${SLURM_NNODES}\"," | tee -a ${CONFIG}
echo "\"TOTAL_GPUS\"    : \"${TOTAL_GPUS}\"," | tee -a ${CONFIG}
echo "\"GPUS_PER_NODE\" : \"${GPUS_PER_NODE}\"," | tee -a ${CONFIG}
echo "\"NODES\"         : \"$(scontrol show hostnames | tr '\n' ',')\"," | tee -a ${CONFIG}
echo "\"LOG_DIR\"       : \"${LOG_DIR}\"," | tee -a ${CONFIG}
echo "\"ERR_LOG\"       : \"${ERR_LOG}\"," | tee -a ${CONFIG}
echo "\"CONFIG\"        : \"${CONFIG}\"," | tee -a ${CONFIG}
echo ""
echo "--------------------------------------------------------------------------------------------------"
echo ""
echo "\"BACKEND\"               : \"${BACKEND}\"," | tee -a ${CONFIG}
echo "\"MODEL\"                 : \"${MODEL}\"," | tee -a ${CONFIG}
echo "\"HF_MODEL_NAME\"         : \"${HF_MODEL_NAME}\"," | tee -a ${CONFIG}
echo "\"GLUE_TASK\"             : \"${GLUE_TASK}\"," | tee -a ${CONFIG}
echo "\"BATCH_SIZE\"            : \"${BATCH_SIZE}\"," | tee -a ${CONFIG}
echo "\"LEARNING_RATE\"         : \"${LEARNING_RATE}\"," | tee -a ${CONFIG}
echo "\"WEIGHT_DECAY\"          : \"${WEIGHT_DECAY}\"," | tee -a ${CONFIG}
echo "\"NUM_EPOCHS\"            : \"${NUM_EPOCHS}\"," | tee -a ${CONFIG}
echo "--------------------------------------------------------------------------------------------------"
echo "--------------------------------------------------------------------------------------------------"
echo ""

python glue_finetune.py \
    --hf_model_name=${HF_MODEL_NAME} \
    --glue_task=${GLUE_TASK} \
    --batch_size=${BATCH_SIZE} \
    --learning_rate=${LEARNING_RATE} \
    --weight_decay=${WEIGHT_DECAY} \
    --num_epochs=${NUM_EPOCHS} \
    --log_dir=${LOG_DIR} 2>${ERR_LOG} 1>${LOG_FILE}

tail ${LOG_FILE}
echo "LOG FILE : ${LOG_FILE}"
echo ""
echo "=> end of script"
echo "creating summary"
# run some code here to summarize results

WALL_TIME=$(sacct --format="ElapsedRaw" -j ${SLURM_JOBID} -n | head -n1 | awk '{$1=$1};1')
echo "\"WALL_TIME\" : \"${WALL_TIME}\"" | tee -a ${CONFIG}
echo "}" | tee -a ${CONFIG}

echo "all done"
