# Install required R packages for this project.
# Run once: source("scripts/install_packages.R")

required <- c(
  "tidyverse",
  "tidymodels",
  "recipes",
  "caret",
  "glmnet",
  "ranger",
  "xgboost",
  "yardstick",
  "themis",
  "scales",
  "pROC",
  "patchwork",
  "knitr",
  "rmarkdown"
)

installed <- rownames(installed.packages())
missing <- setdiff(required, installed)

if (length(missing) > 0) {
  install.packages(missing, repos = "https://cloud.r-project.org")
  message("Installed: ", paste(missing, collapse = ", "))
} else {
  message("All required packages are already installed.")
}
