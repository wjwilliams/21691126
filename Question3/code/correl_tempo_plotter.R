correl_tempo_plotter <- function(battle){
    correl <- battle %>%
        select(Band, tempo, popularity) %>%
        ggplot()+
        geom_point(aes(x = tempo, y =popularity, shape = Band, color = Band))+
        geom_smooth(aes(x = tempo, y = popularity, color = Band), method = "loess")+
        labs(title = "Tempo vs Popularity", x = "Tempo", y = "Popularity")+
        theme_bw()+
        theme(legend.position = "top")

    correl
}