#!/bin/bash

# Source the conda activation script
source ~/miniconda3/etc/profile.d/conda.sh

# Activate the 'elt' environment
conda activate elt

# Change to your dbt project directory
cd /home/kangh/dsai-module-2-project/olist_dataset

# Optionally, set a timestamp for logging (you can also handle this inside cron)
filetimestamp=$(date +'%Y%m%d_%H%M%S')

# Redirect output to a log file (optional; you can also do this in the crontab)
exec >> /home/kangh/dsai-module-2-project/olist_dataset/logs/dbt_run_${filetimestamp}.log 2>&1

# Run dbt snapshot
dbt snapshot

# Run the dbt command
dbt run
