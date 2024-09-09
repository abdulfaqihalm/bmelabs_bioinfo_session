#!/bin/bash

# Function to check if R is installed
check_R() {
  if command -v R >/dev/null 2>&1; then
    echo "R is already installed."
  else
    echo "R is not installed. Installing R..."
    sudo apt update
    sudo apt install -y r-base  # For Ubuntu/Debian systems
  fi
}

# Install necessary R libraries
install_R_packages() {
  R -e "if (!requireNamespace('BiocManager', quietly=TRUE)) install.packages('BiocManager')"               # Biostat Package manager
  R -e "BiocManager::install('tidyverse')"       # For data manipulation and ggplot viz
  R -e "BiocManager::install('DESeq2')"          # For differential expression
  R -e "BiocManager::install('tximport')"        # Importing transcript abundance estimates
}

# Run the functions
check_R
install_R_packages

echo "R setup complete with required packages!"
