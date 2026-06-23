# Hospital Readmission Prediction

Predict whether a diabetic patient will be readmitted to the hospital within 30 days of discharge, using electronic health record data from 130 US hospitals.

## Overview

Hospital readmissions are costly and often preventable. This project builds a binary classification pipeline to flag patients at risk of 30-day readmission, so care teams can target follow-up and discharge planning.

The workflow is split into four Quarto notebooks: explore the data, preprocess features, train and tune models on a validation set, then evaluate on a held-out test set. All preprocessing steps (imputation, encoding, scaling) are fit on training data only to avoid leakage.

## Dataset

**Source:** [Diabetes 130-US hospitals](https://archive.ics.uci.edu/dataset/296/diabetes+130-us+hospitals+for+years+1999+2008) (UCI Machine Learning Repository)


|               |                                            |
| ------------- | ------------------------------------------ |
| Records       | ~100,000 hospital encounters (1999–2008)   |
| Target        | 30-day readmission (`readmitted == "<30"`) |
| Class balance | ~11% readmitted (imbalanced)               |
| Raw files     | `diabetic_data.csv`, `IDS_mapping.csv`     |


Rows with death or hospice discharge disposition are excluded from modeling, since those patients cannot be readmitted.

## Models

Four classifiers are compared:

- Logistic regression (baseline)
- LASSO (regularized linear)
- Random forest (`ranger`)
- XGBoost

Training uses downsampled data to address class imbalance. Hyperparameters are tuned on the validation set; the test set is used only in the final evaluation notebook.

## Requirements

- R (≥ 4.2)
- [Quarto](https://quarto.org/) for rendering `.qmd` notebooks

## Quick start

Clone the repo and open it as the working directory.

**1. Install R packages** (once):

```r
source("scripts/install_packages.R")
```

**2. Download data** (once):

```r
source("scripts/download_data.R")
```

Files are saved to `data/raw/` and are not tracked in Git.

**3. Run the pipeline** in order from the project root:

```bash
quarto render R/01_eda.qmd
quarto render R/02_preprocess.qmd
quarto render R/03_modeling.qmd
quarto render R/04_evaluation.qmd
```

You can also run cells interactively in each `.qmd` file in the RStudio / VS Code Quarto viewer. Each notebook depends on outputs from the previous step.

> **Note:** `03_modeling.qmd` is compute-heavy (~2,200 features after one-hot encoding). A full render typically takes 20–40 minutes depending on your machine.

## Repository layout

```
ads503-hospital-readmission-prediction/
├── data/
│   ├── raw/          # Downloaded CSVs (gitignored)
│   └── processed/    # RDS artifacts between pipeline steps (gitignored)
├── R/
│   ├── 01_eda.qmd           # Exploratory analysis and figures
│   ├── 02_preprocess.qmd    # Cleaning, splits, feature engineering
│   ├── 03_modeling.qmd      # Model training and validation tuning
│   └── 04_evaluation.qmd    # Test-set metrics and final model selection
├── output/
│   └── figures/      # Plots from EDA and modeling (gitignored)
└── scripts/
    ├── install_packages.R
    └── download_data.R
```

## Pipeline outputs


| Step       | Notebook            | Key outputs                                                   |
| ---------- | ------------------- | ------------------------------------------------------------- |
| EDA        | `01_eda.qmd`        | `data/processed/eda_data.rds`, figures `01`–`12`              |
| Preprocess | `02_preprocess.qmd` | `data/processed/splits_caret.rds` (60/15/25 stratified split) |
| Modeling   | `03_modeling.qmd`   | `data/processed/models.rds`, figures `13`–`14`                |
| Evaluation | `04_evaluation.qmd` | `data/processed/evaluation.rds`, figures `15`–`19`            |


## Methodology summary

- **Split:** Stratified 60% train / 15% validation / 25% test (`caret::createDataPartition`)
- **Preprocessing:** Median/mode imputation, zero-variance removal, correlation filter (|r| ≥ 0.9), one-hot encoding, center/scale — all fit on train
- **Imbalance:** `caret::downSample` on training data only
- **Metrics:** ROC-AUC, sensitivity, specificity, precision, F1, confusion matrices

## Authors

**Michael Rosalia** — [mrosalia@sandiego.edu](mailto:mrosalia@sandiego.edu)  


Academic project for ADS 503. Dataset © UCI Machine Learning Repository; see UCI terms for data use.