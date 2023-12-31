# Purpose

This is the final README, it is a compilation of all the questions.

``` r
rm(list = ls()) # Clean your environment:
gc() # garbage collection - It can be useful to call gc after a large object has been removed, as this may prompt R to return memory to the operating system.
```

    ##          used (Mb) gc trigger (Mb) limit (Mb) max used (Mb)
    ## Ncells 463822 24.8     990544   53         NA   669322 35.8
    ## Vcells 866077  6.7    8388608   64      16384  1839981 14.1

``` r
#NB load the tidyverse
library(tidyverse)
```

    ## ── Attaching packages ─────────────────────────────────────── tidyverse 1.3.2 ──
    ## ✔ ggplot2 3.4.0     ✔ purrr   1.0.1
    ## ✔ tibble  3.2.1     ✔ dplyr   1.1.0
    ## ✔ tidyr   1.3.0     ✔ stringr 1.5.0
    ## ✔ readr   2.1.4     ✔ forcats 0.5.2
    ## ── Conflicts ────────────────────────────────────────── tidyverse_conflicts() ──
    ## ✖ dplyr::filter() masks stats::filter()
    ## ✖ dplyr::lag()    masks stats::lag()

``` r
#Loading all the code from all 5 locations, this enables me to use all the functions that I have created for all of the seperate Questions
list.files('code/', full.names = T, recursive = T) %>% .[grepl('.R', .)] %>% as.list() %>% walk(~source(.))
list.files('Question1/code/', full.names = T, recursive = T) %>% .[grepl('.R', .)] %>% as.list() %>% walk(~source(.))
list.files('Question2/code/', full.names = T, recursive = T)%>% .[grepl('.R', .)]  %>% as.list() %>% walk(~source(.))
list.files('Question3/code/', full.names = T, recursive = T) %>% .[grepl('.R', .)] %>% as.list() %>% walk(~source(.))
list.files('Question4/code/', full.names = T, recursive = T) %>% .[grepl('.R', .)] %>% as.list() %>% walk(~source(.))
list.files('Question5/code/', full.names = T, recursive = T) %>% .[grepl('.R', .)] %>% as.list() %>% walk(~source(.))
```

# Question 1

``` r
library(tidyverse)
library(xtable)
library(lubridate)
```

    ## Loading required package: timechange

    ## 
    ## Attaching package: 'lubridate'

    ## The following objects are masked from 'package:base':
    ## 
    ##     date, intersect, setdiff, union

``` r
library(glue)
library(ggplot2)
library(cowplot)
```

    ## 
    ## Attaching package: 'cowplot'

    ## The following object is masked from 'package:lubridate':
    ## 
    ##     stamp

``` r
library(rmsfuns)

#Source my code/funcrions
list.files('Question/code/', full.names = T, recursive = T) %>% .[grepl('.R', .)] %>% as.list() %>% walk(~source(.))
#First lets load the data in

covid <- read.csv("Question1/data/Covid/owid-covid-data.csv")
deaths <- read.csv("Question1/data/Covid/Deaths_by_cause.csv")
```

## Africa and Covid

Covid-19 was a global catastrophe and it is no secret that different
parts of the world were effected differently. The figures below show the
total number of cases and total number of deaths by continent. It was
common belief at the start of the pandemic that Africa would be effected
the most due to the high levels of poverty, lack of health
infrastructure compared to the rest of the world and areas with high
population density. These figures show that this was a misconception as
Africa has the least amount of cases and second least amount of deaths.
Mismeasurement is of course a concern but it is highly unlikely that it
would change the results substantially as Oceania is the closest with
respect to total cases and they has nearly double the amount of total
cases. Again when looking at deaths the gap between Asia and Africa is
so large that mismeasurement is not a valid excuse. It would be highly
informative to attempt to quantify why this was the case. I am of the
opinion that Africans have better immune systems due to the standard of
living on the continent that it was easier to fight the virus. South
America on the other hand was effected the most and as I show later this
can be partially attributed to the the lack of change in hospital
facilities.

