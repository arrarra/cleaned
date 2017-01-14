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

The analysis has the following steps:

1. Download the dataset, if not available in the directory
2. Unzip the dataset.zip file, if needed
3. Read the activity names
4. Read the feature names
5. Read datasets. For both datasets `train` and `test` do the following steps.
   * Read the subjects
   * Read the X data (561 variables for each observation). Set the column names using the feature names
   * Read the Y data. Transform the numeric values to the activity names
   * Combine these column wise into a data frame.
6. Combine row wise the two data frames.
7. Select the interesting columns, those that contain means and standard deviations.
   Write the result into file `mean_and_std_data.txt`.
8. Group the dataset by activity and subject and summarize each column by counting the mean.
9. Write the result to file `average_data.txt`. This is the result tidy dataset.
10. Write the variable names into file `variable_names.txt`.
