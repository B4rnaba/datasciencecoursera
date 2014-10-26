### Getting and Cleaning Data - Course Project

Hi! My name is Barnaba and I will tell how I solved our Cours Project puzzle.
First of all I didn't use raw data from sensors stored in "Inertial Signals"
folder. "X-test.txt" files contains all the necessary data, along with 
"subject_test.txt" (data about subjects) and "y_test.txt" (data about activities).

Secondly I didn't followed task sequence suggested in Course Project (steps). 
I began with 1 and ended on 5, but for me more convenient was to swap middle steps.
For example, I executed step 4 before step 2 because I wanted to use variable labels
to select appropriate measurements in step 2 (by R function, not manually).

In "clean_R_script.R" You will find pure R script without my comments (how surprising!)

In "CodeBook.md" you will find R script with my comments (explaining all the steps
I made and how my script works)

The result of my work is 2 data frames:
	1.) "reduced_data" (step 4 in assignment task) contains 81 named columns.
             Two first columns are "subjects" and "activities", the rest (79) are the
	     features which contains words "mean" or "std" in their names. There are
	     10299 rows (observations from "train" and "test" data sets)
	2.) "tidy_data" (step 5 in assignment task) contains the same colums, but
	     180 rows of data - averaged values for every activity of every subject
	     (6 activities x 30 subjects) 

Have a good reading and best regards... 