``` r
ep1 <- evolutionplotter(covid)
```

    ## `summarise()` has grouped output by 'date'. You can override using the
    ## `.groups` argument.

``` r
ep2 <- evolutionplotter2(covid)
```

    ## `summarise()` has grouped output by 'date'. You can override using the
    ## `.groups` argument.

``` r
bothplots <- plot_grid(ep1, ep2, ncol = 1)

bothplots
```

<img src="README_files/figure-markdown_github/unnamed-chunk-2-1.png" alt="Evolution of COVID\label{Figure1}"  />
<p class="caption">
Evolution of COVID
</p>

## Respitory Deaths before and during Covid

Another idea that recieved a lot of attention during the pandemic was
the effect of smoking and the severity of Covid. To investigate this I
found the 3 countries with the highest rate of smokers (Russia, Greece
and Montenegro) all with nearly 90% of their population being smokers
and the 3 countries with the lowest rate of smoking (Ghana, Ethiopia and
Nigeria) all with less than 10% of their populations being smokers. This
could also be a reason as to why Africa was least effected as they have
smaller rate of smokers compared to the rest of the world. The table
shows that the death rates due to respitory illness (which is what Covid
is) increased at a much higher rate for top smoking countries. This
shows that smoking definitely did increase the dangers of Covid.

``` r
SmokerTable <- smoker_death_tabular(covid, Latex = FALSE, CountryList = c("Greece", "Russia", "Montenegro", "Ghana", "Ethiopia", "Nigeria"))
```

    ## `summarise()` has grouped output by 'date'. You can override using the
    ## `.groups` argument.
    ## `summarise()` has grouped output by 'year'. You can override using the
    ## `.groups` argument.

``` r
SmokerTable
```

| year |  Ghana | Ethiopia | Nigeria |   Russia |  Greece | Montenegro |
|-----:|-------:|---------:|--------:|---------:|--------:|-----------:|
| 2017 |  17098 |    48389 |  184438 |    32515 |    5649 |         72 |
| 2018 |  16465 |    47491 |  177834 |    32667 |    5874 |         70 |
| 2019 |  16306 |    46301 |  172978 |    32972 |    5957 |         69 |
| 2020 |  53074 |   200308 |  212680 |  4952659 |  208444 |      45312 |
| 2021 | 315598 |  1582711 |  827562 | 56152636 | 4398618 |     580968 |
| 2022 | 236205 |  1231953 |  520258 | 58131077 | 4426177 |     440539 |

Deaths from Respitory illness

## Hospitalisation Facilities and ICU admissions

For this section I chose to use just three continents (Europe, Asia and
South America). Europe showd that increased hospitilastion facilities
led ICU admissions and in the early stages of 2020 actually helped to
reduce admissions. In Asia, it lagged as it was constant until late 2021
which did lead the final wave of admissions. Lastly, South America
seemed to do nothing to improve hospital facilities and their beds per
thousand of people was constant throughout the whole pandemic which
definitely contributed to being effected the worst out of all the
continents.

``` r
h <- ICU_Plotter(covid)
```

    ## `summarise()` has grouped output by 'continent'. You can override using the
    ## `.groups` argument.

``` r
h
```

<img src="README_files/figure-markdown_github/unnamed-chunk-4-1.png" alt="Evolution of Hospitals\label{Figure2}"  />
<p class="caption">
Evolution of Hospitals
</p>

# Question 2

``` r
library(tidyverse)
library(xtable)
library(lubridate)
library(glue)
library(cowplot)

list.files('Question2/code/', full.names = T, recursive = T) %>% .[grepl('.R', .)] %>% as.list() %>% walk(~source(.))

#read in the data
london <- read.csv("Question2/data/London/london_weather.csv")
UK <- read.csv("Question2/data/London/UKMonthly_Detailed.csv")

#First I need to make sure the date is in the right format using lubridate
weather <- london %>% 
    mutate(date = ymd(date))
```

