---
title: "Text Mining YouTube Comment Data with Wordfish in R"
collection: lessons
layout: lesson
slug: youtube-scraping-wordfish-r
date: 2022-02-22
authors:
- Alex Wermer-Colan
- Nicole Lemire-Garlic
- Jeff Antsen
editors:
- Nabeel Siddiqui
topics: [r]
review-ticket: https://github.com/programminghistorian/ph-submissions/issues/374
---

put with wordfish footnote: # reference text for WordFish: Slapin, Jonathan and Sven-Oliver Proksch. 2008. “A Scaling Model for Estimating Time-Series Party Positions from Texts.” American Journal of Political Science 52(3): 705-772.

{% include toc.html %}

# Part I: Introduction to YouTube Scraping and Analysis

## Introduction to YouTube and Web Studies

YouTube is the most popular web-based video sharing and viewing platform in the world, with billions of users viewing and uploading videos each month. People across the globe tune in to YouTube for advice on health, “how to” videos, and news and entertainment of all kinds. As the world’s most utilized platform for video sharing, YouTube houses a wealth of culturally-relevant data that researchers and academics are beginning to explore.  

YouTube is markedly intertextual—each page includes multiple forms of mediated communication that refer to one another. Algorithmically recommended videos, user comments, and advertising videos appear dynamically on the same screen as the video originally posted for sharing.  

{% include figure.html filename="PH_YouTube_defund_screenshot.png" caption="Screenshot of YouTube video about debates over defunding the police in the United States" %}

