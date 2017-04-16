run_analysis <- function() {	
	
	## Read in the activity labels and their number. The resulting columns in the data frane are; V1 (label number), V2(actual label)
	activity_labels <- read.table("activity_labels.txt", col.names = c("number", "activity"))
	##*return(activity_labels)
	
	## Read in column number and names (i.e., features.txt)
	features <- read.table("features.txt", col.names = c("col number", "col name"))
	##*return(features)

	## Training data
	{
		## Read in a subset of the training data file
		n_row_traing = 500
			
		## Read in Y_train. Contains the "activity label" number and the corresponding label
		Y_train <- read.table("train\\Y_train.txt", nrows = n_row_traing)
		##*return(Y_train)
	
		## Read in training subjects. Read in only the 1st 6 columns.
		X_train <- read.table("train\\X_train.txt", col.names = features[, "col.name"], colClasses = c(rep("numeric", 6), rep("NULL", 555)), nrows = n_row_traing)
		##*return(X_train)
	
		## Merges the activity label number on to each row in X_train. Note: Their are no corresponding columns in the 2 data sets. How to merge?
		## Via stackoverflow, use row.names
		merged1 <- merge(Y_train, X_train,by=0,all.x=TRUE)
		##*return(merged1)
	
		merged2 <- merge(merged1, activity_labels, by.x ="V1", by.y = "number", all.x=TRUE)
		merged2$Type <- "Train"
		##*return(merged2)
	}
	
	## test data
	{
		## Read in a subset of the training data file
		n_row_test = 100
			
		## Read in Y_test. Contains the "activity label" number and the corresponding label
		Y_test <- read.table("test\\Y_test.txt", nrows = n_row_test)
		##*return(Y_test)
	
		## Read in training subjects. Read in only the 1st 6 columns.
		X_test <- read.table("test\\X_test.txt", col.names = features[, "col.name"], colClasses = c(rep("numeric", 6), rep("NULL", 555)), nrows = n_row_test)
		##*return(X_test)
	
		## Merges the activity label number on to each row in X_train. Note: Their are no corresponding columns in the 2 data sets. How to merge?
		## Via stackoverflow, use row.names
		merged3 <- merge(Y_test, X_test,by=0,all.x=TRUE)
		##*return(merged3)
	
		merged4 <- merge(merged3, activity_labels, by.x ="V1", by.y = "number", all.x=TRUE)
		merged4$Type <- "Test"
		##*return(merged4)
	}

	merged5 <- rbind(merged2,merged4)
	merged5$V1 <- NULL
	merged5$Row.names <- NULL
	
	# Write CSV in R
	write.csv(merged5, file = "Tiddy_Dataset.csv", row.names=FALSE)

	return(merged5)
}