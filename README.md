# ADS 503 Final Project: Hospital Readmission Prediction

**Michael Rosalia** | **Team 7** | MS-ADS

## Repository structure

```
ads503-hospital-readmission-prediction/
├── data/
│   ├── raw/          # Raw dataset files
│   └── processed/    # Cleaned / intermediate data
├── R/
│   └── 01_eda.qmd           # Exploratory data analysis
├── scripts/
│   ├── install_packages.R   # Install required R packages
│   └── download_data.R      # Download dataset from UCI
└── README.md
```

## Setup

Install required R packages (run once):

```r
source("scripts/install_packages.R")
```

Download the dataset:

```r
source("scripts/download_data.R")
```

Raw data is saved to `data/raw/` (not committed to Git).

## Run the analysis

Run the `.qmd` notebooks in the following order from the project root:

1. `R/01_eda.qmd`

```bash
quarto render R/01_eda.qmd
```

Figures are saved to `output/figures/` (not committed to Git).

## Authors

Michael Rosalia — mrosalia@sandiego.edu
