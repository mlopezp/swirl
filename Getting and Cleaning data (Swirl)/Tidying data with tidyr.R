library(swirl)
swirl()
# Course 3 Getting and cleaning data
3
library(tidyr)

#Using the help file as a guide, call gather() with the following arguments (in order): students, sex, count, -grade. Note the minus sign before grade, which says we want to gather all columns EXCEPT grade.

gather(students, sex, count, -grade)

res <- gather(students2, sex_class, count)