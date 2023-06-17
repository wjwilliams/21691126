#Now lets look at the most popular songs in each year and put their characteristics into a table to see how popular mustic has evolved. Nevermind there is no popularity variable. Instead lets just do it fot coldplay and metalica
table_popular <- function(battle, Latex = TRUE){

    tabledf <- battle %>%
        mutate(date = ymd(release_date)) %>%
        mutate(year = year(date)) %>%
        group_by(year, Band) %>%
        filter(popularity == max(popularity)) %>%
        ungroup() %>%
        mutate(year = year(date)) %>%
        select(year, Band, name, album, popularity, energy, danceability, tempo, valence) %>%
        arrange(year) %>%
        arrange(Band)


    if(Latex){
        tab <- options(xtable.comment = FALSE, caption = "Most popular songs each year")
        tab <-xtable(tabledf)
    } else {tab <- knitr::kable(tabledf, caption = "Most popular songs each year")
    }
    tab
}