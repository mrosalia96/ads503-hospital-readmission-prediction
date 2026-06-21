# ADS 503 Final Project: Hospital Readmission Prediction

**Michael Rosalia** | **Team 7** | MS-ADS

## Repository structure

```
ads503-hospital-readmission-prediction/
├── data/
│   ├── raw/          # Raw dataset files
│   └── processed/    # Cleaned / intermediate data
├── R/                # Analysis scripts (EDA, preprocessing, modeling, evaluation)
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

## Authors

Michael Rosalia — mrosalia@sandiego.edu
