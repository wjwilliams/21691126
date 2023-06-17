#I want to look at how downloads/rating per download correspond to app size, I would assume that larger size apps will be downloaded less but may have higher rankings
# sizeunique <- google %>%
#     select(Size) %>%
#     filter(!grepl("M", Size))

correl_tabler<- function(google, Latex = FALSE){
    app <- google %>%
        select(Genres, Rating, Size, Installs) %>%
        mutate(download = as.numeric(gsub("[,\\+]", "", Installs))) %>%
        filter(Size != "Varies with device") %>%
        mutate(size = as.numeric(gsub("M", "", Size))) %>%
        filter(!is.na(size), !is.na(Rating)) %>%
        select(Genres, Rating, size, download) %>%
        separate_rows(Genres, sep = ";") %>%
        group_by(Genres) %>%
        summarise(size_down = cor(download, size, method = "spearman")*100, size_rating = cor(Rating, size, method = "spearman")*100) %>%
        filter(!is.na(size_down), !is.na(size_rating)) %>%
        mutate(size_down = round(size_down), size_rating = round(size_rating) ) %>%
        arrange(-size_rating) %>%
        rename("Rating"= "size_rating", "Downloads" = "size_down") %>%
        mutate(Rating = glue("{Rating}%"), Downloads = glue("{Downloads}%"))

    if(Latex){
        tab <- options(xtable.comment = FALSE, caption = "Correlations with App Size")
        tab <-xtable(app)
    } else {tab <- knitr::kable(app, caption = "Correlations with App Size")
    }

    tab

}