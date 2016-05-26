#Dates and times with lubridate

#The today() function returns today's date. Give it a try, storing the result in a new variable called this_day.

this_day <- today()

#There are three components to this date. In order, they are year, month, and day. We can extract any of these components using the year(), month(), or day() function, respectively. Try any of those on this_day now.

year(this_day)

#Now try the same thing again, except this time add a second argument, label = TRUE, to display the *name* of the weekday (represented as an ordered factor).

wday(this_day, label = T)
[1] Thurs
Levels: Sun < Mon < Tues < Wed < Thurs < Fri < Sat

#In addition to handling dates, lubridate is great for working with date and time combinations, referred to as date-times. The now() function returns the date-time representing this exact moment in time. Give it a try and store the result in a variable called this_moment.

this_moment <- now()

#Just like with dates, we can extract the year, month, day, or day of week. However, we can also use hour(), minute(), and second() to extract specific time information. Try any of these three new functions now to extract one piece of time information from this_moment.

hour(this_moment)

#To see how these functions work, try ymd("1989-05-17"). You must surround the date with quotes. Store the result in a variable called my_date.

my_date <- ymd("1989-05-17")
ymd("1989 May 17")
mdy("March 12, 1975")
dmy(25081985)

#In addition to dates, we can parse date-times. I've created a date-time object called dt1. Take a look at it now.
# What if we have a time, but no date? Use the appropriate lubridate function to parse "03:22:14" (hh:mm:ss).

hms("03:22:14")

# lubridate is also capable of handling vectors of dates, which is particularly helpful when you need to parse an entire column of data.

#The update() function allows us to update one or more components of a date-time. For example, let's say the current time is 08:34:55 (hh:mm:ss). Update this_moment to the new time using the following command:

update(this_moment, hours = 8, minutes = 34, seconds = 55).

#To find the current date in New York, we'll use the now() function again. This time, however, we'll specify the time zone that we want: "America/New_York". Store the result in a variable called nyc. Check out ?now if you need help.

nyc <- now("America/New_York")

# For a complete list of valid time zones for use with lubridate, check out the following Wikipedia page:
#http://en.wikipedia.org/wiki/List_of_tz_database_time_zones

# Your flight is the day after tomorrow (in New York time), so we want to add two days to nyc. One nice aspect of lubridate is that it allows you to use arithmetic operators on dates and times. In this case, we'd like to add two days to nyc, so we can use the following expression: nyc + days(2). Give it a try, storing the result in a variable called depart.

depart <- nyc + days(2)

# So now depart contains the date of the day after tomorrow. Use update() to add the correct hours (17) and minutes (34) to depart. Reassign the result to depart.

depart <- update(depart, hours = 17, minutes = 34)

# The first step is to add 15 hours and 50 minutes to your departure time. Recall that nyc + days(2) added two days to the current time in New York. Use the same approach to add 15 hours and 50 minutes to the date-time stored in depart. Store the result in a new variable called arrive.

arrive <- depart + hours(15) + minutes(50)

# The arrive variable contains the time that it will be in New York when you arrive in Hong Kong. What we really want to know is what time it will be in Hong Kong when you arrive, so that your friend knows when to meet you.

# Use with_tz() to convert arrive to the "Asia/Hong_Kong" time zone. Reassign the result to arrive, so that it will get the new value.

arrive <- with_tz(arrive, tzone = "Asia/Hong_Kong")

# Fast forward to your arrival in Hong Kong. You and your friend have just met at the airport and you realize that the last time you were together was in Singapore on June 17, 2008. Naturally, you'd like to know exactly how long it has been.

# Use the appropriate lubridate function to parse "June 17, 2008", just like you did near the beginning of this lesson. This time, however, you should specify an extra argument, tz = "Singapore". Store the result in a variable called last_time.

last_time <- mdy("June 17, 2008", tz = "Singapore")

# Create an interval() that spans from last_time to arrive. Store it in a new variable called how_long.

how_long <- interval(last_time, arrive)
