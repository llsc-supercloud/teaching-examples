import argparse
import json
import numpy as np
import os
from datasets import load_dataset, load_metric
import transformers
from transformers import Trainer, TrainingArguments
from transformers import AutoModelForSequenceClassification, AutoTokenizer
# from transformers import DistilBertTokenizerFast, DistilBertForSequenceClassification


from config_utils import (
    load_config,
    save_config,
    add_command_line_args,
    handle_unknown_args,
)


# Set TRANSFORMERS_OFFLINE=1 HF_DATASETS_OFFLINE=1
transformers.logging.set_verbosity_info()
task_to_keys = {
    "cola": ("sentence", None),
    "mnli": ("premise", "hypothesis"),
    "mnli-mm": ("premise", "hypothesis"),
    "mrpc": ("sentence1", "sentence2"),
    "qnli": ("question", "sentence"),
    "qqp": ("question1", "question2"),
    "rte": ("sentence1", "sentence2"),
    "sst2": ("sentence", None),
    "stsb": ("sentence1", "sentence2"),
    "wnli": ("sentence1", "sentence2"),
}


def format_args(config):
    if "BATCH_SIZE" in config:
        config["BATCH_SIZE"] = int(config["BATCH_SIZE"])
    if "LEARNING_RATE" in config:
        config["LEARNING_RATE"] = float(config["LEARNING_RATE"])
    if "WEIGHT_DECAY" in config:
        config["WEIGHT_DECAY"] = float(config["WEIGHT_DECAY"])
    if "NUM_EPOCHS" in config:
        config["NUM_EPOCHS"] = int(config["NUM_EPOCHS"])


def tokenizer_preprocess_func(tokenizer, sentence1_key, sentence2_key):
    def preprocess_function(examples):
        if sentence2_key is None:
            return tokenizer(examples[sentence1_key], truncation=True)
        return tokenizer(examples[sentence1_key], examples[sentence2_key], truncation=True)
    return preprocess_function


def compute_metrics_func(metric, task):
    def compute_metrics(eval_pred):
        predictions, labels = eval_pred
        if task != "stsb":
            predictions = np.argmax(predictions, axis=1)
        else:
            predictions = predictions[:, 0]
        return metric.compute(predictions=predictions, references=labels)
    return compute_metrics


def train_from_config(config):
    model_name = config["HF_MODEL_NAME"]
    task = config["GLUE_TASK"]
    batch_size = config["BATCH_SIZE"]
    learning_rate = config["LEARNING_RATE"]
    num_train_epochs = config["NUM_EPOCHS"]
    weight_decay = config["WEIGHT_DECAY"]
    metric_name = "pearson" if task == "stsb" else "matthews_correlation" if task == "cola" else "accuracy"
    validation_key = "validation_mismatched" if task == "mnli-mm" else "validation_matched" if task == "mnli" else "validation"
    sentence1_key, sentence2_key = task_to_keys[task]
    raw_datasets = load_dataset("glue", task)
    metric = load_metric("glue", task)
    compute_metrics = compute_metrics_func(metric, task)
    tokenizer = AutoTokenizer.from_pretrained(model_name, use_fast=True)
    preprocess_function = tokenizer_preprocess_func(tokenizer, sentence1_key, sentence2_key)
    encoded_dataset = raw_datasets.map(preprocess_function, batched=True)
    num_labels = 3 if task.startswith("mnli") else 1 if task=="stsb" else 2
    model = AutoModelForSequenceClassification.from_pretrained(model_name, num_labels=num_labels)
    args = TrainingArguments(
        "test-glue",
        evaluation_strategy="epoch",
        learning_rate=learning_rate,
        per_device_train_batch_size=batch_size,
        per_device_eval_batch_size=batch_size,
        num_train_epochs=num_train_epochs,
        weight_decay=weight_decay,
        load_best_model_at_end=True,
        metric_for_best_model=metric_name,
    )
    trainer = Trainer(
        model,
        args,
        train_dataset=encoded_dataset["train"],
        eval_dataset=encoded_dataset[validation_key],
        tokenizer=tokenizer,
        compute_metrics=compute_metrics
    )
    trainer.train()
    output = trainer.evaluate()
    for k in output:
        key = f"HF_OUTPUT_{k.upper()}"
        config[key] = output[k]
    # save_config(config, config["CONFIG_OUT"])


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--config", type=str, help="JSON Config filename for HF training parameters")
    args, unknown = parser.parse_known_args()
    try:
        config = load_config(args.config)
    except:
        config = {}
    unknown = handle_unknown_args(unknown)
    add_command_line_args(config, args, unknown)
    format_args(config)
    train_from_config(config)