## Is the weather better in the midlands of England or London?

Let’s start with temperature, The graphs below show that not only does
London have better weather than the midlands, but the maximum
temperature in both places is still colder than Cape town.

``` r
tp <-Temp_plotter(weather, place ="London")


#Lets compare this to the midlands where she wants to move
#First letss limit the sample to just the last 50 years
#names(UK) #get the names in the console fot ease of comparison to the pdf doc
temp <- UK %>% 
    mutate(date = ym(DATE)) %>% 
    select(date, TAVG, TMAX, TMIN) %>% 
    rename("mean_temp" ="TAVG", "min_temp" = "TMIN","max_temp" = "TMAX") #rename so we can use the previous function
tp2 <-Temp_plotter(temp, place ="Midlands")

bothplots <- plot_grid(tp, tp2, ncol = 1)

bothplots
```

<img src="README_files/figure-markdown_github/Figure1-1.png" alt="London Tempreture\label{Figure1}"  />
<p class="caption">
London Tempreture
</p>

## Is it more sunny or cloudy?

Now that it has been shown that the weather is better in the London than
the midlands let’s look at whether London is more sunny than cloudy. The
graph below shows that its has only been more sunny than cloudy for 1
year (2014) since 1978. Not only that but the rate of sunshine seems to
be decreasing over time as well. So it is pretty much colder, more
cloudy and more miserable.

``` r
hs<-hist_sun_plotter(weather)
hs
```

    ## `geom_smooth()` using formula = 'y ~ x'

<img src="README_files/figure-markdown_github/Figure2-1.png" alt="London is getting less and less sunshine \label{Figure2}"  />
<p class="caption">
London is getting less and less sunshine
</p>

## Rain, rain and rain

We all know that Cape Town has winter rain, but that is okay cause that
is when it is cold so you will be inside anyway. In London however it
seems to be raining all the time. In Cape Town we can enjoy summer
because it barely rains but in London its going to be cold in winter,
and then in summer it is just going to rain. I hope you find a lovely
house if you do move because you are going to be spending most of your
time inside.

``` r
rt <- raintable(weather, Latex = FALSE)
rt
```

| Month     |    London | Cape Town |
|:----------|----------:|----------:|
| January   |  46.93538 |        17 |
| February  |  37.90725 |        16 |
| March     |  35.57757 |        18 |
| April     |  36.00551 |        50 |
| May       |  39.75882 |        72 |
| June      |  41.20288 |       112 |
| July      |  36.95202 |       103 |
| August    |  41.78320 |        90 |
| September |  38.72694 |        55 |
| October   |  55.65955 |        36 |
| November  |  50.21540 |        32 |
| December  |  47.35286 |        20 |
| Total     | 508.07736 |       621 |

London vs Cape Town Monthly Rainfall

# Question 3

``` r
library(tidyverse)
library(xtable)
library(lubridate)
library(ggplot2)
library(glue)
library(cowplot)
library(rmsfuns)

#Source my code/funcrions
list.files('Question3/code/', full.names = T, recursive = T) %>% .[grepl('.R', .)] %>% as.list() %>% walk(~source(.))

#Read in the data
cold <- read.csv("Question3/data/Coldplay_vs_Metallica/Coldplay.csv")
cold <- cold %>% 
    rename("album" = "album_name")
metal <- read.csv("Question3/data/Coldplay_vs_Metallica/Metallica.csv")
spotify <- read.csv("Question3/data/Coldplay_vs_Metallica/Broader_Spotify_Info.csv")
```

# Popularity by album

The two figures below show that Coldplay’s discography is slightly more
volatile than Metallica’s in terms of popularity but overall are more
popular.

``` r
#Firstly lets make a function to get the boxplots for both bands


  
coldbp<-box_plotter(cold, Band = "Coldplay")
coldbp
```

<img src="README_files/figure-markdown_github/unnamed-chunk-8-1.png" alt="Coldplay\label{Figure1}"  />
<p class="caption">
Coldplay
</p>

