
#Now let's look at concentrated groupings, I would like look at smoking, to do this I think it is appropriate to look at the top smoking countries and the bottom smoking countries we can then plot the deaths from repository diseases as that is what COVID was and then the deaths from COVID

#first we need to identify the countries with the most smokers

smoker_death_tabular <- function(covid, Latex = TRUE,  CountryList = c("Greece", "Russia", "Montenegro", "Ghana", "Ethiopia", "Nigeria")){
    covid1 <- covid %>%
        mutate(date = as.Date(date))

    smoker <- covid1 %>%
        mutate(smokers = male_smokers + female_smokers) %>%
        filter(!is.na(date) & !is.na(location) & !is.na(total_deaths) & !is.na(smokers)) %>%
        group_by(date, location) %>%
        summarise(deaths = mean(total_deaths),
                  smokers = mean(smokers)) %>%
        ungroup() %>% #I want the yearly deaths so i have to sum the deaths but get the mean of smokers to make it comparable
        mutate(year = lubridate::year(date)) %>%
        group_by(year, location) %>%
        summarise(yearly_deaths = sum(deaths),
                  smokers = mean(smokers)) %>%
        arrange(smokers)

    # now we need to add rows for the precovid deaths and select the top 3 and bottom three countries which are Greece, Montenegro and Russia and the bottom are Ghana, Ethiopia and Nigeria

    smokerplot <- smoker%>%
        filter(location %in% CountryList)

    #now we need to add the rows

    smokerdeath <- deaths %>%
        select(Entity, Year, Deaths...Lower.respiratory.infections...Sex..Both...Age..All.Ages..Number.) %>% rename("yearly_deaths" = "Deaths...Lower.respiratory.infections...Sex..Both...Age..All.Ages..Number.", "location" = "Entity", "year" ="Year") %>%
        filter(location %in% CountryList) %>%
        drop_na()

    smokerfinal <- bind_rows(smokerplot, smokerdeath) %>%
        select(year, location, yearly_deaths) %>%
        filter(year > 2016) %>%
        group_by(location) %>%
        pivot_wider(names_from = location, values_from = yearly_deaths) %>%
        arrange(year)

    if(Latex){
    tab <- options(xtable.comment = FALSE, caption = "Deaths from Respitory illness")
    tab <-xtable(smokerfinal)
    } else {tab <- knitr::kable(smokerfinal, caption = "Deaths from Respitory illness")
    }

    tab

}