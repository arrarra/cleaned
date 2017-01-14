# cleaned

This repo contains the Getting and Cleaning Data Course Project, in which we tidy the Human Activity Recognition Using
Smartphones Dataset.

It contains the following files:

* run_analysis.R : the R script that does the analysis
* average_data.txt : the tidy data set, the result of the analysis
* variable_names.txt: the names of variables in the resulting tidy dataset
* mean_and_std_data.txt : an intermediate file that contains the original datasets combined and projected to the
  required fields
* Codebook.Rmd : The codebook that describes the tidy dataset and how it was produced
* Codebook.html
* Codebook.md 
* Codebook.pdf
* LICENSE
* README.md
* cleaned.Rproj

You can remake the analysis by executing the script run_analysis.R in R. The script takes care of downloading and
unzipping the original data, if it is not already available in the directory.