import argparse
import logging
from transformers import AutoModelForSequenceClassification, AutoTokenizer

parser = argparse.ArgumentParser()
parser.add_argument('--model', default='distilbert-base-uncased')
args = parser.parse_args()
# logging.getLogger().addHandler(logging.StreamHandler(sys.stdout))
# transformers.logging.set_verbosity_debug()
tokenizer = AutoTokenizer.from_pretrained(args.model, use_fast=True)
model = AutoModelForSequenceClassification.from_pretrained(args.model)
