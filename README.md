# Data Lag and the Global Innovation Index: Replication Files

This repository contains the replication materials for the paper:

**"Data Lag and the Global Innovation Index: Timeliness as Measurement Infrastructure in National Innovation Systems"**

## Overview

The repository provides the minimum set of data and code required to reproduce the empirical results presented in the paper. The analysis focuses on the construction of a Data Lag metric using Global Innovation Index (GII) data and its association with national innovation performance.

## Repository Structure

- `data/`
  - `Base_Final_Consolidada.csv`: Final consolidated dataset used in all empirical estimations.

- `code/`
  - `01_data_construction.py`: Extracts and restructures raw GII data from WIPO datasets and generates country-level indicator matrices.
  - `02_data_processing.do`: Prepares the dataset for econometric analysis, including variable construction and cleaning.
  - `03_analysis.R`: Performs statistical analysis, generates descriptive statistics, correlations, regressions, and figures.

## Data Source

All data are derived from publicly available datasets provided by the World Intellectual Property Organization (WIPO), specifically the Global Innovation Index (GII) reports (2021–2025).

## Reproducibility

To replicate the results:

1. Run the Python script to construct indicator-level datasets.
2. Process the data using the Stata script.
3. Execute the R script to generate all statistical results and figures.

## Software Requirements

- Python (>= 3.8)
  - pandas

- Stata (>= 15)

- R (>= 4.0)
  - tidyverse
  - readxl
  - ggplot2
  - broom
  - sandwich
  - lmtest
  - car

## Notes

The repository is designed to ensure transparency and reproducibility while maintaining a minimal and clean structure. Intermediate files and large raw datasets are intentionally excluded.

## Author

Camilo Andrés Carrascal Vergel  
Ph.D. Candidate – Universidad de los Andes

## Contact and Contributions

For any inquiries, clarifications, or potential contributions related to this repository, please contact:

Camilo Andrés Carrascal Vergel  
Email: ca.carrascal7458@uniandes.edu.co  

Feedback, suggestions, and extensions that contribute to improving the transparency, robustness, or scope of the analysis are highly encouraged.
