evolutionplotter2 <- function(covid){
    #I first want to get the dat and continent at the beginnining as those are the important characteristics of the data
    #I also want to viewit so i can understand whats going on
    covid <- covid %>%
        select(date, continent, everything())
    #view()

    #To start off I just want to plot the evolution of cases and deaths in each continent
    #It seems that continent is left empty for the grouped measures, so we can either try and use the already grouped measures or we can remove them and then we are sleft with just the continents
    evolution <- covid %>%
        mutate(date = as.Date(date)) %>%
        select(date, continent, total_deaths) %>%
        filter(continent != "") %>%
        group_by(date, continent) %>%
        filter(!is.na(total_deaths)) %>%
        summarise(avg_cases = mean(total_deaths)/1000 ) %>%
        ungroup()

    #Now that we have a nice clean and long dataframe it can be plotted, I also dont want a legend and instead want labels at the end of the graph

    evolutionplot <- evolution %>%
        ggplot() +
        geom_line(aes(x = date, y = avg_cases, group = continent, color = continent), alpha = 0.8, size = 1) +
        geom_text(data = evolution %>% filter(date == max(date)%m-% months(2)), aes(label = continent, color = continent, x = date, y = avg_cases), vjust = 0, nudge_y = 0.4, size = 3) +
        theme_bw() +
        labs(title = "The evolution of Total Deaths of COVID-19", subtitle = "by Continent", x = "Date", y = "Total deaths (in Thousands)", caption = "Date source: Our World in Data")+
        theme(legend.position = "none", legend.title = element_blank())+
        guides(fill = F)



    evolutionplot

}

