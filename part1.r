## ------------------------------------------------------------------------
#install.packages("tidyverse")
survey <- read.csv("https://raw.githubusercontent.com/introdsci/MusicSurvey/master/music-survey.csv")

preferences <-read.csv("https://raw.githubusercontent.com/introdsci/MusicSurvey/master/preferences-survey.csv")


## ------------------------------------------------------------------------


colnames(survey)[colnames(survey)== "First..we.are.going.to.create.a.pseudonym.for.you.to.keep.this.survey.anonymous..more.or.less...Which.pseudonym.generator.would.you.prefer."] <- "pseudonym_generator"

colnames(survey)[colnames(survey)== "What.is.your.pseudonym."] <- "pseudonym"

colnames(survey)[colnames(survey) == "Sex" ]<- "sex"

colnames(survey)[colnames(survey) == "Timestamp" ]<- "time_submitted"

colnames(survey)[colnames(survey) == "Major" ]<- "academic_major"

colnames(survey)[colnames(survey) == "Year.you.were.born..YYYY." ]<-"year_born"

colnames(survey)[colnames(survey) == "Academic.Year" ] <- "academic_level"

colnames(survey)[colnames(survey) == "Which.musical.instruments.talents.do.you.play...Select.all.that.apply." ]<- "instrument_list"

colnames(survey)[colnames(survey) == "Artist" ]<- "favorite_song_artist"

colnames(survey)[colnames(survey) == "Song" ]<- "favorite_song"

colnames(survey)[colnames(survey) == "Link.to.song..on.Youtube.or.Vimeo." ]<- "favorite_song_link"

colnames(preferences)[colnames(preferences) == "What.was.your.pseudonym."] <- "pseudonym"

Favorite_Song <- tidyr::tibble(pseudonym=survey$pseudonym, favorite_song=survey$favorite_song, favorite_song_artist=survey$favorite_song_artist, link=survey$favorite_song_link)

Person <- tidyr::tibble(pseudonym=survey$pseudonym, time_submitted=survey$time_submitted, sex=survey$sex, academic_level=survey$academic_level, Major=survey$academic_major)

Ratings <-tidyr::gather(preferences, key = "Song", value = "Rating", 3:45)

Person$academic_level <- as.factor(Person$academic_level)

levels(Person$Major)[levels(Person$Major) == "Computer information systems"] <- "Computer Information Systems"



## ------------------------------------------------------------------------
library("ggplot2")



## ------------------------------------------------------------------------

ggplot(Ratings, aes(x = pseudonym , y = Rating) ) + geom_boxplot()



## ------------------------------------------------------------------------
ggplot(Ratings, aes(x=Rating) ) + geom_histogram(binwidth=1)
ggplot(Ratings, aes(x= Rating, y= pseudonym) ) + geom_boxplot() + coord_flip()



## ------------------------------------------------------------------------
ggplot(Ratings, aes(x=pseudonym, y= Rating) ) + geom_boxplot(binwidth = .15) + coord_flip()



## ------------------------------------------------------------------------
f_song <- Favorite_Song[Favorite_Song$pseudonym != "Heroes War",]
#f_song$pseudonym<-as.factor(f_song$pseudonym[f_song$pseudonym != "Heroes War"])

Charts<-dplyr::left_join(f_song,Ratings,by="pseudonym")
Charts[3:4] <- NULL
#Charts$Song <- str_replace_all(Charts$Song, pattern = ".", replacement = " ")
#select(Person,Major)

