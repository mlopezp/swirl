# Maniuplating data with dplyr

# I've created a variable called path2csv, which contains the full file path to the dataset. Call read.csv() with two arguments, path2csv and stringsAsFactors = FALSE, and save the result in a new variable called mydf. Check ?read.csv if you need help.

mydf <- read.csv(path2csv, stringsAsFactors = FALSE)

# Use dim() to look at the dimensions of mydf.

dim(mydf)

# Now use head() to preview the data.

head(mydf)

# The dplyr package was automatically installed (if necessary) and loaded at the beginning of this lesson. Normally, this is something you would have to do on your own. Just to build the habit, type library(dplyr) now to load the package again.

library(dplyr)


# It's important that you have dplyr version 0.4.0 or later. To confirm this, type packageVersion("dplyr").

packageVersion("dplyr")

# The first step of working with data in dplyr is to load the data into what the package authors call a 'data frame tbl' or 'tbl_df'. Use the following code to create a new tbl_df called cran:

cran <- tbl_df(mydf)

# To avoid confusion and keep things running smoothly, let's remove the original data frame from your workspace with rm("mydf").

rm("mydf")

# From ?tbl_df, "The main advantage to using a tbl_df over a regular data frame is the printing." Let's see what is meant by this. Type cran to print our tbl_df to the console.

cran

# As may often be the case, particularly with larger datasets, we are only interested in some of the variables. Use select(cran, ip_id, package, country) to select only the ip_id, package, and country variables from the cran dataset.

select(cran, ip_id, package, country)

# Normally, this notation is reserved for numbers, but select() allows you to specify a sequence of columns this way, which can save a bunch of typing. Use select(cran, r_arch:country) to select all columns starting from r_arch and ending with country.

select( cran, r_arch:country)

# We can also select the same columns in reverse order. Give it a try.

select(cran, country:r_arch)

# Instead of specifying the columns we want to keep, we can also specify the columns we want to throw away. To see how this works, do select(cran, -time) to omit the time column.

select(cran, -time)

# The negative sign in front of time tells select() that we DON'T want the time column. Now, let's combine strategies to omit all columns from X through size (X:size). To see how this might work, let's look at a numerical example with -5:20.

-5:20

# Use this knowledge to omit all columns X:size using select()

select(cran, -(X:size))

# Use filter(cran, package == "swirl") to select all rows for which the package variable is equal to "swirl". Be sure to use two equals signs side-by-side!

filter(cran, package == "swirl")

# You can specify as many conditions as you want, separated by commas. For example filter(cran, r_version == "3.1.1", country == "US") will return all rows of cran corresponding to downloads from users in the US running R version 3.1.1. Try it out.

filter(cran, r_version == "3.1.1", country == "US")

# Edit your previous call to filter() to instead return rows corresponding to users in "IN" (India) running an R version that is less than or equal to "3.0.2". The up arrow on your keyboard may come in handy here. Don't forget your double quotes!

filter(cran, r_version <= "3.0.2", country == "IN")

# Our last two calls to filter() requested all rows for which some condition AND another condition were TRUE. We can also request rows for which EITHER one condition OR another condition are TRUE. For example, filter(cran, country == "US" | country == "IN") will gives us all rows for which the country variable equals either "US" or "IN". Give it a go.

filter(cran, country == "US" | country == "IN")

# Now, use filter() to fetch all rows for which size is strictly greater than (>) 100500 (no quotes, since size is numeric) AND r_os equals "linux-gnu". Hint: You are passing three arguments to filter(): the name of the dataset, the first condition, and the second condition.

filter(cran, size > 100500, r_os == "linux-gnu")

# Okay, ready to put all of this together? Use filter() to return all rows of cran for which r_version is NOT NA. Hint: You will need to use !is.na() as part of your second argument to filter().

filter(cran, !is.na(r_version))

# To see how arrange() works, let's first take a subset of cran. select() all columns from size through ip_id and store the result in cran2.

cran2 <- select(cran, size:ip_id)

# Now, to order the ROWS of cran2 so that ip_id is in ascending order (from small to large), type arrange(cran2, ip_id). You may want to make your console wide enough so that you can see ip_id, which is the last column.

arrange(cran2, ip_id)

# To do the same, but in descending order, change the second argument to desc(ip_id), where desc() stands for 'descending'. Go ahead.

arrange(cran2, desc(ip_id))

#  We can also arrange the data according to the values of multiple variables. For example, arrange(cran2, package, ip_id) will first arrange by package names (ascending alphabetically), then by ip_id. This means that if there are multiple rows with the same value for package, they will be sorted by ip_id (ascending numerically). Try arrange(cran2, package, ip_id) now.

arrange(cran2, package, ip_id)

# Arrange cran2 by the following three variables, in this order: country (ascending), r_version (descending), and ip_id (ascending).

arrange(cran2, country, desc(r_version), ip_id)

# To illustrate the next major function in dplyr, let's take another subset of our original data. Use select() to grab 3 columns from cran -- ip_id, package, and size (in that order) -- and store the result in a new variable called cran3.

cran3 <- select(cran,ip_id, package, size)

# We want to add a column called size_mb that contains the download size in megabytes. Here's the code to do it mutate(cran3, size_mb = size / 2^20)

mutate(cran3, size_mb = size / 2^20)

# One very nice feature of mutate() is that you can use the value computed for your second column (size_mb) to create a third column, all in the same line of code. To see this in action, repeat the exact same command as above, except add a third argument creating a column that is named size_gb and equal to size_mb / 2^10.

mutate(cran3, size_mb = size / 2^20, size_gb = size_mb / 2^10)

# Let's try one more for practice. Pretend we discovered a glitch in the system that provided the original values for the size variable. All of the values in cran3 are 1000 bytes less than they should be. Using cran3, create just one new column called correct_size that contains the correct size.

mutate(cran3, correct_size = size + 1000)

# The last of the five core dplyr verbs, summarize(), collapses the dataset to a single row. Let's say we're interested in knowing the average download size. summarize(cran, avg_bytes = mean(size)) will yield the mean value of the size variable. Here we've chosen to label the result 'avg_bytes', but we could have named it anything. Give it a try.

summarize(cran, avg_bytes = mean(size))

