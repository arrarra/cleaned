library(dplyr)
library(data.table)

dataDir = 'UCI HAR Dataset'

# Download dataset if it is not available already.
if (!file.exists("dataset.zip")) {
        download.file(url="https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",
                      destfile="dataset.zip",
                      method="curl")
}
# Unzip
if (!dir.exists(dataDir)) {
        unzip('dataset.zip')
}

activityNames <- fread(file.path(dataDir, 'activity_labels.txt'),
                            col.names=c("label","name"))
features <- fread(file.path(dataDir, 'features.txt'),
                        col.names=c("class","name"))

#
# readDataSet:
#    setName is 'train' or 'test'
#    subjectFile, xFile, and yFile are the basenames of the files of the given dataset
#       that contain the subject, the X values, and the Y value, respectively
#

readDataSet <- function(setName, subjectFile, xFile, yFile) {
        # Read subjects
        subject <- fread(file.path(dataDir, setName, subjectFile), col.names="subject")
        # Read x data. Use feature names from file 'features.txt'
        X <- fread(file.path(dataDir, setName, xFile), col.names=features$name)
        # Read y data. Convert the activity numbers to the names from file 'activity_labels.txt'
        Y <- fread(file.path(dataDir, setName, yFile), col.names="activity") %>%
                mutate(activity = factor(sapply(activity, function (a) activityNames[a,]$name)))
        # Combine these all to one large table of train data
        cbind(data.frame(source = rep(setName, length(subject))), subject, Y, X)
}

# Read train data
trainData <- readDataSet('train', 'subject_train.txt', 'X_train.txt', 'y_train.txt')
# Read test data
testData <- readDataSet('test', 'subject_test.txt', 'X_test.txt', 'y_test.txt')

# Merge train and test data to one big table.
fulldata <- rbind(trainData, testData)

# Select only interesting columns, e.g., those for mean and std variables.

meanAndStdVariables <- features[grep("-(mean|std)", features$name),]$name
interestingVariables <- c(colnames(fulldata)[1:3], meanAndStdVariables)
meanAndStdData <- fulldata[,interestingVariables]

# Write this interesting data into a file
write.table(meanAndStdData, 'mean_and_std_data.txt', row.name=FALSE)

# Generate the result tidy dataset
averageData <- meanAndStdData %>%
        group_by(activity, subject) %>%
        summarize_each(funs(mean), 4:ncol(meanAndStdData))

# Write tidy dataset into a file
write.table(averageData, 'average_data.txt', row.name=FALSE)

# Write the variables available in the tidy dataset into a file
writeLines(colnames(averageData), "variable_names.txt")
