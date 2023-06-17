hist_sun_plotter <- function(weather){

    #I want to get the yearly median sunshine score

sundata <- weather %>%
    select(date, sunshine, cloud_cover) %>%
    filter(!is.na(sunshine), !is.na(cloud_cover)) %>%
    mutate(year = year(date)) %>%
    group_by(year) %>%
    summarise(Sunshine = median(sunshine), Cloud = median(cloud_cover))
#There is very little snow so I decided to exclude it
#But i want to add a line to show if sunshine is increasing or decreasing
sunplot <- sundata %>%
    ggplot()+
    geom_line(aes(x = year, y = Sunshine, color = "yellow")) +
    geom_smooth(aes(x = year, y = Sunshine, color = "red"), method = "lm")+
    geom_line(aes(x = year, y = Cloud, color = "gray")) +
    labs(title = "Historical London Sunshine and Cloud Cover", y = "Sunshine & Cloud Cover", x = "Year", caption = "Data: Thank you Fred my friend at the UK National Weather Service" )+
    theme(legend.position = "none")


sunplot
}