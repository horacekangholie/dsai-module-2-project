#!/bin/bash

# Source the conda activation script
source ~/miniconda3/etc/profile.d/conda.sh

# Activate the 'elt' environment
conda activate elt

# Set a timestamp variable
filetimestamp=$(date +'%Y%m%d_%H%M%S')

# Redirect both stdout and stderr to a log file with the timestamp suffix
exec >> /home/kangh/dsai-module-2-project/logs/run_csv_import_${filetimestamp}.log 2>&1

# Change to your project directory
cd /home/kangh/dsai-module-2-project/notebooks

# Execute the notebook using nbconvert
jupyter nbconvert --to notebook --execute csv_to_bigquery_staging.ipynb --output csv_to_bigquery_staging_nbconvert.ipynb
