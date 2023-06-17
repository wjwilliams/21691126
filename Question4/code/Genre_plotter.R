Genre_plotter <- function(netflix){
    #Lets look at the genres now, I want to try and get the most popular genres and construct a barplot
    #first i need to seperate the genres if a movie is categorised as more than one
    genre <- netflix %>%
        select(genres, imdb_score, tmdb_score, tmdb_popularity,type) %>%
        filter(type == "MOVIE") %>%
        select(everything(), -type) %>%
        filter(!is.na(genres), !is.na(imdb_score), !is.na(tmdb_score), !is.na(tmdb_popularity)) %>%
        separate_rows(genres, sep = "\\['|'\\],|, '| \\['|\\. |'") %>%
        filter(!grepl("]", genres), genres != "", genres != " ") %>%
        rename("Critic" = "imdb_score", "Audience" = "tmdb_score", "Popularity" ="tmdb_popularity") %>%
        group_by(genres) %>%
        summarise_at(vars(Critic, Audience, Popularity), ~median(.)) %>%
        gather(Score, Value, -genres)
    # view()

    #Now i want to find the most popular genres
    # unique(genre$genres)
    #there are 19 unique genres

    #Lets ensure it is in the order of popularity
    order <- genre %>%  arrange()
    #Lets make a bar plot with all the different ratings
    barplot1<- genre %>%
        mutate(genres = reorder(genres, -Value)) %>%
        ggplot()+
        geom_bar(aes(x=genres, y =Value, fill = Score), stat = "identity", position = "dodge")+
        geom_hline(yintercept = 6.5, linetype = "dashed", color = "purple")+
        theme_bw()+
        labs(title = "Best and most popular Genres", x = "Genre", y = "Score/Popularity")+
        theme(legend.position = "top", legend.title = element_blank())+
        theme(plot.title = element_text(size = 14),
              plot.subtitle = element_text(size = 12))+
        theme(axis.text.x = element_text(angle = 90, hjust = 1, size = 12))


    barplot1
}