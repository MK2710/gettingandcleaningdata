This README explainss how the original dataset was tidied and reduced to
the final smaller dataset.

The original data and README was obtained from
"<https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip>".

The original data and additinal information was generated and made
accessible by:

Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
Smartlab - Non Linear Complex Systems Laboratory DITEN - Università
degli Studi di Genova. Via Opera Pia 11A, I-16145, Genoa, Italy.
<activityrecognition@smartlab.ws> www.smartlab.ws

The data was generated from a group of volunteers carrying a smartphone
at the waist. This data is movement data recorded by a gyroscope and an
accelerometer. For more information read the original README, availabe
under the provided link.

This dataset consists of this README, a codebook
(Codebook\_tidy\_dataset.md) and the final tidy dataset (tidy\_data).

To read the data into R use the read.table("tidy\_data") command, it
might be necessary to adjust your file path.

Step 1: Firstly, the dataset was assembled into one dataset(test and
training set fused and columns (subject and activities) added.

Step2: Only measurements of mean and standard deviation were maintained
in the dataset (additional to subject and activity). The regular
expression: "subject|activity|\[Mm\]ean|std" was used to filter for
these categories, since no other variants of mean or standard deviation
abbreviations were found.

Step3: The activity codes 1-6 were replaced with the corresponding
activity names: activity

1 WALKING 2 WALKING\_UPSTAIRS 3 WALKING\_DOWNSTAIRS 4 SITTING 5 STANDING
6 LAYING

Step4: For descriptive variable names all abrevations were elongated to
their original meaning: "t" -&gt; "in the time domain" "f" -&gt; "in the
frequency domain" "Acc" -&gt; "accelerometer"  
"gyro" -&gt; "gyroscope"  
"X" -&gt; "in X dimension"  
"Y" -&gt; "in Y dimension" "Z" -&gt; "in Z dimension" "mean" -&gt; "mean
of"  
"meanFreq" -&gt; "frequency mean of"  
"std" -&gt; "st. dev. of"  
"Jerk"" -&gt; "Jerking motions"  
"Mag" -&gt; "magnitude of"

Step5:

The aggregate function was used to compute averages of all remaining
variables per subject for each activity.
