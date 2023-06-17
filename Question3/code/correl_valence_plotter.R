correl_valence_plotter <- function(battle){
    correl <- battle %>%
        select(Band, valence, popularity) %>%
        ggplot()+
        geom_point(aes(x = valence, y =popularity, shape = Band, color = Band))+
        geom_smooth(aes(x = valence, y = popularity, color = Band), method = "loess")+
        labs(title = "Valence vs Popularity", x = "Valence", y = "Popularity")+
        theme_bw()+
        theme(legend.position = "top")

    correl
}