``` r
metalbp<-box_plotter(metal, Band = "Metallica")
metalbp
```

<img src="README_files/figure-markdown_github/unnamed-chunk-9-1.png" alt="Metallics\label{Figure2}"  />
<p class="caption">
Metallics
</p>

``` r
#I think Linkin Park is a fantastic example of a Band that has chnaged what they do and are still popular

# linkin <- spotify %>%
#     filter(artist == "Linkin Park") %>%
#     select(energy,)

#Now lets look at how energy relates to popularity
 #unfortunatly there is no popularity score for LINKIN PARK
```

## Components of each Band: What drives Their Popularity?

Now I show the correlation of identifying factors of both bands with
popularity. I start with energy and it seems that firstly Coldplay are
much more diverse as they have songs ranging from nearly 0 whereas
Metallica’s songs are clusered close to 1. Coldplay seem to have an
optimal energy level of between 0.4 and 0.6 and Metalica is more popular
between 0.75 and 1.

``` r
 #now lets look at the factors that can influence the popularity, Metallica is a metal band so i would expect tempo and energy to be a prominant factor whereas i would expect coldplay to rely on energy and liveness, first i need to combine the data

cold1 <- cold %>% 
    mutate(Band = "Coldplay") %>% 
    select(release_date, name, album, popularity, energy, danceability, tempo, valence, Band) %>% 
            filter(!grepl("Remaster", album),!grepl("Box Set", album), !grepl("Live", album), !grepl("Live", name))


metal1 <- metal %>% 
    mutate(Band = "Mettalica") %>% 
    select(release_date, name, album, popularity, energy, danceability, tempo, valence, Band) %>% 
            filter(!grepl("Remaster", album),!grepl("Box Set", album), !grepl("Live", album), !grepl("Live", name))


battle <- bind_rows(cold1, metal1)
    
#Now i want to look at the popularity vs energy and then get different colours and a line for each


ep <- correl_energy_plotter(battle)
ep
```

    ## `geom_smooth()` using formula = 'y ~ x'

<img src="README_files/figure-markdown_github/unnamed-chunk-11-1.png" alt="Metallics\label{Figure3}"  />
<p class="caption">
Metallics
</p>

Next looking at tempo, again Coldplay is more diverse with their songs
ranging from 60 beats per minute to over 200 whereas Metallica only
ranges from 75 to just under 200. Metallica’s popularity increases with
Tempo.

``` r
tp <-correl_tempo_plotter(battle)
tp
```

    ## `geom_smooth()` using formula = 'y ~ x'

<img src="README_files/figure-markdown_github/unnamed-chunk-12-1.png" alt="Metallics\label{Figure4}"  />
<p class="caption">
Metallics
</p>

Lastly I looked at Valence. Valence is a measure of the degree of
positive or negative sentiment associated with a particular experience,
object, or event, typically represented on a scale from 0 to 1, where 0
indicates negative valence and 1 indicates positive valence. It reflects
the subjective assessment of the emotional tone or quality of the
subject matter. Coldplay is more popular with lowe levels so their most
popular songs are more sad songs and Metalica’s popularity increases
with valence so their more upbeat songs are more popular on average.

``` r
vp <- correl_valence_plotter(battle)
vp
```

    ## `geom_smooth()` using formula = 'y ~ x'

<img src="README_files/figure-markdown_github/unnamed-chunk-13-1.png" alt="Metallics\label{Figure5}"  />
<p class="caption">
Metallics
</p>

##Most popular song by album and year. Both Metallica and Coldplay’s
most popular songs seem to have more energy through the years.
Coldplay’s tempo seems to decrease over time wheras Metallica’s tempo
has been relatibely constant.

``` r
pop_table <- table_popular(battle, Latex = FALSE)
pop_table
```

