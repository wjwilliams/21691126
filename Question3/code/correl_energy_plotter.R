correl_energy_plotter <- function(battle){
    correl <- battle %>%
        select(Band, energy, popularity) %>%
        ggplot()+
        geom_point(aes(x = energy, y =popularity, shape = Band, color = Band))+
        geom_smooth(aes(x = energy, y = popularity, color = Band), method = "loess")+
        labs(title = "Energy vs Popularity", x = "Energy", y = "Popularity")+
        theme_bw()+
        theme(legend.position = "top")

    correl
}