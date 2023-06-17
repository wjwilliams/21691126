ICU_Plotter <- function(covid){
    hospital <- covid %>%
        select(date, continent, weekly_icu_admissions, hospital_beds_per_thousand) %>%
        mutate(date = as.Date(date)) %>%
        filter(!is.na(weekly_icu_admissions), !is.na(hospital_beds_per_thousand)) %>%
        rename("icu" = "weekly_icu_admissions", "beds"= "hospital_beds_per_thousand") %>%
        group_by(continent, date = floor_date(date, "month")) %>%
        summarise(`ICU Admissions` = mean(icu), `Beds per thousand`= mean(beds)) %>%
        gather(Score, Value, -date, -continent)

    hospitalplotter <- hospital %>%
        ggplot()+
        geom_line(aes(x = date, y = Value, group = continent, color = continent), alpha = 0.8)+
        geom_text(data = hospital %>% filter(date == max(date) %m-% months(4)), aes(label = continent, color = continent, x = date, y = Value), vjust = 0.5, nudge_y = 0.4, size = 3) +
        facet_wrap(~ Score, scales = "free", ncol = 1)+
        theme(legend.position = "none")+
        labs(title = "ICU Hospitilisations and hospitalization facilities", x = "Date", y = "People", Caption = "Data: Our World in Data")

    hospitalplotter

}