| year | Band      | name                        | album                                                       | popularity | energy | danceability |   tempo | valence |
|---:|:-----|:------------|:-------------------------|-----:|---:|------:|----:|----:|
| 2000 | Coldplay  | Yellow                      | Parachutes                                                  |         91 |  0.661 |        0.429 | 173.372 |   0.285 |
| 2002 | Coldplay  | The Scientist               | A Rush of Blood to the Head                                 |         87 |  0.442 |        0.557 | 146.277 |   0.213 |
| 2005 | Coldplay  | Fix You                     | X&Y                                                         |         85 |  0.417 |        0.209 | 138.178 |   0.124 |
| 2008 | Coldplay  | Viva La Vida                | Viva La Vida or Death and All His Friends                   |         75 |  0.617 |        0.486 | 138.015 |   0.417 |
| 2011 | Coldplay  | Paradise                    | Mylo Xyloto                                                 |         86 |  0.585 |        0.449 | 139.631 |   0.212 |
| 2014 | Coldplay  | A Sky Full of Stars         | Ghost Stories                                               |         87 |  0.675 |        0.545 | 124.970 |   0.162 |
| 2015 | Coldplay  | Hymn for the Weekend        | A Head Full of Dreams                                       |         86 |  0.693 |        0.491 |  90.027 |   0.412 |
| 2018 | Coldplay  | A Head Full of Dreams       | Love in Tokyo                                               |         14 |  0.920 |        0.307 | 122.836 |   0.152 |
| 2019 | Coldplay  | Orphans                     | Everyday Life                                               |         32 |  0.808 |        0.503 | 107.973 |   0.282 |
| 2021 | Coldplay  | My Universe                 | Music Of The Spheres                                        |         84 |  0.711 |        0.573 | 105.006 |   0.470 |
| 1988 | Mettalica | One                         | …And Justice For All                                        |         75 |  0.695 |        0.437 | 102.178 |   0.413 |
| 1991 | Mettalica | Enter Sandman               | Metallica                                                   |         83 |  0.828 |        0.577 | 123.257 |   0.604 |
| 1996 | Mettalica | King Nothing                | Load                                                        |         59 |  0.909 |        0.528 | 112.083 |   0.349 |
| 1997 | Mettalica | Fuel                        | Reload                                                      |         66 |  0.951 |        0.491 | 106.948 |   0.555 |
| 1998 | Mettalica | Whiskey In The Jar          | Garage Inc.                                                 |         76 |  0.970 |        0.511 | 132.986 |   0.566 |
| 2003 | Mettalica | St. Anger                   | St. Anger                                                   |         55 |  0.949 |        0.249 | 185.252 |   0.498 |
| 2004 | Mettalica | Some Kind Of Monster        | Some Kind Of Monster                                        |         32 |  0.937 |        0.339 | 106.981 |   0.633 |
| 2004 | Mettalica | Some Kind Of Monster - Edit | Some Kind Of Monster                                        |         32 |  0.893 |        0.405 | 104.882 |   0.439 |
| 2008 | Mettalica | The Day That Never Comes    | Death Magnetic                                              |         58 |  0.986 |        0.334 | 124.668 |   0.480 |
| 2011 | Mettalica | Brandenburg Gate            | Lulu                                                        |         26 |  0.779 |        0.334 | 122.705 |   0.282 |
| 2013 | Mettalica | The Ecstasy Of Gold         | Metallica Through The Never (Music From The Motion Picture) |         41 |  0.691 |        0.124 |  97.395 |   0.151 |
| 2016 | Mettalica | Hardwired                   | HardwiredTo Self-Destruct (Deluxe)                          |         65 |  0.991 |        0.128 | 186.124 |   0.530 |
| 2023 | Mettalica | 72 Seasons                  | 72 Seasons                                                  |         71 |  0.981 |        0.196 | 168.183 |   0.403 |

Most popular songs each year

# Question 4

``` r
library(tidyverse)
library(lubridate)
library(glue)
library(xtable)
library(RColorBrewer)


#Source my code/funcrions
list.files('Question4/code/', full.names = T, recursive = T) %>% .[grepl('.R', .)] %>% as.list() %>% walk(~source(.))

#read in the data
credits <- read.csv("Question4/data/netflix/credits.csv")
title <- read.csv("Question4/data/netflix/titles.csv")
```

