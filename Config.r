##### This Config file will allow you to choose settings and parameters without needing to make any changes to the full pipeline. ###
### The first time you access the YouTUbe API, you must enter your credentials for Authenticator ID and Secret: 
### To scrape videos, you must enter your credentails below:
### You will be promted to activate your credentials the first time you use them through the console,
### and then you will be redirected to confirm through the API
### Insert YOUR Authenticator ID and Secret for the YouTube API (these are unique to each individual/account)
# This has NO DEFAULT!

#API_ID <- "Authenticator ID"   # Single string
#API_Secret <- "Authenticator Secret"  # Single string

### Identify the SUBJECT of the videos you are looking to scrape comments for, and
### Identify which SEARCH term(s) you would like to use, to identify videos for that subject
### Identify the SUBJECT of the videos you are looking to scrape comments and which SEARCH term(s) to identify relevant videos for that subject
#Subject <- "Your Subject Here"  # Single string
#Search <- c("YOUR", "CHOICES", "HERE")  # Vector of strings

# Other Tested Options:
#Subject <- "Floyd Chauvin and BLM"
#Search <- c("george floyd", "derek chauvin", "black lives matter")
#Subject <- "MAGA"
#Search <- c("MAGA", "#maga")
#Subject <- "COVID_and_Opening_America"  #@ what the project is about (this will appear in visualization titles and file names)
#Search <- c("reopening america", "reopen america", "#reopenamerica", "freeamericanow", "#freeamericanow")
Subject <- "Man Yoga"
Search <- c("#yogaformen", "#mensyoga")
#Subject <- c("Last Week Tonight")
#Search <- c("Last Week Tonight with John Oliver", "Last Week Tonight", "John Oliver")
#Subject <- "TEST"  #@ what the project is about (this will appear in visualization titles and file names)
#Search <- c("Madden21")


### Identify the DATE RANGE of the posting dates for videos you would like to scrape
### It is particularly important to set this range if you are studying a current event

# Enter your choices below:
#BeforeDate <- "20YY-MM-DDT00:00:00Z"   # scrape videos posted before: MM DD, 20YY
#AfterDate <- "20YY-MM-DDT00:00:00Z"    # scrape videos posted after:  MM DD, 20YY

# Default (note - you must submit dates in this format!):
#BeforeDate <- "2020-06-13T00:00:00Z"   # scrape videos posted before: June 13, 2020
#AfterDate <- "2020-05-14T00:00:00Z"    # scrape videos posted after:  May 14, 2020

# Other used options
BeforeDate <- "2020-06-01T00:00:00Z"   # scrape videos posted before: June 1, 2020
AfterDate  <- "2020-05-01T00:00:00Z"    # scrape videos posted after:  May 1, 2020
#BeforeDate <- "2020-06-12T00:00:00Z"   # scrape videos posted before: 
#AfterDate <-  "2020-03-06T00:00:00Z"    # scrape videos posted after:  
### Identify the DATE RANGE of the posting dates for videos you would like to scrape (note - you must submit dates in this format!):
#BeforeDate <- "2020-06-15T00:00:00Z"   # scrape videos posted before: June 13, 2020
#AfterDate <- "2020-05-14T00:00:00Z"    # scrape videos posted after:  May 14, 2020

### Do you want to keep only the N videos with the most comments?
# top_N_videos <- c(PICK BOOLEAN VAL, PICK N)
top_N_videos <- c(FALSE, 12)

### Do you want to keep only videos with at least M comments?
### Choosing more restrictions, larger values of M, and smaller values of N will limit # of comments scraped
# atleast_M_comments <- c(PICK BOOLEAN VAL, PICK M)
atleast_M_comments <- c(FALSE, 20)