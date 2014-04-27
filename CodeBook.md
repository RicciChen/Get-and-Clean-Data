Code Book 
==================

Here I explain steps.  

Origianlly we have 28 files.

Except ReadMe.txt and features_info.txt ,here are total 26 data sets.
Transform all of them from text file into data.frame.
I seperate 26 data sets into 4 groups.

1. X Group

Merge 2 data sets *[X_test]* & *[X_trainning]* and add [features] as column names.
After merging, it becomes a 10299 x 561 data set.

Then I find out total 86 columns named *mean* or *std* .
Extract them as a 10299 x 86 dataset *mean.std.X*.

2. y Group

Merge *[y_test]* and *[y_train]* with column name *act.label*.
Add the column *activity* as description.
Finalize as a 10299 x 2 data set *act.y*.

3. Subject Group

Merge *[subject_test]* and *[subject_train]* with column name *subject*.
*subject* is a 10299 x 1 data set.  

4. Gravity Vector Group

With total 18 data sets,combine ~test and ~train data sets into 9 data set 10299 x 128.
Then merge 9 data sets into a 10299 x 1152 data set named *V*. 

5. Merge [subject]10299x1 + [act.y] 10299x2 + [mean.std.X] 10299x86  +  [V] 102299x1152 = Data  # 10299 x 1241

6. Make 2D(6x30) table by activity by subject , for 1238 variables.
Unroll each table into a vector , then save into *Table*.

