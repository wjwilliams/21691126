wordcloud_plotter <- function(netflix){
    # lets make a list of potential words than will be in the descriptio eg war, romance, exciting
    # Lets try and find the most used words and then map them acrosss the description to find the best most popular movies accordinf to the words in the description

    #make a concatonation of prepositions and common words as they are of no interest to me
    # common_words <- c("a", "an", "the", "and", "but", "or", "so", "for", "of", "to", "from", "in", "on", "at", "by", "with", "without", "that", "this", "these", "those", "is", "are", "was", "were", "am", "be", "being", "been", "has", "have", "had", "do", "does", "did", "can", "could", "will", "would", "shall", "should", "may", "might", "must", "ought", "i", "you", "he", "she", "it", "we", "they", "me", "him", "her", "us", "them", "my", "your", "his", "her", "its", "our", "their", "mine", "yours", "hers", "ours", "theirs", "A", "The", "life")
    #
    # prepositions <- c("about", "above", "across", "after", "against", "along", "among", "around", "at", "before", "behind", "below", "beneath", "beside", "between", "beyond", "but", "by", "concerning", "considering", "despite", "down", "during", "except", "for", "from", "in", "inside", "into", "like", "near", "of", "off", "on", "onto", "out", "outside", "over", "past", "regarding", "round", "since", "through", "throughout", "to", "toward", "under", "underneath", "until", "up", "upon", "with", "within", "without")
    #Okay this isnt going to work so lets go the other way these were found from variious sources on the internet as well as manually going through the list myseld
    value_words <- c(
        "captivating", "compelling", "gripping", "intense", "powerful", "thought-provoking",
        "provocative", "inspiring", "insightful", "riveting", "moving", "emotional", "heartfelt",
        "touching", "exhilarating", "engaging", "mesmerizing", "exciting", "thrilling", "enchanting",
        "fascinating", "suspenseful", "innovative", "original", "brilliant", "exceptional", "masterful",
        "groundbreaking", "unforgettable", "impactful", "mind-bending", "mind-blowing", "war", "historical",
        "drama", "action", "comedy", "thriller", "romance", "horror", "sci-fi", "adventure", "mystery",
        "fantasy", "documentary", "outstanding", "touching", "intense", "insightful", "comical", "charismatic",
        "enjoyable", "first-rate", "uproarious", "absorbing", "sensitive", "riveting", "intriguing", "powerful",
        "fascinating", "pleasant", "thought-provoking", "imaginative", "legendary", "unpretentious", "second-rate",
        "violent", "creepy", "gory", "moronic", "third-rate", "flawed", "boring", "distasteful", "ordinary",
        "disgusting", "brutal", "disappointing", "bloody", "predictable", "uninteresting", "sentimental",
        "fantasy", "romantic", "satirical", "suspenseful", "low-budget", "dramatic", "highly-charged", "controversial", "family",
        "Family", "Death", "love", "Love", "school", "friends", "home", "special", "best", "children", "personal", "relationship", "mysterious",
        "American", "music", "power"
    )




    description <- netflix %>%
        select(description, tmdb_score, type) %>%
        filter(tmdb_score > 7,type =="MOVIE") %>% #we are still only concerned with movies and audience scores of greater than 7
        separate_rows(description, sep = " |, |\\. ") %>%
        filter(description %in% value_words) %>%
        count(description, sort = TRUE)

    #I saw this on R graph gallery and had to give it a go, a word cloud
    library(wordcloud2)
    desc_wordcloud <- wordcloud2::wordcloud2(description, shape = "square")
    desc_wordcloud
}