# Best Actors and Directors

``` r
#Lets try and merge the data to do this I want to get the credits data into a long format with the row for each movie/series
check<-unique(credits$role)
#There are only actors and directors so I need to differentiate between them 
credit <- credits %>% 
  group_by(id) %>% 
  summarise(actors = paste(name[role == "ACTOR"], collapse = ", "),
            directors = paste(name[role == "DIRECTOR"], collapse = ", "),
            .groups = "drop")

#Now i can left join the credits to the title
netflix <- left_join(title, credit, by = "id")
# Now i have a merged data set with the actors and directors and i want to look at which actors and directors are associated with the top movies
```

Below are tables of actors that on average have the best average critic
ratings and audience ratings. It would be beneficial to have any movies
that has these actors and directors as they are likely to be the most
highest rated movies.

``` r
toptable <-top_table(netflix, Latex = FALSE)
toptable
```

| directors              | IMDB Critic Score | actors             | IMDB Critic Score |
|:--------------------|----------------:|:-----------------|----------------:|
| Alastair Fothergill    |              9.00 | Hassan Mostafa     |               9.0 |
| Jonathan Hughes        |              9.00 | Karima Mokhtar     |               9.0 |
| Keith Scholey          |              9.00 | Karthik Rathnam    |               9.0 |
| Samir Al Asfory        |              9.00 | Kesava Karri       |               9.0 |
| Robert Zemeckis        |              8.80 | Krishna            |               9.0 |
| Sơn Tùng M-TP          |              8.80 | Max Hughes         |               9.0 |
| Kazim Al Qallaf        |              8.70 | Nadia Shukry       |               9.0 |
| Amy Segal              |              8.60 | Nithya Sree        |               9.0 |
| Lenin Bharathi         |              8.60 | Praneeta Patnaik   |               9.0 |
| Shantrelle P. Lewis    |              8.60 | Praveena Paruchuri |               9.0 |
| Abhijeet Deshpande     |              8.50 | Radha Bessy        |               9.0 |
| Madhumita              |              8.50 | Saeed Saleh        |               9.0 |
| Thom Zimny             |              8.50 | Younes Shalaby     |               9.0 |
| Louis C.K.             |              8.40 | Adam Cole          |               8.8 |
| Paresh Mokashi         |              8.40 | Al Harrington      |               8.8 |
| R. Parthiban           |              8.40 | Bob Harks          |               8.8 |
| Selçuk Metin           |              8.40 | Bob Penny          |               8.8 |
| Thiagarajan Kumararaja |              8.40 | Brendan Shanahan   |               8.8 |
| Bo Burnham             |              8.35 | Bryan Hanna        |               8.8 |
| Aamir Khan             |              8.30 | Byron Minns        |               8.8 |

Top Actors and Directors

``` r
#Lets also do it for audience scores

aud_top<-audience_top_table(netflix, Latex = FALSE)
aud_top
```

