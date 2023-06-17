Temp_plotter <- function(weather, place = "Unknown"){
    # I now want to get the average mean, max and min temp for each month


    bardata <- weather %>%
        mutate(month = month(date, label = TRUE)) %>%
        filter(!is.na(mean_temp),!is.na(min_temp), !is.na(max_temp)) %>%
        group_by(month) %>%
        summarise_at(vars(c(mean_temp, min_temp, max_temp)), ~median(.)) %>%
        rename("Minimum Temperature" = "min_temp",
               "Maximum Temperature" = "max_temp",
               "Average Temperature" = "mean_temp") %>%
        mutate(`Cape Town`= c(13,13,14,16,17,19, 20,20,19,17,15,14)) %>% #I have ordered the cape town weather from June to July so that the seasons match
        gather(Score, Value, -month)


    library(ggplot2)

    barplot1<- bardata %>%
        ggplot()+
        geom_bar(aes(month, Value, fill = Score), stat = "identity", position = "dodge")+
        theme_bw()+ #appropriate cause it is always dark
        labs(title = glue("{place} Tempreture"), x = "Month", y = "Tempereture", caption= "Data: UK National Weather Service and Climate Data (en.climate-data.org)")+
        theme(legend.position = "top", legend.title = element_blank())+
        theme(plot.title = element_text(size = 14),
              plot.subtitle = element_text(size = 12))


    barplot1
}