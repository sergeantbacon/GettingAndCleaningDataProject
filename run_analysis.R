library(plyr)
library(reshape)

## prep the data sets
subjecttest <- read.table("subject_test.txt")
xtest <- read.table("X_test.txt")
ytest <- read.table("y_test.txt")
colnames(subjecttest)[1] <- "subject"
colnames(ytest)[1] <- "activity"
xtest["subject"] <- subjecttest["subject"]
xtest["activity"] <- ytest["activity"]

subjecttrain <- read.table("subject_train.txt")
xtrain <- read.table("X_train.txt")
ytrain <- read.table("y_train.txt")
colnames(subjecttrain)[1] <- "subject"
colnames(ytrain)[1] <- "activity"
xtrain["subject"] <- subjecttrain["subject"]
xtrain["activity"] <- ytrain["activity"]

## melt the data
testdata <- melt(xtest, id=c("subject", "activity"))
traindata <- melt(xtrain, id=c("subject", "activity"))

# combine the test and training datasets
hardata <- rbind(testdata, traindata)
colnames(hardata)[3] <- "feature"
colnames(hardata)[4] <- "featurevalue"

## add the activity labels
activitylabels <- read.table("activity_labels.txt")
colnames(activitylabels)[1] <- "activity"
colnames(activitylabels)[2] <- "activitylabel"
hardata2 <- merge(x = hardata, y = activitylabels, by = "activity", all = TRUE)

## add the feature labels
hardata2[,3] <- gsub("^V", "", hardata2[,3])
featurelabels <- read.table("features.txt")
colnames(featurelabels)[1] <- "feature"
colnames(featurelabels)[2] <- "featurelabel"
hardata3 <- merge(x = hardata2, y = featurelabels, by = "feature", all = TRUE)

## subset the data frame to only show stdev and mean entries
hardata4 <- hardata3[regexpr("mean\\(\\)|std\\(\\)", hardata3$featurelabel) > 0,]

## improve the feature labels to be more readable
hardata4$featurelabel <- gsub("^t", "Time", hardata4$featurelabel)
hardata4$featurelabel <- gsub("^f", "FrequencyDomain", hardata4$featurelabel)
hardata4$featurelabel <- gsub("mean()", "Mean", hardata4$featurelabel)
hardata4$featurelabel <- gsub("std()", "StdDev", hardata4$featurelabel)
hardata4$featurelabel <- gsub("max()", "Max", hardata4$featurelabel)
hardata4$featurelabel <- gsub("min()", "Min", hardata4$featurelabel)
hardata4$featurelabel <- gsub("mad()", "Median", hardata4$featurelabel)
hardata4$featurelabel <- gsub("Acc", "Accelerometer", hardata4$featurelabel)
hardata4$featurelabel <- gsub("Gyro", "Gyroscope", hardata4$featurelabel)
hardata4$featurelabel <- gsub("Mag", "Magnitude", hardata4$featurelabel)
hardata4$featurelabel <- gsub("sma", "SignalMagnitudeArea", hardata4$featurelabel)
hardata4$featurelabel <- gsub("energy", "Energy", hardata4$featurelabel)
hardata4$featurelabel <- gsub("iqr", "InterquartileRange", hardata4$featurelabel)
hardata4$featurelabel <- gsub("entropy", "SignalEntropy", hardata4$featurelabel)
hardata4$featurelabel <- gsub("arCoeff", "AutoRegressionCoefficient", hardata4$featurelabel)
hardata4$featurelabel <- gsub("correlation", "Correlation", hardata4$featurelabel)
hardata4$featurelabel <- gsub("maxInds", "MaxMagnitudeIndex", hardata4$featurelabel)
hardata4$featurelabel <- gsub("meanFreq", "MeanFrequency", hardata4$featurelabel)
hardata4$featurelabel <- gsub("skewness", "Skewness", hardata4$featurelabel)
hardata4$featurelabel <- gsub("kurtosis", "Kurtosis", hardata4$featurelabel)
hardata4$featurelabel <- gsub("bandsEnergy", "BandsEnergy", hardata4$featurelabel)
hardata4$featurelabel <- gsub("angle", "Angle", hardata4$featurelabel)
hardata4$featurelabel <- gsub("BodyBody", "Body", hardata4$featurelabel)
hardata4$featurelabel <- gsub("X$", "XAxis", hardata4$featurelabel)
hardata4$featurelabel <- gsub("Y$", "YAxis", hardata4$featurelabel)
hardata4$featurelabel <- gsub("Z$", "ZAxis", hardata4$featurelabel)
hardata4$featurelabel <- gsub("\\(\\)", "", hardata4$featurelabel)
hardata4$featurelabel <- gsub("\\-", "", hardata4$featurelabel)

## summarize by activity-subject-feature
hardata5 <- ddply(hardata4, .(subject,activitylabel,featurelabel), summarize, mean=mean(featurevalue))