| directors            | IMDB Audience Score | actors             | IMDB audience Score |
|:------------------|-----------------:|:----------------|-----------------:|
| Rick Suvalle         |               10.00 | Aaron Barashi      |                  10 |
| Francis Ford Coppola |                9.80 | Addison Holley     |                  10 |
| Oluseyi Asurf        |                9.50 | Adebimpe Akintunde |                  10 |
| Fred Ouro Preto      |                9.30 | Ahmed Saif         |                  10 |
| Navaniat Singh       |                9.30 | Akashi Mtenda      |                  10 |
| Vijay Kumar Arora    |                9.30 | Alia Almannai      |                  10 |
| Yacine Belhousse     |                9.30 | Blessing Lung’aho  |                  10 |
| Hasan Abduselam      |                9.20 | Bukola Oshibowale  |                  10 |
| Selçuk Metin         |                9.10 | Calabar Chic       |                  10 |
| Bodunrin Sasore      |                9.00 | Dai Tabuchi        |                  10 |
| Manish Saini         |                9.00 | David Bedella      |                  10 |
| Seko Shamte          |                9.00 | Derek McGrath      |                  10 |
| Shazia Ali Khan      |                9.00 | Evany Rosen        |                  10 |
| Thomas Astruc        |                9.00 | Eve D’souza        |                  10 |
| Ulises Valencia      |                8.85 | Fidel Maithya      |                  10 |
| Amy Segal            |                8.80 | Henri Charles      |                  10 |
| Choi Jin-sung        |                8.80 | Ibrahim Almeirasi  |                  10 |
| Joe Guidry           |                8.80 | Ibrahim Osward     |                  10 |
| Steve Rolston        |                8.70 | Jacob Steven       |                  10 |
| Amp Wong             |                8.60 | Jazz Mistri        |                  10 |

Top Actors and Directors

## Genres to Focus on

Below is a plot of the audience and critic rated most popular movies by
genre. There is a line at 6.5 to show movie genres that consistently get
good ratings. If you want the best rated genres I would suggest getting
historical war movies, documentaries and music movies. If you care more
about popularity I would suggest animation, sci-fi fantasy, western and
action. I think the best movies to have are war movies as they are the
best of both worlds.

``` r
gp<-Genre_plotter(netflix)
gp
```

<img src="README_files/figure-markdown_github/unnamed-chunk-19-1.png" alt="Popularity and Ratings by Grenre\label{Figure1}"  />
<p class="caption">
Popularity and Ratings by Grenre
</p>

## Words in descriptions

Lastly I show a wordcloud of the most popular words in descriptions of
movies that have a audience rating of more than 7. This shows what the
best movies use to market themselves and what the most popular themes
among audiences. Clearly movies about love, friends and family are the
most popular.

``` r
 wc<-wordcloud_plotter(netflix)
 
#Unfortunately i needed to save it as a png 
```

![WordCloud](wordcloud.png)

# Question 5

``` r
library(tidyverse)
library(xtable)
library(lubridate)
library(glue)
library(cowplot)
library(RColorBrewer)
library(viridis)  
```

    ## Loading required package: viridisLite

``` r
list.files('Question5/code/', full.names = T, recursive = T) %>% .[grepl('.R', .)] %>% as.list() %>% walk(~source(.))

#load in the data
review <- read.csv("Question5/data/googleplay/googleplaystore_user_reviews.csv")
google <- read.csv("Question5/data/googleplay/googleplaystore.csv")
```

## Ratings and Positive Reviews by Category

If you want to create an App it is very important that as soon after its
inception it gets as many reviews and ratings as possible but you also
want high ratings and positive reviews. This will help your App gain
momentum as people are more likely to download your App if it has
already been rated and reviewed as it creates a sense of trust. Below I
have created the average reviews and positive ratings by category. I
limited it to the top 50% of downloads as I wanted to only imvestigate
sucessful Apps. From this i would recommend an App under the Art and
Design category as those apps get rated the most highly and have the
most positive reviews.

``` r
#First lets get a date
google <-google %>% 
    mutate(date = mdy(Last.Updated))




#Lets see the average installs and then we only want to look at the top half
#we first need to get the installs to dbl
downloads <- google %>% 
    group_by(Type)%>% 
    mutate(download = as.numeric(gsub("[,\\+]", "", Installs))) %>% 
    summarise(avg_down = mean(download))
#the average download is 9387454 for free apps  and 77439.49 for paid apps but we only want to look at above average apps
good_apps<- google %>% 
    filter(!is.na(Installs), !is.na(Type)) %>% 
    mutate(download = as.numeric(gsub("[,\\+]", "", Installs))) %>% 
    filter(ifelse(Type == "Free", download > 8657758, download >  77439.49))

#now lets combine the datasets
# unique(review$Sentiment)

reviews <- review %>% 
    group_by(App) %>% 
    filter(!grepl("nan", Sentiment), !is.na(Sentiment)) %>% 
    summarise(pos_sentiment = sum(Sentiment == "Positive")/n() ) 

combined <- left_join(good_apps, reviews, by = "App") %>% 
    filter(!is.na(pos_sentiment))
```

