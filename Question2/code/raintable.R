raintable <- function(weather, Latex = FALSE){
    #Lastly I want to get look at the rainfall
    #I wanted to use the UK data but unfortunately there is no precipitation
    raindata <- weather %>%
        select(date, precipitation) %>%
        filter(!is.na(precipitation)) %>%
        group_by(date) %>%
        summarise_at(vars(precipitation), ~median(.)) %>%
        rename("Rain" = "precipitation") %>%
        mutate(Month = month(date, label = TRUE, abbr = FALSE )) %>%
        group_by(Month) %>%
        summarise(Rain = mean(Rain)) %>%
        gather(Score, Value, -Month) %>%
        select(Month, Value) %>%
        rename("London" = "Value") %>%
        mutate(London = London*25.4) %>% #conversion from inches to mm
        mutate(`Cape Town` = c(17,16,18,50,72,112,103,90,55,36,32,20))

    yearly_sum <- raindata %>%
        summarise(Month = "Total", London = sum(London), `Cape Town` = sum(`Cape Town`))

    raindata <- bind_rows(raindata, yearly_sum)



    if(Latex){
        tab <- options(xtable.comment = FALSE, caption = "London vs Cape Town Monthly Rainfall")
        tab <-xtable(raindata)
    } else {tab <- knitr::kable(raindata, caption = "London vs Cape Town  Monthly Rainfall")
    }

    tab
}
