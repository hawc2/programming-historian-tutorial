# Programming-Historian-Tutorial
Programming Historian Tutorial for Modeling YouTube Comment Data with WordFish

This tutorial will guide you through scraping the API and modeling the data.

Note: This tutorial is outdated and will be updated. Some excess code from our revised Programming Historian tutorial will be stored here for now.

# Supplemental Code for Scraping YouTube

### Approach 2 (Keyword Search)

If you choose to search by keywords, keep in mind that the YouTube API search function uses ‘OR’ logic between your keywords. For example, searching for “defund” and “police” as two separate keywords will return results using either keyword, not a subset of videos that use both. Using too many keywords, or ones that are unfocused or unrelated, is likely to result in an overly broad corpus. This will negatively impact the coherence of your comment dataset and, by extension, the coherence of your text mining model results. Using a specific multi-word keyword, ***e.g.***, “defund the police” (as a single search term) is much more likely to return results relevant to a specific social issue.

If you are searching for videos with keywords, you’ll use this code instead. This code pulls a set of search terms and makes a dataframe of the metadata, filtered by date. To filter by date, you'll need to supply the beginning (AfterSearchDate) and ending dates (BeforeSearchDate) for your corpus in UTC format. We include sample dates in the code below.

These dates must be entered in UTC date-time format. We use the [lubridate](https://cran.r-project.org/web/packages/lubridate/lubridate.pdf) package's [as_datetime](https://rdrr.io/cran/lubridate/man/as_date.html) function to convert the date information retrieved from the YouTube API.

The following chunk of code will create create a matching Video List for your selected search terms. Note any time you want to view the value of a variable, you can write `View()`, in this case, writing `View(SearchResultsDF)`.

```
SearchResultsDF <- do.call(rbind, lapply(SearchResults, data.frame))
SearchResultsDF[] <- lapply(SearchResultsDF, as.character)

nrow(SearchResultsDF)

SearchResultsDF$publishedAt <- SearchResultsDF$publishedAt %>% as_datetime(tz = "UTC", format = NULL)
SearchResultsDF <- select(SearchResultsDF, video_id, publishedAt, title, channelTitle) %>% arrange(desc(publishedAt))
SearchResultsDF <- SearchResultsDF %>% filter(publishedAt > AfterSearchDate & publishedAt < BeforeSearchDate)
video_list <-as.vector(SearchResultsDF$video_id) #final list of video IDs
length(video_list)
(video_list)
```