``` r
cb<-category_barplotter(combined)
cb
```

<img src="README_files/figure-markdown_github/unnamed-chunk-23-1.png" alt="Ratings and Reviews by Category\label{Figure1}"  />
<p class="caption">
Ratings and Reviews by Category
</p>

## Does App Size affect Downloads and Ratings?

The next step in the optimization process of the app is determining how
large it should be. It os a highly common in the modern era to delete
Apps that are rather large to ensure your device has sufficient memory.
The table below shows the correlation of size with downloads and ratings
this information can help evaluate the trade-off between size,
functionality and scope of your App. Following from my recommendation
above, Art and design applications are downloaded more if they are
larger and there is no large correlation between the Rating and the size
so I would recommend ensuring functionality and scope of the App as the
size is of little concern as people do not seem deterred from
downloading apps in this genre if they are large.

``` r
ct<- correl_tabler(google, Latex = FALSE)
```

    ## Warning: There was 1 warning in `mutate()`.
    ## ℹ In argument: `size = as.numeric(gsub("M", "", Size))`.
    ## Caused by warning:
    ## ! NAs introduced by coercion

``` r
ct
```

| Genres                  | Downloads | Rating |
|:------------------------|:----------|:-------|
| Card                    | 56%       | 40%    |
| Trivia                  | 34%       | 35%    |
| Arcade                  | 47%       | 27%    |
| Weather                 | 23%       | 26%    |
| Personalization         | -9%       | 25%    |
| Photography             | 48%       | 25%    |
| Music & Video           | -10%      | 22%    |
| Racing                  | 1%        | 21%    |
| Role Playing            | 39%       | 21%    |
| Events                  | 24%       | 20%    |
| Casual                  | 29%       | 15%    |
| Health & Fitness        | 27%       | 15%    |
| House & Home            | 16%       | 15%    |
| Strategy                | 35%       | 15%    |
| Action & Adventure      | 35%       | 13%    |
| Productivity            | 7%        | 13%    |
| Comics                  | 37%       | 12%    |
| Puzzle                  | 29%       | 12%    |
| Brain Games             | 25%       | 9%     |
| Board                   | 5%        | 8%     |
| Communication           | 31%       | 8%     |
| Music                   | 25%       | 8%     |
| Beauty                  | 47%       | 7%     |
| Business                | 24%       | 7%     |
| Parenting               | 8%        | 6%     |
| Action                  | 19%       | 5%     |
| Maps & Navigation       | 25%       | 5%     |
| Pretend Play            | 21%       | 5%     |
| Social                  | 37%       | 5%     |
| Books & Reference       | 19%       | 4%     |
| Simulation              | 31%       | 4%     |
| Medical                 | 7%        | 2%     |
| Word                    | 44%       | 2%     |
| Auto & Vehicles         | 6%        | 1%     |
| Casino                  | 28%       | 1%     |
| Video Players & Editors | 32%       | 1%     |
| Sports                  | 46%       | -1%    |
| Tools                   | 14%       | -1%    |
| Art & Design            | 54%       | -2%    |
| Libraries & Demo        | 24%       | -5%    |
| Education               | 29%       | -6%    |
| Entertainment           | 39%       | -6%    |
| Shopping                | 53%       | -6%    |
| Adventure               | 19%       | -10%   |
| Dating                  | 25%       | -10%   |
| Finance                 | 42%       | -14%   |
| Lifestyle               | 32%       | -14%   |
| Educational             | -4%       | -18%   |
| Food & Drink            | 36%       | -18%   |
| News & Magazines        | 31%       | -22%   |
| Travel & Local          | 26%       | -22%   |
| Creativity              | -7%       | -26%   |

Correlations with App Size
