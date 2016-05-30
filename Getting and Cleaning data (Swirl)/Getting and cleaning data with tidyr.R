# Getting and Cleaning Data Tidying Data with tidyr

# I've created a variable called 'sat' in your workspace, which contains data on all college-bound seniors who took the SAT exam in 2013. Print the dataset now.

sat

# Accomplish the following three goals:
#
# 1. select() all columns that do NOT contain the word "total",
# since if we have the male and female data, we can always
# recreate the total count in a separate column, if we want it.
# Hint: Use the contains() function, which you'll
# find detailed in 'Special functions' section of ?select.
#
# 2. gather() all columns EXCEPT score_range, using
# key = part_sex and value = count.
#
# 3. separate() part_sex into two separate variables (columns),
# called "part" and "sex", respectively. You may need to check
# the 'Examples' section of ?separate to remember how the 'into'
# argument should be phrased.
#
sat %>%
  select(-contains("total")) %>%
  gather(part_sex, count, -score_range %>%
  separate(part_sex, c("part", "sex")) %>%
  print

submit()

# Append two more function calls to accomplish the following:
                    #
# 1. Use group_by() (from dplyr) to group the data by part and
# sex, in that order.
                    #
# 2. Use mutate to add two new columns, whose values will be
# automatically computed group-by-group:
                    #
    #   * total = sum(count)
    #   * prop = count / total
                    #
sat %>%
    select(-contains("total")) %>%
    gather(part_sex, count, -score_range) %>%
    separate(part_sex, c("part", "sex")) %>%
    group_by(part, sex) %>%
    mutate(total = sum(count),
           prop = count / total) %>%
  print
