
# Now i have a merged data set with the actors and directors and i want to look at which actors and directors are associated with the top movies

top_table <- function(netflix, Latex = TRUE){
    library(xtable)
    #Lets start with the directors
    top_directors <- netflix %>%
        mutate(year = make_date(release_year, 1, 1)) %>%
        select(directors, type, imdb_score, year) %>%
        filter(!is.na(directors), directors != "", year > 2000, type=="MOVIE") %>% #want to make sure the director is still around and have more relevant movies
        separate_rows(directors, sep = ", ") %>% #for movies with more than 1 director need to separate them
        group_by(directors) %>%
        summarise(avg_score = median(imdb_score)) %>%
        arrange(desc(avg_score)) %>%
        rename("IMDB Critic Score"= "avg_score") %>%
        slice_head(n=20)


    #Now lets doit for the actors as well
    top_actors <- netflix %>%
        mutate(year = make_date(release_year, 1, 1)) %>%
        select(actors, type, imdb_score, year) %>%
        filter(!is.na(actors), actors != "", year > 2000, type=="MOVIE") %>% #want to make sure the actors is still around
        separate_rows(actors, sep = ", ") %>% #for movies with more than 1 actor need to separate them
        group_by(actors) %>%
        summarise(avg_score = median(imdb_score)) %>%
        arrange(desc(avg_score)) %>%
        rename("IMDB Critic Score"= "avg_score") %>%
        slice_head(n=20)

    #Now lets combine the two get the table

    top <- cbind(top_directors,top_actors)

    if(Latex){
        tab <- options(xtable.comment = FALSE, caption = "Top Actors and Directors")
        tab <-xtable(top)
    } else {tab <- knitr::kable(top, caption = "Top Actors and Directors")
    }

    tab
}