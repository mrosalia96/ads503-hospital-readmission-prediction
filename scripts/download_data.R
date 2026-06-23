# Download Diabetes 130-US hospitals dataset from UCI ML Repository.
# Run: source("scripts/download_data.R")

raw_dir <- "data/raw"
dir.create(raw_dir, recursive = TRUE, showWarnings = FALSE)

zip_path <- file.path(raw_dir, "dataset_diabetes.zip")
csv_path <- file.path(raw_dir, "diabetic_data.csv")
mapping_path <- file.path(raw_dir, "IDS_mapping.csv")

need_download <- !file.exists(csv_path) || !file.exists(mapping_path)

if (!need_download) {
  message("Dataset files already exist in ", raw_dir)
} else {
  uci_url <- "https://archive.ics.uci.edu/static/public/296/diabetes+130-us+hospitals+for+years+1999-2008.zip"

  if (!file.exists(zip_path)) {
    message("Downloading from UCI...")
    download.file(uci_url, zip_path, mode = "wb", quiet = TRUE)
  }

  message("Extracting...")
  unzip(zip_path, exdir = raw_dir)

  for (pattern in c("diabetic_data\\.csv$", "IDS_mapping\\.csv$")) {
    extracted <- list.files(raw_dir, pattern = pattern, recursive = TRUE, full.names = TRUE)
    if (length(extracted) == 0) {
      stop("Could not find ", pattern, " in downloaded archive.")
    }
    dest <- file.path(raw_dir, basename(extracted[1]))
    if (extracted[1] != dest) {
      file.copy(extracted[1], dest, overwrite = TRUE)
    }
  }

  message("Saved to ", raw_dir)
}

if (!file.exists(csv_path) || !file.exists(mapping_path)) {
  stop("Required files missing: diabetic_data.csv and IDS_mapping.csv")
}
