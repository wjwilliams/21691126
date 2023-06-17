category_barplotter <- function(combined){
    # lets look at paid vs free
    prof <- combined %>%
        select(date, App, Category, Type, Rating, download, Price, pos_sentiment) %>%
        group_by(Category, Type) %>%
        summarise_at(vars(download, Rating, pos_sentiment), ~median(.))

    #Lets look at paid apps that are profitable
    #It seems that the paid apps do not have enough reviews for an accurate analysis, this makes sense as they are downloaded less frequbtly and are reviewed at a much lower rate
    free <- prof %>%
        filter(Type == "Free") %>%
        select(Category, Rating, pos_sentiment) %>%
        rename("Positive Review %" = pos_sentiment) %>%
        gather(Score, Value, - Category)
    #They are all downloaded at pretty much the same rate therefre we can exclude the downoads and just look at rating and



    order1 <- free %>%
        filter(Score == "Rating") %>%
        arrange(-Value) %>%
        pull(Category)

    order2 <- free %>%
        filter(Score == "Positive Review %") %>%
        arrange(-Value) %>%
        pull(Category)

    free_plot1 <- free %>%
        filter(Score == "Rating") %>%
        plot_orderset(Column = "Category", Order = order1) %>%
        ggplot() +
        geom_bar(aes(x = Category, y = Value, fill = Category), stat = "identity") +
        scale_fill_viridis_d() +
        theme(legend.position = "none", legend.title = element_blank()) +
        labs(title = "Reviews by Category", x= "", y = "Rating", caption = "Data: Google ")+
        theme(plot.title = element_text(size = 14),
              plot.subtitle = element_text(size = 12),
              axis.text.x = element_text(size = 7, angle = 90))

    free_plot2 <- free %>%
        filter(Score == "Positive Review %") %>%
        plot_orderset(Column = "Category", Order = order2) %>%
        ggplot() +
        geom_bar(aes(x = Category, y = Value, fill = Category), stat = "identity") +
        scale_fill_viridis_d() +
        theme(legend.position = "none", legend.title = element_blank()) +
        labs(title = "Rating by Category", x= "", y = "Positive Review %", caption = "Data: Google ")+
        theme(plot.title = element_text(size = 14),
              plot.subtitle = element_text(size = 12),
              axis.text.x = element_text(size = 7, angle = 90))

    bothplots <- plot_grid(free_plot1, free_plot2, ncol = 1)

    bothplots
}
