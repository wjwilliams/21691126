box_plotter <- function(x, Band = "Coldplay"){
    boxdata <- x %>%
        select(name, album, popularity) %>%
        filter(!is.na(name), !is.na(album), !is.na(popularity)) %>%
        filter(!grepl("Remaster", album),!grepl("Box Set", album), !grepl("Live", album), !grepl("Live", name)) %>%
        group_by(album)

    boxxer<- boxdata %>%
        ggplot()+
        geom_boxplot(aes(x = album, y= popularity, fill = album))+
        theme_bw()+
        labs(title = glue("{Band}'s Popularity by Album"), x = "", y = "Popularity")+
        theme(axis.text.x = element_text(angle = 90, hjust = 1, size = 8)) +
        guides(fill = F)

    boxxer
}