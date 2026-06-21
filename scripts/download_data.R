# Download Diabetes 130-US hospitals dataset from UCI ML Repository.
# Run: source("scripts/download_data.R")

raw_dir <- "data/raw"
dir.create(raw_dir, recursive = TRUE, showWarnings = FALSE)

zip_path <- file.path(raw_dir, "dataset_diabetes.zip")
csv_path <- file.path(raw_dir, "diabetic_data.csv")

if (file.exists(csv_path)) {
  message("Dataset already exists at ", csv_path)
} else {
  uci_url <- "https://archive.ics.uci.edu/static/public/296/diabetes+130-us+hospitals+for+years+1999-2008.zip"

  message("Downloading from UCI...")
  download.file(uci_url, zip_path, mode = "wb", quiet = TRUE)

  message("Extracting...")
  unzip(zip_path, exdir = raw_dir)

  extracted <- list.files(raw_dir, pattern = "diabetic_data\\.csv$", recursive = TRUE, full.names = TRUE)
  if (length(extracted) == 0) {
    stop("Could not find diabetic_data.csv in downloaded archive.")
  }
  if (extracted[1] != csv_path) {
    file.copy(extracted[1], csv_path, overwrite = TRUE)
  }

  message("Saved to ", csv_path)
}
