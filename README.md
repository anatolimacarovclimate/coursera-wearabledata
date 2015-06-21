---
title: "README.md"
author: "fusionprogguy"
date: "Sunday, June 21, 2015"
output: html_document
---

# README

Project: Human Activity Recognition Using Smartphones Data

The project for the course [Getting and Cleaning Data](https://www.coursera.org/course/getdata) was to read in the ["Human Activity Recognition Using Smartphones" data set](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) and write a program [run_analysis.R](run_analysis.R) to perform a transformation of the multiple data sets and output a tidy data set [tidy_activity_mean.txt](tidy_activity_mean.txt)

## Installation

1. Download the data from the following link
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

2. Unzip the file Dataset.zip file

3. Place the run_analysis.R file into the folder:

```
\getdata-projectfiles-UCI HAR Dataset\UCI HAR Dataset

```
You should see folders: 'test', 'train' and 
Text files: README.txt, activity_labels.txt, features.txt, features_info.txt and
R scripts: [run_analysis.R](run_analysis.R)

4. Open RStudio and set your working directory to the folder in which the data was downloaded above in the subdirectory \UCI HAR Dataset
Your setwd command should look something like this on a Winows operating system. Change the folder slashes if you are on a Mac or Linux:

```
setwd("F:/Courses/Coursera/Getting and Cleaning Data/Week 3/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset")
```

5. Run the run_analysis.R script by using the source command as follows:
```
source("run_analysis.R")
```

6. Wait for the program to load libraries, and files. This can take up to 30 seconds depending on the speed of your computer. Messages are printed in red as files are loaded or writen to file.

7. Check to see if there were any warning messages about missing files or packages. Troubleshoot if necessary.

8. Once the script has finished you should see a new tidy data file in the folder:
[tidy_activity_mean.txt](tidy_activity_mean.txt)

## Credits

Zeno Rocha's template for Github READMEs (Markdown) + Sublime Snippet
https://gist.github.com/zenorocha/4526327

## License

Use of this dataset in publications must be acknowledged by referencing the following publication [1] 

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. A Public Domain Dataset for Human Activity Recognition Using Smartphones. 21th European Symposium on Artificial Neural Networks, Computational Intelligence and Machine Learning, ESANN 2013. Bruges, Belgium 24-26 April 2013. 

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.

##Contact

e-mail: steven.muschalik@gmail.com
Twitter: @StevenMuschalik