Media studies scholars have historically considered how media texts reflect and inform public debate on political issues. Web studies as a field has converged in the last couple decades, with the formation of organizations such as the [Association of Internet Researchers](https://aoir.org). Web scraping and crawling is also relatively common in digital humanities circles, with Twitter being the most common platform for analysis and preservation. Discussion boards and social media platforms like Reddit, as well as Instagram and Facebook, are increasingly being mined by researchers.  

Although YouTube is best known for its entertainment and “how to” content, it also features discussions on politically salient topics as well. YouTube’s hosting of political content has not been without controversy. Media reports, for isntance, have claimed that YouTube radicalizes its viewers, [creating far-right radicals](https://www.nytimes.com/interactive/2019/06/08/technology/youtube-radical.html). In today’s hypermediated world, when politics are polarized and the algorithms that curate recommended content are themselves politicized, [YouTube has increasingly become a focus of scholarly study and debate](https://scholarcommons.scu.edu/cgi/viewcontent.cgi?article=1101&context=comm). One academic study traced a [radicalization pipeline](https://dl.acm.org/doi/abs/10.1145/3351095.3372879) whereby users who initially comment on less radical videos subsequently engage with increasingly fridge content). For both political and apolitical content, YouTube has been investigated by the [U.S. Federal Trade Commission](https://en.wikipedia.org/wiki/Federal_Trade_Commission) for its [recommendation algorithms leading young users to illicit content](https://www.vox.com/the-goods/2019/12/20/21025139/youtube-kids-coppa-law-ftc-2020).  

**This tutorial** explains how to use the R programming language for web scraping and analysis of YouTube metadata and comment data. Through this tutorial, you will learn how to access the YouTube API, process and clean video metadata, and analyze the videos' comment threads for latent meaning and ideological bent. We focus on an understudied text mining algorithm, named Wordfish, that is used in political science to study the political dimensions of texts. This tutorial will explore the complexities of wrangling web data for creating meaningful computational models of video reception discourse.  

## User-Friendly YouTube Scraping

This tutorial will walk through R code for downloading data from YouTube and analyzing it with Wordfish, using as our sample data a series of videos about the politics of the 2020 Black Lives Matter call to defund police. In our sample, we used specific videos to download relevant comments through the YouTube API, as discussed in the YouTube API section below.

Both the R script and the sample data are available for download on the [Programming Historian YouTube Wordfish Github repository](https://github.com/hawc2/Programming-Historian-Tutorial). You can also copy and paste the code from this tutorial and create your own script with your own specific video list or broader search term(s). No matter which method you use, you’ll need to create authorization credentials with YouTube to have access to their API first. 

While this tutorial will demonstrate how you can scrape and analyze YouTube entirely with the R programming language, the acquisition of YouTube data can also be performed using available web-apps. One of the best open-source and user-friendly tools available for acquiring YouTube data is [YouTube Data Tools](https://tools.digitalmethods.net/netvizz/youtube/) hosted by the University of Amsterdam’s Digital Methods Initiative. The scraper uses its credentials to access YouTube’s APIv3, saving you the step of registering for your own. With this tool, you can pull user comments, metadata about a YouTube channel, and videos via keyword search. You can also create networks of users, videos, and recommended videos. All you need is the video ID—the last few characters of the YouTube site for that video (***e.g.***, SNWic0kGH-E). (See the Keyword Searching section below for an illustration of where to locate the ID.)  

What the scraper outputs is a neatly organized .csv spreadsheet of the scraped comments alongside metadata about the exact time the comment was made, user information, and information about replies. Using this spreadsheet, a simple sort on the “replyCount” column can extract threaded conversations in order to focus on dialogue. The comments alone could also be concatenated into one large text file for topic modeling or other corpus analytics. [^1]  

[^1]: For relevant blog posts on scraping YouTube for other forms of analysis, see the following: 1) for a digital project studying YouTube, check out the team's introductory [blogpost](https://sites.temple.edu/tudsc/2018/12/12/how-to-scrape-and-analyze-youtube-data-prototyping-a-digital-project-on-immigration-discourse/); 2) fFor scraping Youtube transcripts, see Lemire Garlic's [blogpost](https://sites.temple.edu/tudsc/2019/04/03/computational-text-analysis-of-youtube-video-transcripts/); 3) for network analysis of Youtube data, see Ania Korsunska's [blogpost](https://sites.temple.edu/tudsc/2019/03/26/network-analysis-on-youtube/?relatedposts_hit=1&relatedposts_origin=5709&relatedposts_position=0); 4) and for scoping project design, see Lemire-Garlic's [blogpost](https://sites.temple.edu/tudsc/2019/10/30/to-code-or-not-to-code-project-design-for-webscraping-youtube/).

## Ethics, Privacy, and Legality of YouTube Scraping and Analysis

There are a number of ethical and legal literacies in relation to [“data justice”](https://mitpress.mit.edu/books/data-feminism) that require attention in web scraping  projects. Should “public” social media data be used for research without the content creator’s permission? A user who comments on a number of related videos may not have imagined that their patterns of communication would become the subject of public debate through an academic project. Does researching a group of users with whom the researcher is less culturally familiar open the door to causing unintentional harm? Who speaks for communities being researched online? These are challenging questions for which there are not clear answers, but questions that should nonetheless be asked. We believe DH researchers should fully incorporate ethical thinking in the use of their code. Not everything that could be scraped, analyzed, published, and visualized from YouTube should be.  

In addition to ethical challenges that arise in this field of work, there are several legal frameworks that come into play when web scraping: [copyright](https://en.wikipedia.org/wiki/Copyright), [digital locks](https://www.eff.org/files/filenode/drm_pager_fnl.pdf), and [terms of service agreements](https://en.wikipedia.org/wiki/Terms_of_service). We cannot provide legal advice on these topics, but the legal precedent has largely established the right for researchers to scrape websites for data. Before engaging in your own YouTube research, we strongly recommend that you consult with librarians and legal professionals about your specific project. We’ve also incorporated ethical and legal literacy resources in the footnotes below for further reading.[^2]  

[^2]: The University of California at Berkeley hosted a conference on these topics in June 2020: Building LLTDM - Legal Literacies for Text Data Mining. For more information, we  recommend reviewing [their website](https://buildinglltdm.org/). We further recommend the [Association of Internet Researcher’s Ethics page](https://aoir.org/ethics/).

Having addressed these critical issues, we now turn to the “how to” of scraping, wrangling, and analyzing YouTube comment data.  

## Introducing R and R Studio

R is an open-source programming language with more statistical tools than many proprietary statistical tools like STATA (*Software for Statistical Analysis and Data Science*). This lesson was written for R version 4.1. You can download R from the [Comprehensive R Archive Network](https://cran.r-project.org/). 

Select the installation corresponding to your computer’s operating system and download the installer for R. Taryn Dewar’s lesson [R Basics with Tabular Data](https://programminghistorian.org/lessons/r-basics-with-tabular-data) covers how to install R and become familiar with it.  

RStudio Desktop is the recommended [integrated development environment](https://en.wikipedia.org/wiki/Integrated_development_environment) for writing and running R scripts. The free version is more than sufficient. This lesson was written for RStudio Version 1.3. You can download and install RStudio from [rstudio.com](www.rstudio.com). Download and run the Installers for Supported Platforms appropriate to your computer’s operating system.[^3]

[^3]: In lieu of installing R and RStudio on your computer, you may use [RStudio Cloud](https://rstudio.cloud/), a web-based version. This tutorial will run on RStudioCloud. However, depending on how often you use the cloud version, you may require a paid [subscription](https://rstudio.cloud/plans/free).

 The code used in this script includes packages and libraries from standard R and Tidyverse. For background info on the basics of the R programming language, [Basic Text Processing in R](https://programminghistorian.org/lessons/basic-text-processing-in-r) by Taylor Arnold and Lauren Tilton provides an excellent overview of the knowledge of R required for text analysis. To learn more about Tidyverse, there are many great sources online, including [A Tidyverse Cookbook](https://rstudio-education.github.io/Tidyverse-cookbook/program.html) by Garrett Grolemund.

To call the YouTube API, wrangle the data, run a Wordfish analysis, and visualize the data, you’ll need to install a series of packages.[^4] The versions of the libraries necessary to currently run this program are Tidyverse 1.3.1 (containing necessary packages ggplot2, purrr, dplyr), as well as gtools 3.8.2, lubridate 1.7.9, quanteda 3.2.1, tuber 0.9.9. Most of these packages assist with data wrangling and visualization. Tuber is the library for scraping YouTube data. The quanteda package contains the Wordfish library.

[^4]: For introductory information about installing R packages, see [Datacamp's guide to R-packages](https://www.datacamp.com/community/tutorials/r-packages-guide).

```
install.packages(c("tidyverse", "gtools", 
                   "lubridate", "purrr", "devtools",
                   "quanteda", "quanteda.textmodels", "quanteda.textplots"))
devtools::install_github("soodoku/tuber", build_vignettes = TRUE)

library(tidyverse); library(tuber);library(gtools); library(lubridate); 
library(dplyr); library(ggplot2); library(purrr); library(quanteda);
library(quanteda.textmodels); library(quanteda.textplots)
```

## Introducing the Wordfish Text Mining Algorithm

This tutorial will guide the user through creating a model of YouTube comment data using the Wordfish natural language processing algorithm. It will show you how to gather comment data from several YouTube videos, and use R to wrangle it into a format that will generate a meaningful Wordfish model.

A wide range of text mining algorithms are available for scholars in the digital humanities looking to create models of big data. Many of these algorithms have already been described with tutorials on the Programming Historian - see, for example, [word frequency analysis](https://programminghistorian.org/en/lessons/counting-frequencies) and [introduction to topic modeling](https://programminghistorian.org/en/lessons/topic-modeling-and-mallet). The text mining algorithm we’ll be introducing today is called Wordfish. For information on the algorithm itself and to view its base code, see here: http://www.wordfish.org/software.html 
    
Developed by and for political scientists, Wordfish helps model textual data along a single-dimensional axis. Wordfish was created as a method for extracting the ideological leaning of documents expected to contain latent political motivation or ideology (***e.g.***, party manifestos or platforms, politician floor speeches) relative to a corpus of similar texts. For example, Wordfish can be a useful tool for identifying which member floor speeches were probably made by either Democrats or Republicans - and also roughly how extreme the partisan leaning of those members are.
    
After explaining how to wrangle YouTube Comment Data into the proper formats for Wordfish modeling, this tutorial discusses the Wordfish model in more detail in Part IV. As we explore visualizing this data, we explain how Wordfish differs from other forms of predictive text mining like topic modeling.

# Part II: Scraping the YouTube API


## The YouTube API

There are two ways to use coding to access YouTube data. You can use either 1) code that calls on YouTube’s API, or 2) code that ‘scrolls’ through the web page’s .html files and extracts structured data. In this tutorial, we focus on the API query method. To see what sort of data is available through YouTube’s API, view their [reference](https://developers.google.com/youtube/v3/docs) page. 

Note that the YouTube API has a quota that limits the number of queries you can perform each day. Once you pass that quota, all searches through the API (including keyword search, metadata query, and comment scraping) will generate a failed server request error in the R console (typically this error will include a number, frequently 401 or 403). Creating and switching between multiple sets of access credentials (discussed below) is one way to continue gathering data once your first account has reached its quota. Also be aware that the YouTube API sometimes collects only a portion of the comments available for each video; best practice is to cross-check the number listed on YouTube’s corresponding video page with the number scraped from the API.

This tutorial makes extensive use of Gaurav Sood’s [`tuber` package](https://cran.r-project.org/web/packages/tuber/index.html) to query YouTube’s API. The tuber package contains several [helpful functions](https://cran.r-project.org/web/packages/tuber/vignettes/tuber-ex.html) that you will rely upon, including `get_stats()` (to gather numerical and descriptive metadata about a video) and `yt_search()` (to search for videos matching keywords that you will choose). 

Because tuber can be used to access your personal YouTube video data through the API, as well as to obtain metadata on videos created by others, you must grant `tuber` permission through the YouTube OAuth credentials process. 

The YouTube credentials process first involves creating an OAUTH ID and SECRET. Never share your OAUTH ID or SECRET with others.  For setting up your credentials, the up-to-date instructions are on Google's [Developer's page](
https://developers.google.com/youtube/v3/getting-started). Google periodically updates the way it organizes its developer accounts, and also the exact way the YouTube API works.  The steps below were accurate as of July 20, 2020.  However, these exact steps might not work for you, if updates were made following the most recent updates to this tutorial.

1. Create a Google account. 
2. Once you are logged into your Google Account, you have to go to the Google Developers Console and choose Create Project and assign it a name.
3. Then choose Enable API and Services and select YouTube Data API v3. Choose Create Credentials. 
4. When asked, “Which API are you using?”, choose “YouTube Data API v3.” 
5. For “Where will you be calling the API from?”, choose “Other UI” because we are using R Studio Desktop.  
6. For “What data will you be accessing”, choose “Public Data”. 
7. Click “What credentials do I need?”. Copy and save your credentials for your OAUTH ID and SECRET. You should choose the option to “Restrict Key,” to reduce the ability of others to use your credentials. 
8. Go to OAuth Consent Screen on the left tab and choose Create credentials. 
9. To allow the R tuber package third-party access via your account to YouTube’s API, you need to create your credentials twice, both to allow tuber access, and to get the OAUTH ID and SECRET. 
10. Near the top of the screen, type in the Application Name: tuber. Click Save at the bottom of the screen.
11. Go back to Credentials - choose Create Credentials OAuth Client ID. Choose type: Desktop App. Name: tuber_R (or whatever you choose). 
12. Save the OAuth Client ID Credentials to your password manager. 

## Authorizing the YouTube API

There are a couple of ways that you can incorporate your new OAUTH ID and SECRET into the code.[^7] The simplest way is to  type in your credentials directly into your own version of this script. This is [the approach](https://cran.r-project.org/web/packages/tuber/readme/README.html) envisioned by the tuber package and the one we use. Below is the R code to input and authorize your OAUTH ID and SECRET.

[^7]: For a more in depth explanation of how OAuth credentials are used within R packages, see the [CRAN guide](
https://cran.r-project.org/web/packages/googlesheets/vignettes/managing-auth-tokens.html).

```
app_id <- "INSERT YOUR API ID"
app_secret <-"INSERT YOUR API SECRET"
 
yt_oauth(app_id, app_secret)
```

After you run the [yt_oauth](https://www.rdocumentation.org/packages/tuber/versions/0.9.8/topics/yt_oauth) function, you will need to authorize tuber to use your credentials by responding to a prompt in the console. Type “1” into the console following the prompt in order to give permission for authorization. You will then be prompted on a pop-up browser window with a message from Google to permit the application to access your YouTube data. 

Now that you have access to the YouTube API, the rest of this tutorial will explore how to wrangle and analyze the comment data. 

## Making a List of Videos

To search for video comments, you can either use a list of videos or a keyword search. For this tutorial, we search for comments using a predetermined video list. You can replace the videos in our tutorial with your own if you'd like to focus on a different topic.

To work from a list of video IDs, you’ll need to create a character vector in the R script containing each ID as a separate string.

```
IDsforSearch <- c("8t-hMoszGR4", "ymznwY2kbEU", "YV5srZTCX9k", "LNAvkbwzeTs")
```

The most direct way to pick out your own videos is to visit the YouTube site, and capture a list of video IDs from each video’s html link. A video’s ID is the set of alphanumeric characters that appear in the html link immediately after “watch?v=” For example, in the illustration below, the video ID is 24xsqyMcpRg. Video IDs are constant and do not change over time.

{% include figure.html filename="PH_YouTube_Video_ID_screenshot.png" caption="WRITE IMAGE CAPTION HERE" %}

Curating a dataset of YouTube comments for Wordfish requires finding videos with a sufficient amount of data (enough comments, but also enough words per comment) to conduct predictive modeling. For this tutorial we will be wrangling to meet the specific needs of a Wordfish model. Wordfish modelling is typically performed on corpora of dozens or hundreds of documents, each usually containing hundreds or thousands of words. However, we have found that Wordfish can also produce insightful models using corpora from social media. YouTube comments tend to be very short in length, but popular videos will often be accompanied by thousands of comments; enough to make up for their brevity, as long as the shortest comments are excluded prior to modeling. Because of other unique properties of YouTube comments (such as rare words, slang, other languages, or comments composed mostly of special characters or emojis), some additional wrangling is needed to ensure that each comment used contains enough data meaningful for Wordfish scaling. Additionally, the Wordfish algorithm is more likely to perform well if the videos (and by extension, the topics of the comment data) share a generally coherent subject matter. 

[^8]: To search for relevant videos using one or more general [keywords](https://developers.google.com/youtube/v3/docs/search/list). YouTube makes available a wide range of metadata about each video, including the number of likes, title, description, tags, etc.[^8] The YouTube API allows you to search for keywords in the textual metadata (including video title, description, and tags). The [yt_search](https://www.rdocumentation.org/packages/tuber/versions/0.9.8/topics/yt_search) function in `tuber` accesses this feature in the API. This second option enables you to identify a list of videos likely to be relevant to your topic by searching for videos with metadata that includes your keyword(s) of interest. For more on what you can do with YouTube metadata, see Lemire Garlic’s blog posts and her [Github page](https://github.com/nlgarlic/YouTube-Related-Video-Similarity). 

## Downloading Video Metadata

Then use the following code to pull the video metadata. Using the [get_video_details()](https://www.rdocumentation.org/packages/tuber/versions/0.9.8/topics/get_video_details) function from `tuber`, the code pulls all of the metadata for your chosen videos from the API. We then limit the metadata to what we have found most useful: the video ID itself, and also the video publication date, video title, and channel title. 

```
# downloads metadata about the videos - publication date and time, video title, and channel title
# creates custom "possibly" function to scrape video details
get_avlbl_details <- possibly(get_video_details, otherwise = NULL)

# uses map function to pull metadata for each video and converts into data frame
AllDetails <- map(IDsforSearch, get_avlbl_details)
do.call(smartbind, lapply(AllDetails, data.frame)) -> AllDetailsDF
AllDetailsDF[] <- lapply(AllDetailsDF, as.character)
AllDetailsDF <- select(AllDetailsDF, 
                       videoId = items.id, 
                       publishedAt = items.snippet.publishedAt,
                       title = items.snippet.title,
                       channelTitle = items.snippet.channelTitle) %>%
  arrange(desc(publishedAt))

AllDetailsDF$publishedAt <- AllDetailsDF$publishedAt %>% as_datetime(tz = "UTC", format = NULL)

print(paste("You have downloaded metadata for", nrow(AllDetailsDF), "videos."))
```
One challenge with the YouTube API is that it does not always return data for every video searched, even if comment data for that video exists. By using the [possibly()](https://purrr.Tidyverse.org/reference/safely.html) function from the Tidyverse, we suppress error messages that would terminate our code if the API failed to return any results for one or a few of the identified videos. We explain our process for scraping comments from multiple videos in the Scraping YouTube Comments section, below.

Now that you have scraped the metadata for your videos, you can move on to gathering the comments.


## Scraping YouTube Comments

YouTube videos are often accompanied by user comments. These comments can run the gamut in content and purpose. While they usually contain short responses to video content, they also showcase broader ideological reflections, and comments can be repurposed for other purposes, such as sharing web links. That said, the discussion board framework doesn’t allow for ongoing dialogues - all responses to a comment can only reply to the original comment. And commenters represent only a small proportion of viewers. 

Here is a screenshot of what it looks like for users on a computer browser:

{% include figure.html filename="PH_YouTube_Comments.png" caption="WRITE IMAGE CAPTION HERE" %}

This chunk gets all available video comments from API, and converts to a dataframe. As discussed above, it uses `possibly()` to avoid error messages for unavailable videos comments.

```
.# creates custom "possibly" function to scrape comments
get_avlbl_comments <- possibly(get_all_comments, otherwise = NULL)

# downloads the comments for the selected video IDs with custom possibly function and map
AllComments <- map(IDsforSearch, get_avlbl_comments)

# prints number of comments scraped
if(length(AllComments)==0){
  print("No comments can be downloaded at this time.")
} else {
  do.call(smartbind, lapply(AllComments, data.frame)) -> AllCommentsDF
  AllCommentsVideos <- unique(AllCommentsDF$videoId)
  print(paste("You have downloaded", nrow(AllCommentsDF), 
              "comments from", length(AllCommentsVideos), "unique videos:"))
  AllCommentsVideos
}
```
This  code block gets comments from the API and converts the data from its original form into a dataframe. Note that this code also uses the `possibly()` wrapper to avoid the error messages that `tuber`’s function `get_all_comments()` will produce when comments are either not currently available for a video, or when a video does not allow (and therefore does not have) any comments. Unfortunately, the YouTube API is not a perfectly reliable source of data. Sometimes comments can be successfully scraped for one video, but will be unavailable a few hours later. For this reason, it is important to account for the likelihood of tuber encountering unanticipated errors as it works with the YouTube API. In this case, if `possibly()` or another error-detecting wrapper is not used, the errors sometimes produced by tuber will terminate execution of the entire script, and comments from videos subsequent to the error will not be scraped. Sometimes the YouTube API will not return results for all videos. In these cases, you may need to retry the scrape after your API quota refreshes the next day.


# Joins Data and Metadata

This code chunk combines video metadata with the comment text and comment metadata, renaming some columns for clarity:

```
# combines video metadata with comment text and comment metadata
AllCommentsMetadata <- AllCommentsDF %>% inner_join(AllDetailsDF, by = "videoId")
AllCommentsMetadata <- rename(AllCommentsMetadata, 
                              c(commentPublishedAt = publishedAt.x,
                                commentUpdatedAt = updatedAt,
                                commentLikeCount = likeCount,
                                commentId = id,
                                videoPublishedAt = publishedAt.y,
                                videoTitle = title,
                                videoChannelTitle = channelTitle))
```

At this point, you can back up your data in a local directory and exporting your data as a .csv file:

```
# exports video metadata and comments into a "Data" folder
dir.create("YouTubeData")
# change subjec to suit your topic
subject <- "Defund_Police"
write.csv(AllCommentsMetadata, paste("YouTubeData/AllComments_", subject, "_", 
                                     Sys.Date(),sep=""))
```

After backing up your data, you can skip to the next section if you are ready to wrangle that data.

But if you would like to read in a .csv of already scraped comments and metadata (for example, the sample data we’ve created on Github), use this code first. You don't need to run these lines of code if you are using the data we just scraped. Note that if you have a comment dataset that was not scraped using this tool, you may be able to use it, but be mindful that you may also need to reformat it in order to use the rest of this script.

```
# reading in sample data as necessary
# yourdata <- read.csv("YouTubeData/AllComments__News_v_Comedy_BLM_Coverage")
yourdata <- read.csv("AllComments__News_v_Comedy_BLM_Coverage.csv")
AllCommentsMetadata <- yourdata %>% select(videoId:videoChannelTitle)
```

# Part III: Optimizing YouTube Comment Data For Wordfish


## An Introduction to Wordfish

Now that the comments are scraped, and your data are saved, there is some optimization that needs to be done to ensure that a usable Wordfish model is produced.  This optimization is broadly referred to as ‘data cleaning’, or specifically in the context of working with text data, ‘preprocessing’.  To see why this is important, it’s necessary to understand on a basic level how Wordfish models work.

Wordfish is an unsupervised, scaling method that gives two kinds of information. First, it gives information about how documents (in this case, individual comments) are best discriminated from each other by scaling them along a single dimension. In essence, the model collects comments that are ‘similar to’ each other on each end of the dimension, based on the kinds of words used in those comments. Comments on far opposite ends of this scale will generally be characterized by the inclusion of different sets of unique words, indicating focus on different kinds of concepts. Second, Wordfish identifies which specific, unique kinds of words the model used in order to perform this scaling, and arrays them along a similar dimension.

The placement of words along this scale is inherently informative - we can directly understand the meanings of words just by inspecting their placement on the appropriate visualization. The same is not inherently true of documents, without collecting or including some additional information (‘metadata’). When the documents being scaled have meaningful titles or categories, this title or category metadata can be very useful. In this case, we will use the titles of the videos which generated each subset of comments metadata that can be helpful in understanding the substantive meaning of document (comment) placement. Similarly, you can read the text of several documents located on either end of the dimension, in order to get a general idea of what kinds of comments are being grouped together and what makes them different. Layering video title metadata onto our analysis lets us see if comments on these videos are systematically different from comments on those other videos.

Examples of Wordfish visualizations will be given later in this tutorial, along with a short discussion of how to interpret them. Now that you’ve finalized your list of videos, gathered the metadata and comments for each video, and optimized your data for Wordfish through filtering, you are ready to clean and wrangle the data!

## Data Cleaning and Wrangling in R

Tuber collects comment data in `lists` form from the YouTube API.  In some of the above steps, we converted this data into a single large dataframe which contains all comments collected, from all of the different videos scraped, along with a number of additional pieces of metadata.  However, the comment text data still needs to be cleaned and preprocessed to make it usable for text data mining. 

### Preprocessing

To optimize the comment data to work well with the Wordfish model, the following code filters out numeric digits, punctuation, comments with less than 8 total words, or less than 5 unique words. We can remove these comments with less words at this stage because they definitively have too little textual data for meaningful analysis, so there is no need to spend further computing power on them. By filtering comments, we avoid the model getting misshapen or non-representative.

```
# Cleaning Comments
# uses regex: https://stringr.tidyverse.org/articles/regular-expressions.html

# filters out comments that only contain numeric digits
AllCommentsMetadata <- AllCommentsMetadata %>% filter(
  str_detect(textOriginal, "\\D+")
  )
print(paste(nrow(AllCommentsMetadata), "comments remaining"))

# filters out comments with less than 8 total words
AllCommentsMetadata <- AllCommentsMetadata %>% filter(
  str_detect(textOriginal, "\\w{8}")
  )
print(paste(nrow(AllCommentsMetadata), "comments remaining"))

# filters out comments with less than 5 unique words
AllCommentsMetadata <- AllCommentsMetadata %>% filter(
  str_detect(unique(textOriginal, "\\w{5}"))
)
print(paste(nrow(AllCommentsMetadata), "comments remaining"))
```


### Build the corpus

Now that comments have been filtered, the next step is to generate a corpus object. The corpus object is a unique data structure used to create the [document feature matrix](New Link) (TDM) below. We use the Quanteda package to build the corpus object for WordFish.

To set up Quanteda for WordFish, we need to set:

```
options(width = 110)
```

Before we build the corpus object, we need to select the video comments we want to include in our analysis based on relevant metadata like what YouTube channel it is a part of. You don't want to compare channels with radically different amounts of comment data. We're currently using one video per channel, but ideally the model would include multiple videos per channel.

```
# determine how many comments per channel
AllCommentsMetadata %>% count(videoChannelTitle)

# select two channels to compare
AllCommentsMetadata <- AllCommentsMetadata %>% filter(
  videoChannelTitle == "Fox News"|
    videoChannelTitle == "Late Night with Seth Meyers"
)
```

Now that we've selected our videos, we can build our corpus object and transform it into a document feature matrix.

```
# construct a corpus object
corp_comments <- corpus(AllCommentsMetadata, text_field = "textOriginal")
summary(corp_comments, 5)

# tokenizes and creates document feature matrix
toks_comments <- tokens(corp_comments, remove_punct = TRUE)
dfmat_comments <- dfm(toks_comments)
print(paste("you created", "a dfm with", ndoc(dfmat_comments), "documents and", nfeat(dfmat_comments), "features"))
```

DOUMENT FEATURE MATRIX INSTEAD
The `corpus` object is converted to a [`document term matrix`](https://bookdown.org/Maxine/tidy-text-mining/tidying-a-document-term-matrix.html) (DTM) object in the following.  This is the data structure Wordfish accepts for modeling.


This next code chunk removes common English [stopwords](https://nlp.stanford.edu/IR-book/html/htmledition/dropping-common-terms-stop-words-1.html), as well as some non-words common to YouTube comments which are included due to the frequency of URLs (***e.g.***, “www”).  A high concentration of stopwords in documents can adversely impact text data mining models, so you are usually better off removing them prior to modeling. 


### Optimizing the Model

Explain Quanteda and relationship to Wordfish
[tokenizes](https://en.wikipedia.org/wiki/Lexical_analysis#Tokenization) the text of each comment, and

What's a feature? token, terms, etc. Make this more consistent - document feature matrix
Why are we taking out features with less than a 100 times
We're narrowing and focusing on the terms and features most emblematic of the video comments
You can alter the code to not remove certain elements and it would still work.
This is how you explore the model iteratively

```
# removes stopwords and features less than five (5) characters
dfmat_comments <- dfm_remove(dfmat_comments, pattern = stopwords("en")) #add in unique stopwords from below#
dfmat_comments <- dfm_keep(dfmat_comments, min_nchar = 5)
print(dfmat_comments)

# removes features that occur less than 100 times
dfmat_comments <- dfm_trim(dfmat_comments, min_termfreq = 100)
print(dfmat_comments)

# keep features that appear frequently (top 10%)
dfmat_comments <- dfm_trim(dfmat_comments, min_termfreq = 0.1, termfreq_type = "quantile")
print(dfmat_comments)

# removes features that appear in more than 10% of the documents
dfmat_comments <- dfm_trim(dfmat_comments, max_docfreq = 0.1, docfreq_type = "prop")
print(dfmat_comments)

# prints top 25 features for review
print("these are the top 25 features:")
topfeatures(dfmat_comments, 25)
```

Before we start to create the Wordfish model, one last step is to prepare the metadata for the visualizations

```
# displays comment row names
head(docnames(dfmat_comments), 20) #change to comment ID#

# groups comments by Video Channel Title
dfmat_videoChannelTitle <- dfm_group(dfmat_comments, groups = videoChannelTitle)
print(dfmat_videoChannelTitle)
```

Before visualizing a Wordfish model, a small amount of processing is helpful.  The following code chunks do this processing, including creating ‘short titles’ for the videos that are more usable in subsequent visualizations which include this metadata.

WF model results are returned as a list of vectors.  Some vectors in this list correspond to document-level (comment-level) data, while others correspond to word-level data.  Saving these independently allows for them to be reconfigured into more intuitively understandable document- and word-level data frames in subsequent steps.

# Part IV: Modeling YouTube Comments in R with WordFish


## Understanding a Wordfish Model

Although Wordfish was initially developed by political scientists for researching political ideology, there is nothing ‘inherently’ political about the dimension revealed by Wordfish. Wordfish can be used to extract inherent ‘latent’ dimensionality (based on broad differences in words used) existing within any corpus. The substantive interpretation of this latent dimension depends entirely on broad trends in the typical contents of the documents comprising your research corpus. 

There are many underlying factors that can drive the latent scaling dimension a Wordfish model identifies. If content is strongly motivated by the author’s political ideology, this dimension can separate writing from authors on opposing sides of a political issue.  This dimension almost always describes broad differences in content, based on the kinds of words used. 

Since YouTube comments are short, you may find some specific examples helpful.  When analyzing comments from a single video, you will often find that this dimension separates comments about the aesthetics of the video from those discussing its topical focus. 

For example: in a corpus where you already know that your documents are about cats and/or dogs (but not specifically which documents are about which animal), a Wordfish would describe which documents are likely about cats, which are likely about dogs, and how ‘cat-typical’ or ‘dog-typical’ each document is. Very ‘catty’ or ‘doggy’ documents would be placed at the far ends of this predicted dimension. Documents that are intermediate (because they are partially about cats and partially about dogs, or because they are not about either cats or dogs) would appear towards the center of the predicted dimension.

These lines of code run the Wordfish algorithm and generate model. Note that this script will *crash* at this stage if a Wordfish model cannot be initialized, terminating execution or knitting of the final R Markdown file.  The loop above, which removes ‘problem comments’, prevents the most common reason a Wordfish model might not be able to be initialized.

Wordfish operates by making predictions about the placements of documents along this scale based on a Document Term Matrix (DTM).  Document term matrices are a tidy, structured format for storing data about the frequency of the word types used in each of a corpus of documents by using the ['bag of words'](https://en.wikipedia.org/wiki/Bag-of-words_model) approach.  

The Wordfish algorithm can be clarified by comparison to [topic modeling](http://www.cs.columbia.edu/~blei/papers/Blei2012.pdf), a tried and true method for text mining. Similar to topic modeling, wordfish uses this document term matrix to make predictions about documents based on the different kinds and frequencies of words (tokens) used in each. They are both modeling approaches to mining text data / processing natural language that rely on machine learning algorithms.  Further, both are ‘unsupervised’ - they do not rely on extrapolating information about the dataset provided based on the way the user pre-codes a subset of that data.  Instead, they both look at differences between documents, in terms of the types and frequencies of words used, and identify ‘natural’ groupings or scaling.

Another important similarity between Wordfish and topic modeling is that both treat documents as “bags of words”.  This means that the models only look at word frequency between documents.  These models do not take into account any information about word order. That means that it doesn’t matter ***where*** words occur in a document, just ***which*** words occur, and how many times each of those occurs.  Since social media comments tend to be very short, treating comments as bags of words is actually less of a potentially problematic assumption than it might be for longer documents, where different sections of content (paragraphs, pages, chapters, etc) might convey different types of meaning, and by consequence contain very different types of words.

One of the biggest strengths of both of these kinds of models is their ability to refine their results by passing over the data multiple times. For example, when a Wordfish model is initialized, all of the parameters a wordfish model measures are set as a ‘first best guess’ at the latent scaling of documents and words.  This ‘first best guess’ gives a helpful level of general insight. Depending on the quality of the text data, sometimes these models will be able to refine these initial predictions, gradually closing in on even more statistically robust and insightful models.


# WORDFISH Model Grouped by hannel title

```
# runs wordfish model on comments grouped by Video Channel Title
tmod_wf_VCT <- textmodel_wordfish(dfmat_videoChannelTitle, dispersion = "poisson", sparse = TRUE)
summary(tmod_wf_VCT)

# prints top 25 features for review
print("these are the top 25 features:")
topfeatures(dfmat_videoChannelTitle, 25)
```

## Visualizing WordFish


### Creating and Interpreting Visualizations

Wordfish models scale both the documents in a corpus and also the words in the vocabulary of that corpus along horizontal and vertical axes identifying polarity of perspective.  This lends itself to two distinct kinds of visualizations of Wordfish model results: a ‘document-level’ visualization and a ‘word level’ visualization.  Below, you will find code chunks for creating each of these kinds of visualizations, followed by short explanations of how you can interpret those visualizations.

```
# plots estimated word positions and highlights certain features
textplot_scale1d(tmod_wf_VCT, margin = "features", 
                 highlighted = c("white", "black", "racist", 
                                  "president", "democrats", "criminals"))
```




NOTES TO PARTIALLY INLUDE

You will notice in the above visualization that there is a clear horizontal separation between comments. Most of the comments are located in the middle of the horizontal dimension, with a few outliers at each end. 

There are many ways to interpret the substantive meaning of this scaling.  Below we offer two ways to interpret the results.

The first interpretive method involves using comment metadata to check for trends in comment scaling. By color-coding comments according to metadata like video title, we can see if comments with shared metadata are concentrated together or dispersed evenly.

The second interpretive method involves inspecting word-level WF output, to see what kinds of words characterize the left- and right- portions of the scale, and qualitatively identify broad commonalities between words at each end of the scale. 

Note that the document-level and word-level scales are the same; comments at the left end of the scale are characterized by more frequent occurrence of words at the left end of the scale and infrequent occurrence of words at the right end of the scale.  ]

DOUBEL check which scale word or doc quanteda uses

## First Method of Interpreting WF Comment Scaling - Color by Video Title

If your Wordfish model contains comment data from two videos, an initial research question is frequently: ‘does video A generate different kinds of comments than video B’?  The next visualization helps us answer that question, by color coding the plotting symbols from the above visualization based on the specific video that the comment was posted for.  This lets us see if, for example, the videos modeled yield very different kinds of comments, or if they generate a similar distribution of comments across a shared scaling space.  

Your corpus is composed of four videos, all with a shared topic of police violence against black and brown people, and conversations about if redirecting police funding (‘defunding the police’) could lead to less police violence and better outcomes - especially for racial minorities.  Two of these videos were gathered from more politically liberal YouTube channels; the other two from more politically conservative YouTube channels.  

Comments from the more politically liberal channels are colored in two visually distinguishable shades of blue, while comments from the more conservative channels are colored in two shades of red.  If the blue comments are relatively clustered together, and are clustered away from the red comments, this provides evidence supporting the theory that the common topics of conversation in liberal and conservative YouTube video comment threads differ.  If the red and blue comments are mixed together homogeneously on both ends of the scale, instead you can infer that similar topics are probably being discussed in the comment threads of all four videos (though maybe in slightly different ways).

As you can see, there is not a strong visual separation between the red and blue coded comments.  The red comments are even dispersed across the triangular plotting area.  The blue dots are also spread relatively evenly, although they may be slightly more concentrated on the right side of the plotting space.  

You can infer from this visualization that similar topics are probably being discussed in the comment threads of the four videos you captured.  The next question is: *what are those topics*?

## Second Method of Interpreting - Word-Level Visualizations

The second type of visualization a Wordfish model output directly lends itself to is based on the scaling of the words comprising the corpus vocabulary remaining after sparse terms are removed from the DTM.  These words (each word itself comprises its plotting point), just like the documents in the above visualization, are scaled along an almost identical vertical dimension.  

Words appearing on the left of this plotting space are common among documents on the left of the plotting space, and rare among documents on the right (and vice versa).  The vertical dimension here is similar to the document level visualization as well; it reflects the overall frequency of the word.  So, common words (unlikely to help much in differentiating left from right) appear near the top of the plotting space, and very rare words appear near the bottom.  The general triangular shape of this visualization is largely driven by the functional form of this model, although a deeper description of these aspects is beyond the scope of this tutorial. 

You can see from this visualization that words like “defunded”, “lives” next to “matter”, “apples” (possibly referring to “a few bad”), “training”/“untrained”,  and “enforcing” characterize the left side of the plotting space.  This broadly suggests that the **left** side of the plotting space identifies comments which discuss broad causal and logistical questions about which lives matter, whether or not police violence problems are due to systemic racism or to ‘a few bad apples’, and if problems with police violence could be solved with better training / equipment or if those problems would be better solved by redirecting funding or defunding police entirely.

On the other hand, words like “president”, “party”, “political”, “bill”, “propaganda”, “dnc” and “rnc”, characterize the **center-right** side of the scale.  These words all strongly indicate a discussion of the political / partisan nature of discussions around police violence.  Words like “slave”, “christian”, “religious”, “breonna” near “taylor”, “eric” near “garner”, michael [brown], and “genocide” on the **far-right** suggest that a particularly polarized sub-category of these political comments focuses on the pressing reality of actual high profile police killings.

Words like “police”, “fund”, “defund”, “officers”, “trump”, and “biden” characterize the center-top of the plotting space.  Words located in the **center-top** of the plotting space are relatively common among all comments.  Seeing these words toward the center-top is unsurprising, given the general topic of these videos - political questions around police, police violence, and funding / defunding the police.

# Conclusions

By this point of the tutorial, you have downloaded a large corpus of YouTube video comments, processed them, analyzed them using the Wordfish model of text scaling, and produced several insightful visualizations.

Based on the three visualizations you produced, you can tell that a broadly similar set of topics is discussed on liberal-leaning and conservative-leaning video comment threads on four YouTube videos focused on police brutality and questions about police funding.  Finally, you saw that Wordfish did identify a broad distinction in these comments.  It identified that some comments focus on the causes and possible solutions to police brutality (on the left side of the scale), while other comments focus on the partisan politics of this issue, including a discussion of the legacy of slavery and the reality of specific high-profile police killings.

These visualizations, and more granular analyses of the Wordfish model, will enable complex interpretations of textual meaning. That Wordfish can be useful for understanding the strange type of discourse that appears in YouTube comments is a fascinating revelation of its own. 
