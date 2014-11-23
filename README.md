Read me:-
The code run_analysis.R, is broken into few steps 

- Reading the files into the following variables:
subject_train.txt into subject_train
subject_test.txt into subject_test
X_train.txt into x_train
X_test.txt into x_test
y_train.txt into y_train
y_test.txt into y_test
features.txt into features


-Merging the files to create a data frame
data_x : merging the datasets x_train and x_test 
data_y : merging the datasets x_train and x_test
data_sub :merging the datasets subject_train subject_test
and merging the feat dataset with the data-x,data_y and data_sub to form the required dataframe
- Extracting the columns on  measurements of mean and standard deviation

- Adding a column to the datatset with meaningful activity names corresponding to values in the activity column.

- Calculating the Average of each column grouped by subject and activity and storing the the variable "average"

- Melting the dataframe calculated as "average" in step 4 into the long format 

- Writing the dataframe into a text file. 
